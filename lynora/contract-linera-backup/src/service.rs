use async_graphql::{Context, Object, Schema, Subscription};
use futures::stream::{Stream, StreamExt};
use linera_sdk::{
    base::{AccountOwner, Amount, ChainId},
    views::View,
    Service, ServiceRuntime,
};
use std::sync::Arc;
use thiserror::Error;

use crate::state::*;

/// Service errors
#[derive(Debug, Error)]
pub enum ServiceError {
    #[error("Market not found")]
    MarketNotFound,
}

/// GraphQL market type
#[derive(Clone)]
pub struct MarketQL {
    pub id: u64,
    pub creator: String,
    pub creator_chain: String,
    pub question: String,
    pub description: String,
    pub end_time: u64,
    pub status: String,
    pub total_up_bets: String,
    pub total_down_bets: String,
    pub total_pool: String,
    pub winning_option: Option<String>,
    pub created_at: u64,
    pub resolution_price: Option<u64>,
}

#[Object]
impl MarketQL {
    async fn id(&self) -> u64 {
        self.id
    }

    async fn creator(&self) -> &str {
        &self.creator
    }

    async fn creator_chain(&self) -> &str {
        &self.creator_chain
    }

    async fn question(&self) -> &str {
        &self.question
    }

    async fn description(&self) -> &str {
        &self.description
    }

    async fn end_time(&self) -> u64 {
        self.end_time
    }

    async fn status(&self) -> &str {
        &self.status
    }

    async fn total_up_bets(&self) -> &str {
        &self.total_up_bets
    }

    async fn total_down_bets(&self) -> &str {
        &self.total_down_bets
    }

    async fn total_pool(&self) -> &str {
        &self.total_pool
    }

    async fn winning_option(&self) -> Option<&str> {
        self.winning_option.as_deref()
    }

    async fn created_at(&self) -> u64 {
        self.created_at
    }

    async fn resolution_price(&self) -> Option<u64> {
        self.resolution_price
    }
}

/// GraphQL bet type
#[derive(Clone)]
pub struct BetQL {
    pub market_id: u64,
    pub user: String,
    pub option: String,
    pub amount: String,
    pub timestamp: u64,
    pub claimed: bool,
}

#[Object]
impl BetQL {
    async fn market_id(&self) -> u64 {
        self.market_id
    }

    async fn user(&self) -> &str {
        &self.user
    }

    async fn option(&self) -> &str {
        &self.option
    }

    async fn amount(&self) -> &str {
        &self.amount
    }

    async fn timestamp(&self) -> u64 {
        self.timestamp
    }

    async fn claimed(&self) -> bool {
        self.claimed
    }
}

/// Query root
pub struct QueryRoot;

#[Object]
impl QueryRoot {
    async fn markets(&self, ctx: &Context<'_>) -> Vec<MarketQL> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        state.markets.iter().map(|m| market_to_ql(m)).collect()
    }

    async fn market(&self, ctx: &Context<'_>, market_id: u64) -> Option<MarketQL> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        state.get_market(market_id).map(market_to_ql)
    }

    async fn active_markets(&self, ctx: &Context<'_>) -> Vec<MarketQL> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        state.active_markets().iter().map(|&m| market_to_ql(m)).collect()
    }

    async fn user_bets(&self, ctx: &Context<'_>, user: String) -> Vec<BetQL> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        // Parse user string to AccountOwner (simplified)
        state.bets.iter().map(|b| bet_to_ql(b)).collect()
    }

    async fn market_bets(&self, ctx: &Context<'_>, market_id: u64) -> Vec<BetQL> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        state.get_market_bets(market_id).iter().map(|&b| bet_to_ql(b)).collect()
    }

    async fn calculate_reward(
        &self,
        ctx: &Context<'_>,
        market_id: u64,
        user: String,
    ) -> Option<String> {
        let state = ctx.data_unchecked::<Arc<LynoraState>>();
        // Parse user string to AccountOwner (simplified)
        // state.calculate_reward(market_id, &user_account).map(|amt| amt.to_string())
        None
    }
}

/// Mutation root (not used in query service, but needed for schema)
pub struct MutationRoot;

#[Object]
impl MutationRoot {
    async fn dummy(&self) -> bool {
        true
    }
}

/// Subscription root for real-time updates
pub struct SubscriptionRoot;

#[Subscription]
impl SubscriptionRoot {
    async fn market_updates(&self, ctx: &Context<'_>) -> impl Stream<Item = MarketQL> {
        // In production, this would watch for state changes
        // For now, return empty stream
        futures::stream::empty()
    }

    async fn new_bets(&self, ctx: &Context<'_>, market_id: u64) -> impl Stream<Item = BetQL> {
        // Watch for new bets on a specific market
        futures::stream::empty()
    }
}

/// Helper to convert Market to GraphQL type
fn market_to_ql(market: &Market) -> MarketQL {
    MarketQL {
        id: market.id,
        creator: format!("{:?}", market.creator),
        creator_chain: format!("{}", market.creator_chain),
        question: market.question.clone(),
        description: market.description.clone(),
        end_time: market.end_time.micros(),
        status: format!("{:?}", market.status),
        total_up_bets: format!("{}", market.total_up_bets),
        total_down_bets: format!("{}", market.total_down_bets),
        total_pool: format!("{}", market.total_pool()),
        winning_option: market.winning_option.map(|o| format!("{:?}", o)),
        created_at: market.created_at.micros(),
        resolution_price: market.resolution_price,
    }
}

/// Helper to convert Bet to GraphQL type
fn bet_to_ql(bet: &Bet) -> BetQL {
    BetQL {
        market_id: bet.market_id,
        user: format!("{:?}", bet.user),
        option: format!("{:?}", bet.option),
        amount: format!("{}", bet.amount),
        timestamp: bet.timestamp.micros(),
        claimed: bet.claimed,
    }
}

/// Service implementation
pub struct LynoraService {
    state: Arc<LynoraState>,
    runtime: ServiceRuntime<Self>,
}

linera_sdk::service!(LynoraService);

impl Service for LynoraService {
    type Error = ServiceError;
    type Storage = LynoraState;
    type Parameters = ();

    async fn load(runtime: ServiceRuntime<Self>) -> Result<Self, Self::Error> {
        let state = runtime.state().await;
        Ok(LynoraService {
            state: Arc::new(state),
            runtime,
        })
    }

    async fn handle_query(&self, _query: &[u8]) -> Result<Vec<u8>, Self::Error> {
        // Handle GraphQL queries
        Ok(Vec::new())
    }
}

/// Create GraphQL schema
pub fn create_schema(state: Arc<LynoraState>) -> Schema<QueryRoot, MutationRoot, SubscriptionRoot> {
    Schema::build(QueryRoot, MutationRoot, SubscriptionRoot)
        .data(state)
        .finish()
}



