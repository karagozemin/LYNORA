/**
 * LYNORA - Prediction Market Smart Contract for Massa
 * 
 * This contract enables users to:
 * - Create prediction markets
 * - Place bets (UP or DOWN)
 * - Resolve markets
 * - Claim rewards
 */

import {
  Storage,
  generateEvent,
  Context,
  transferCoins,
  balance,
  caller,
} from '@massalabs/massa-as-sdk';
import {
  Args,
  stringToBytes,
  bytesToString,
  u64ToBytes,
  bytesToU64,
  boolToByte,
} from '@massalabs/as-types';

// ============================================================================
// Storage Keys
// ============================================================================

const NEXT_MARKET_ID_KEY = stringToBytes('NEXT_MARKET_ID');
const MARKET_PREFIX = stringToBytes('MARKET_');
const BET_PREFIX = stringToBytes('BET_');
const USER_BET_PREFIX = stringToBytes('USER_BET_');

// ============================================================================
// Enums
// ============================================================================

enum BetOption {
  UP = 0,
  DOWN = 1,
}

enum MarketStatus {
  ACTIVE = 0,
  LOCKED = 1,
  RESOLVED = 2,
}

// ============================================================================
// Structs
// ============================================================================

class Market {
  id: u64;
  creator: string;
  question: string;
  description: string;
  endTime: u64;
  status: MarketStatus;
  totalUpBets: u64;
  totalDownBets: u64;
  winningOption: i32; // -1 = not set, 0 = UP, 1 = DOWN
  createdAt: u64;
  resolutionPrice: u64;

  constructor(
    id: u64,
    creator: string,
    question: string,
    description: string,
    endTime: u64,
  ) {
    this.id = id;
    this.creator = creator;
    this.question = question;
    this.description = description;
    this.endTime = endTime;
    this.status = MarketStatus.ACTIVE;
    this.totalUpBets = 0;
    this.totalDownBets = 0;
    this.winningOption = -1;
    this.createdAt = Context.timestamp();
    this.resolutionPrice = 0;
  }

  serialize(): StaticArray<u8> {
    const args = new Args();
    args.add(this.id);
    args.add(this.creator);
    args.add(this.question);
    args.add(this.description);
    args.add(this.endTime);
    args.add(u8(this.status));
    args.add(this.totalUpBets);
    args.add(this.totalDownBets);
    args.add(this.winningOption);
    args.add(this.createdAt);
    args.add(this.resolutionPrice);
    return args.serialize();
  }

  static deserialize(data: StaticArray<u8>): Market {
    const args = new Args(data);
    const id = args.nextU64().unwrap();
    const creator = args.nextString().unwrap();
    const question = args.nextString().unwrap();
    const description = args.nextString().unwrap();
    const endTime = args.nextU64().unwrap();
    
    const market = new Market(id, creator, question, description, endTime);
    market.status = args.nextU8().unwrap() as MarketStatus;
    market.totalUpBets = args.nextU64().unwrap();
    market.totalDownBets = args.nextU64().unwrap();
    market.winningOption = args.nextI32().unwrap();
    market.createdAt = args.nextU64().unwrap();
    market.resolutionPrice = args.nextU64().unwrap();
    
    return market;
  }

  totalPool(): u64 {
    return this.totalUpBets + this.totalDownBets;
  }

  isActive(): bool {
    return this.status == MarketStatus.ACTIVE;
  }

  isResolved(): bool {
    return this.status == MarketStatus.RESOLVED;
  }
}

class Bet {
  marketId: u64;
  user: string;
  option: BetOption;
  amount: u64;
  timestamp: u64;
  claimed: bool;

  constructor(
    marketId: u64,
    user: string,
    option: BetOption,
    amount: u64,
  ) {
    this.marketId = marketId;
    this.user = user;
    this.option = option;
    this.amount = amount;
    this.timestamp = Context.timestamp();
    this.claimed = false;
  }

  serialize(): StaticArray<u8> {
    const args = new Args();
    args.add(this.marketId);
    args.add(this.user);
    args.add(u8(this.option));
    args.add(this.amount);
    args.add(this.timestamp);
    args.add(boolToByte(this.claimed));
    return args.serialize();
  }

  static deserialize(data: StaticArray<u8>): Bet {
    const args = new Args(data);
    const marketId = args.nextU64().unwrap();
    const user = args.nextString().unwrap();
    const option = args.nextU8().unwrap() as BetOption;
    const amount = args.nextU64().unwrap();
    
    const bet = new Bet(marketId, user, option, amount);
    bet.timestamp = args.nextU64().unwrap();
    bet.claimed = args.nextU8().unwrap() != 0;
    
    return bet;
  }
}

// ============================================================================
// Helper Functions
// ============================================================================

function getMarketKey(marketId: u64): StaticArray<u8> {
  return MARKET_PREFIX.concat(u64ToBytes(marketId));
}

function getUserBetKey(marketId: u64, user: string, optionIndex: u8): StaticArray<u8> {
  return USER_BET_PREFIX
    .concat(u64ToBytes(marketId))
    .concat(stringToBytes('_'))
    .concat(stringToBytes(user))
    .concat(stringToBytes('_'))
    .concat(u64ToBytes(optionIndex as u64));
}

function getNextMarketId(): u64 {
  if (!Storage.has(NEXT_MARKET_ID_KEY)) {
    Storage.set(NEXT_MARKET_ID_KEY, u64ToBytes(1));
    return 1;
  }
  const id = bytesToU64(Storage.get(NEXT_MARKET_ID_KEY));
  Storage.set(NEXT_MARKET_ID_KEY, u64ToBytes(id + 1));
  return id;
}

function getMarket(marketId: u64): Market | null {
  const key = getMarketKey(marketId);
  if (!Storage.has(key)) {
    return null;
  }
  return Market.deserialize(Storage.get(key));
}

function saveMarket(market: Market): void {
  const key = getMarketKey(market.id);
  Storage.set(key, market.serialize());
}

function getUserBet(marketId: u64, user: string, optionIndex: u8): Bet | null {
  const key = getUserBetKey(marketId, user, optionIndex);
  if (!Storage.has(key)) {
    return null;
  }
  return Bet.deserialize(Storage.get(key));
}

function saveUserBet(bet: Bet, optionIndex: u8): void {
  const key = getUserBetKey(bet.marketId, bet.user, optionIndex);
  Storage.set(key, bet.serialize());
}

// ============================================================================
// Main Contract Functions
// ============================================================================

/**
 * Initialize the contract
 */


/**
 * Initialize the contract
 */

/**
 * Initialize the contract
 */

/**
 * Create a new prediction market
 * @param question - The market question
 * @param description - Market description
 * @param durationMinutes - Duration in minutes
 */
export function createMarket(args: StaticArray<u8>): void {
  const argsObj = new Args(args);
  const question = argsObj.nextString().unwrap();
  const description = argsObj.nextString().unwrap();
  const durationMinutes = argsObj.nextU64().unwrap();

  const creator = caller().toString();
  const marketId = getNextMarketId();
  const currentTime = Context.timestamp();
  const endTime = currentTime + (durationMinutes * 60 * 1000); // Convert minutes to milliseconds

  const market = new Market(
    marketId,
    creator,
    question,
    description,
    endTime
  );

  saveMarket(market);
  generateEvent(`Market created: ${marketId.toString()}`);
}
/**
 * Place a bet on a market
 * @param marketId - The market ID
 * @param option - 0 for UP, 1 for DOWN
 */
export function placeBet(args: StaticArray<u8>): void {
  const argsObj = new Args(args);
  const marketId = argsObj.nextU64().unwrap();
  const optionIndex = argsObj.nextU8().unwrap(); // Option index (0, 1, 2, 3...) for question-answer markets, or 0=UP, 1=DOWN for old format

  const user = caller().toString();
  const amount = Context.transferredCoins();

  // Validate amount
  assert(amount > 0, 'Bet amount must be greater than 0');

  // Get market
  const market = getMarket(marketId);
  assert(market !== null, 'Market not found');
  assert(market!.isActive(), 'Market is not active');

  // Check if market ended
  const currentTime = Context.timestamp();
  assert(currentTime < market!.endTime, 'Market has ended');

  // Check if user already bet on this specific option (allow multiple bets on different options)
  const existingBet = getUserBet(marketId, user, optionIndex);
  // Allow user to bet on different options, but not on the same option twice
  // If user wants to increase bet, they can place another bet (it will be tracked separately)
  // For simplicity, we allow multiple bets on the same option (they will be separate entries)

  // For backward compatibility: if optionIndex is 0 or 1, update UP/DOWN totals
  // For question-answer markets: we don't update totalUpBets/totalDownBets
  // The frontend/Supabase will track option-specific bets
  if (optionIndex == 0) {
    market!.totalUpBets += amount;
  } else if (optionIndex == 1) {
    market!.totalDownBets += amount;
  }
  // For optionIndex > 1, it's a question-answer market option (handled by frontend/Supabase)

  saveMarket(market!);

  // Convert optionIndex to BetOption for storage (0=UP, 1=DOWN, others map to UP for storage)
  const betOption = optionIndex < 2 ? (optionIndex as BetOption) : BetOption.UP;
  
  // Save bet with optionIndex in the key (allows multiple bets on different options)
  const bet = new Bet(marketId, user, betOption, amount);
  saveUserBet(bet, optionIndex);

  const optionStr = optionIndex == 0 ? 'UP' : optionIndex == 1 ? 'DOWN' : `Option ${optionIndex.toString()}`;
  generateEvent(
    `Bet placed: ${user} bet ${amount.toString()} on ${optionStr} (index: ${optionIndex.toString()}) for market ${marketId.toString()}`,
  );
}

/**
 * Resolve a market (only creator can call)
 * @param marketId - The market ID
 * @param winningOption - 0 for UP, 1 for DOWN
 * @param resolutionPrice - The final price used for resolution
 */
export function resolveMarket(args: StaticArray<u8>): void {
  const argsObj = new Args(args);
  const marketId = argsObj.nextU64().unwrap();
  const winningOption = argsObj.nextU8().unwrap();
  const resolutionPrice = argsObj.nextU64().unwrap();

  const callerAddr = caller().toString();

  // Get market
  const market = getMarket(marketId);
  assert(market !== null, 'Market not found');
  assert(market!.creator == callerAddr, 'Only creator can resolve market');
  assert(!market!.isResolved(), 'Market already resolved');

  // Check if market ended
  const currentTime = Context.timestamp();
  assert(currentTime >= market!.endTime, 'Market has not ended yet');

  // Update market
  market!.status = MarketStatus.RESOLVED;
  market!.winningOption = winningOption as i32;
  market!.resolutionPrice = resolutionPrice;
  saveMarket(market!);

  const optionStr = winningOption == BetOption.UP ? 'UP' : 'DOWN';
  generateEvent(
    `Market resolved: ${marketId.toString()} - Winner: ${optionStr}, Price: ${resolutionPrice.toString()}`,
  );
}

/**
 * Claim reward from a resolved market
 * @param marketId - The market ID
 */
export function claimReward(args: StaticArray<u8>): void {
  const argsObj = new Args(args);
  const marketId = argsObj.nextU64().unwrap();

  const user = caller().toString();

  // Get market
  const market = getMarket(marketId);
  assert(market !== null, 'Market not found');
  assert(market!.isResolved(), 'Market is not resolved yet');

  // Get user bet
  const bet = getUserBet(marketId, user, 0); // Default to option 0 (UP) for backward compatibility
  assert(bet !== null, 'No bet found for this user');
  assert(!bet!.claimed, 'Reward already claimed');

  // Check if user won
  assert(
    bet!.option as i32 == market!.winningOption,
    'User did not win this market',
  );

  // Calculate reward
  const totalPool = market!.totalPool();
  const winningPool =
    market!.winningOption == BetOption.UP
      ? market!.totalUpBets
      : market!.totalDownBets;

  assert(winningPool > 0, 'No winning pool');

  // Reward = (userBet / winningPool) * totalPool
  const reward = (bet!.amount * totalPool) / winningPool;

  // Mark as claimed
  bet!.claimed = true;
  saveUserBet(bet!, 0); // Default to option 0 (UP) for backward compatibility

  // Transfer reward
  transferCoins(caller(), reward);

  generateEvent(
    `Reward claimed: ${user} received ${reward.toString()} from market ${marketId.toString()}`,
  );
}

/**
 * Get market details (read-only)
 */
export function getMarketDetails(args: StaticArray<u8>): StaticArray<u8> {
  const argsObj = new Args(args);
  const marketId = argsObj.nextU64().unwrap();

  const market = getMarket(marketId);
  assert(market !== null, 'Market not found');

  return market!.serialize();
}

/**
 * Get user bet details (read-only)
 */
export function getUserBetDetails(args: StaticArray<u8>): StaticArray<u8> {
  const argsObj = new Args(args);
  const marketId = argsObj.nextU64().unwrap();
  const user = argsObj.nextString().unwrap();

  const bet = getUserBet(marketId, user, 0); // Default to option 0 (UP) for backward compatibility
  assert(bet !== null, 'Bet not found');

  return bet!.serialize();
}


/**
 * Get total number of markets
 */
export function getMarketCount(_args: StaticArray<u8>): StaticArray<u8> {
  if (!Storage.has(NEXT_MARKET_ID_KEY)) {
    return u64ToBytes(0);
  }
  const nextId = bytesToU64(Storage.get(NEXT_MARKET_ID_KEY));
  // nextId is the next ID to be assigned, so count is nextId - 1
  const count = nextId > 0 ? nextId - 1 : 0;
  return u64ToBytes(count);
}
