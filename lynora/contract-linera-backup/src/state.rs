use linera_sdk::base::{AccountOwner, Amount, ChainId, Timestamp};
use serde::{Deserialize, Serialize};

/// Betting option: UP or DOWN
#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub enum BetOption {
    Up,
    Down,
}

/// Market status
#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub enum MarketStatus {
    Active,
    Locked,
    Resolved,
}

/// Prediction market
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Market {
    pub id: u64,
    pub creator: AccountOwner,
    pub creator_chain: ChainId,
    pub question: String,
    pub description: String,
    pub end_time: Timestamp,
    pub status: MarketStatus,
    pub total_up_bets: Amount,
    pub total_down_bets: Amount,
    pub winning_option: Option<BetOption>,
    pub created_at: Timestamp,
    pub resolution_price: Option<u64>,
}

impl Market {
    pub fn total_pool(&self) -> Amount {
        self.total_up_bets.saturating_add(self.total_down_bets)
    }

    pub fn is_active(&self) -> bool {
        self.status == MarketStatus::Active
    }

    pub fn is_resolved(&self) -> bool {
        self.status == MarketStatus::Resolved
    }
}

/// User bet on a market
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bet {
    pub market_id: u64,
    pub user: AccountOwner,
    pub option: BetOption,
    pub amount: Amount,
    pub timestamp: Timestamp,
    pub claimed: bool,
}

/// Application state
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct LynoraState {
    /// All markets created
    pub markets: Vec<Market>,
    /// All bets placed
    pub bets: Vec<Bet>,
    /// Next market ID
    pub next_market_id: u64,
}

impl LynoraState {
    pub fn new() -> Self {
        Self {
            markets: Vec::new(),
            bets: Vec::new(),
            next_market_id: 1,
        }
    }

    pub fn get_market(&self, market_id: u64) -> Option<&Market> {
        self.markets.iter().find(|m| m.id == market_id)
    }

    pub fn get_market_mut(&mut self, market_id: u64) -> Option<&mut Market> {
        self.markets.iter_mut().find(|m| m.id == market_id)
    }

    pub fn get_user_bets(&self, user: &AccountOwner) -> Vec<&Bet> {
        self.bets.iter().filter(|b| &b.user == user).collect()
    }

    pub fn get_market_bets(&self, market_id: u64) -> Vec<&Bet> {
        self.bets.iter().filter(|b| b.market_id == market_id).collect()
    }

    pub fn get_user_bet(&self, market_id: u64, user: &AccountOwner) -> Option<&Bet> {
        self.bets.iter().find(|b| b.market_id == market_id && &b.user == user)
    }

    pub fn get_user_bet_mut(&mut self, market_id: u64, user: &AccountOwner) -> Option<&mut Bet> {
        self.bets.iter_mut().find(|b| b.market_id == market_id && &b.user == user)
    }

    pub fn active_markets(&self) -> Vec<&Market> {
        self.markets.iter().filter(|m| m.is_active()).collect()
    }

    pub fn calculate_reward(&self, market_id: u64, user: &AccountOwner) -> Option<Amount> {
        let market = self.get_market(market_id)?;
        let bet = self.get_user_bet(market_id, user)?;

        if !market.is_resolved() || bet.claimed {
            return None;
        }

        let winning_option = market.winning_option?;
        
        if bet.option != winning_option {
            return Some(Amount::ZERO);
        }

        let total_pool = market.total_pool();
        let winning_pool = match winning_option {
            BetOption::Up => market.total_up_bets,
            BetOption::Down => market.total_down_bets,
        };

        if winning_pool == Amount::ZERO {
            return Some(Amount::ZERO);
        }

        // Reward = (user_bet / winning_pool) * total_pool
        // Simplified calculation: (user_bet * total_pool) / winning_pool
        let bet_amount_value: u128 = bet.amount.into();
        let total_pool_value: u128 = total_pool.into();
        let winning_pool_value: u128 = winning_pool.into();

        let reward_value = (bet_amount_value * total_pool_value) / winning_pool_value;
        
        Some(Amount::from_tokens(reward_value))
    }
}



