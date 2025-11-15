use linera_sdk::{
    base::{AccountOwner, Amount, ChainId, Owner, Timestamp, WithContractAbi},
    contract::system_api,
    Contract, ContractRuntime,
};
use thiserror::Error;

mod state;
pub use state::*;

mod service;
pub use service::*;

/// Contract errors
#[derive(Debug, Error)]
pub enum LynoraError {
    #[error("Market not found")]
    MarketNotFound,
    
    #[error("Market is not active")]
    MarketNotActive,
    
    #[error("Market already resolved")]
    MarketAlreadyResolved,
    
    #[error("Invalid bet amount")]
    InvalidBetAmount,
    
    #[error("User already bet on this market")]
    AlreadyBet,
    
    #[error("No reward to claim")]
    NoReward,
    
    #[error("Reward already claimed")]
    AlreadyClaimed,
    
    #[error("Only creator can resolve market")]
    OnlyCreator,
    
    #[error("Market not ended yet")]
    MarketNotEnded,
    
    #[error("Insufficient balance")]
    InsufficientBalance,
}

/// Application operations
#[derive(Debug, serde::Deserialize, serde::Serialize)]
pub enum Operation {
    /// Create a new prediction market
    CreateMarket {
        question: String,
        description: String,
        duration_minutes: u64,
    },
    
    /// Place a bet on a market
    PlaceBet {
        market_id: u64,
        option: BetOption,
        amount: Amount,
    },
    
    /// Resolve a market
    ResolveMarket {
        market_id: u64,
        winning_option: BetOption,
        resolution_price: u64,
    },
    
    /// Claim reward from a resolved market
    ClaimReward {
        market_id: u64,
    },
}

/// Application messages
#[derive(Debug, serde::Deserialize, serde::Serialize)]
pub enum Message {
    /// Cross-chain market discovery
    MarketCreated {
        market_id: u64,
        creator_chain: ChainId,
    },
}

pub struct LynoraContract {
    state: LynoraState,
    runtime: ContractRuntime<Self>,
}

linera_sdk::contract!(LynoraContract);

impl WithContractAbi for LynoraContract {
    type Abi = lynora::LynoraAbi;
}

impl Contract for LynoraContract {
    type Error = LynoraError;
    type Storage = LynoraState;
    type Message = Message;
    type Parameters = ();

    async fn load(runtime: ContractRuntime<Self>) -> Result<Self, Self::Error> {
        let state = runtime.state().await;
        Ok(LynoraContract { state, runtime })
    }

    async fn instantiate(&mut self, _argument: ()) {
        self.state = LynoraState::new();
    }

    async fn execute_operation(&mut self, operation: Operation) -> Result<(), Self::Error> {
        match operation {
            Operation::CreateMarket { question, description, duration_minutes } => {
                self.create_market(question, description, duration_minutes).await
            }
            Operation::PlaceBet { market_id, option, amount } => {
                self.place_bet(market_id, option, amount).await
            }
            Operation::ResolveMarket { market_id, winning_option, resolution_price } => {
                self.resolve_market(market_id, winning_option, resolution_price).await
            }
            Operation::ClaimReward { market_id } => {
                self.claim_reward(market_id).await
            }
        }
    }

    async fn execute_message(&mut self, _message: Message) -> Result<(), Self::Error> {
        // Handle cross-chain messages if needed
        Ok(())
    }

    async fn store(mut self) {
        self.runtime.state_mut().await.clone_from(&self.state);
    }
}

impl LynoraContract {
    async fn create_market(
        &mut self,
        question: String,
        description: String,
        duration_minutes: u64,
    ) -> Result<(), LynoraError> {
        let creator = self.runtime.authenticated_signer()
            .ok_or(LynoraError::OnlyCreator)?;
        
        let current_time = self.runtime.system_time();
        let end_time = current_time.saturating_add_micros(duration_minutes * 60 * 1_000_000);
        
        let market_id = self.state.next_market_id;
        self.state.next_market_id += 1;
        
        let market = Market {
            id: market_id,
            creator: AccountOwner::User(creator),
            creator_chain: self.runtime.chain_id(),
            question,
            description,
            end_time,
            status: MarketStatus::Active,
            total_up_bets: Amount::ZERO,
            total_down_bets: Amount::ZERO,
            winning_option: None,
            created_at: current_time,
            resolution_price: None,
        };
        
        self.state.markets.push(market);
        
        Ok(())
    }

    async fn place_bet(
        &mut self,
        market_id: u64,
        option: BetOption,
        amount: Amount,
    ) -> Result<(), LynoraError> {
        if amount == Amount::ZERO {
            return Err(LynoraError::InvalidBetAmount);
        }

        let user = self.runtime.authenticated_signer()
            .ok_or(LynoraError::OnlyCreator)?;
        let user_account = AccountOwner::User(user);

        // Check if user already bet
        if self.state.get_user_bet(market_id, &user_account).is_some() {
            return Err(LynoraError::AlreadyBet);
        }

        let market = self.state.get_market_mut(market_id)
            .ok_or(LynoraError::MarketNotFound)?;

        if !market.is_active() {
            return Err(LynoraError::MarketNotActive);
        }

        // Update market totals
        match option {
            BetOption::Up => market.total_up_bets = market.total_up_bets.saturating_add(amount),
            BetOption::Down => market.total_down_bets = market.total_down_bets.saturating_add(amount),
        }

        // Record bet
        let bet = Bet {
            market_id,
            user: user_account,
            option,
            amount,
            timestamp: self.runtime.system_time(),
            claimed: false,
        };

        self.state.bets.push(bet);

        Ok(())
    }

    async fn resolve_market(
        &mut self,
        market_id: u64,
        winning_option: BetOption,
        resolution_price: u64,
    ) -> Result<(), LynoraError> {
        let caller = self.runtime.authenticated_signer()
            .ok_or(LynoraError::OnlyCreator)?;

        let market = self.state.get_market_mut(market_id)
            .ok_or(LynoraError::MarketNotFound)?;

        // Verify caller is creator
        if market.creator != AccountOwner::User(caller) {
            return Err(LynoraError::OnlyCreator);
        }

        if market.is_resolved() {
            return Err(LynoraError::MarketAlreadyResolved);
        }

        // Check if market ended
        let current_time = self.runtime.system_time();
        if current_time < market.end_time {
            return Err(LynoraError::MarketNotEnded);
        }

        market.status = MarketStatus::Resolved;
        market.winning_option = Some(winning_option);
        market.resolution_price = Some(resolution_price);

        Ok(())
    }

    async fn claim_reward(&mut self, market_id: u64) -> Result<(), LynoraError> {
        let user = self.runtime.authenticated_signer()
            .ok_or(LynoraError::OnlyCreator)?;
        let user_account = AccountOwner::User(user);

        let market = self.state.get_market(market_id)
            .ok_or(LynoraError::MarketNotFound)?;

        if !market.is_resolved() {
            return Err(LynoraError::MarketNotActive);
        }

        let bet = self.state.get_user_bet_mut(market_id, &user_account)
            .ok_or(LynoraError::NoReward)?;

        if bet.claimed {
            return Err(LynoraError::AlreadyClaimed);
        }

        let reward = self.state.calculate_reward(market_id, &user_account)
            .ok_or(LynoraError::NoReward)?;

        if reward == Amount::ZERO {
            return Err(LynoraError::NoReward);
        }

        bet.claimed = true;

        // Transfer reward (simplified - in production would use proper token transfers)
        // self.runtime.transfer(user, reward).await?;

        Ok(())
    }
}

/// ABI definition
pub struct LynoraAbi;

impl linera_sdk::abi::ContractAbi for LynoraAbi {
    type Operation = Operation;
    type Response = ();
}



