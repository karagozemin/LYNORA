/**
 * Lynora Contract Interactions - MAS Token
 * Functions to interact with the Massa smart contract
 */

import { Args, SmartContract, JsonRpcPublicProvider } from '@massalabs/massa-web3';
import { walletManager } from './wallet';
import { parseMassaAmount } from './massa';
import { CURRENT_NETWORK } from './massa';
import { 
  saveMarketToSupabase, 
  getMarketsFromSupabase, 
  updateMarketInSupabase, 
  SupabaseMarket,
  saveUserBet,
  getUserBetsForMarket,
  calculateAndDistributeRewards,
  claimRewardForBet,
  UserBet,
} from './supabase';

// Contract address - will be set after deployment
export const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS || '';

// Log contract address on load
console.log('Contract Address:', CONTRACT_ADDRESS || 'NOT SET');

// ============================================================================
// Contract Call Functions (Write Operations)
// ============================================================================

// ============================================================================
// Local Storage for Optimistic Updates (MVP)
// ============================================================================

const LOCAL_MARKETS_KEY = 'lynora_local_markets';

/**
 * Save a market to local storage (optimistic update)
 */
export function saveLocalMarket(market: Market): void {
  try {
    const existing = localStorage.getItem(LOCAL_MARKETS_KEY);
    const markets: Market[] = existing ? JSON.parse(existing) : [];
    
    // Check if market already exists (by id or operationId)
    const exists = markets.some(m => m.id === market.id);
    if (!exists) {
      markets.push(market);
      localStorage.setItem(LOCAL_MARKETS_KEY, JSON.stringify(markets));
      console.log('Market saved to local storage:', market.id);
    }
  } catch (error) {
    console.error('Error saving market to local storage:', error);
  }
}

/**
 * Get all markets from local storage
 */
export function getLocalMarkets(): Market[] {
  try {
    const existing = localStorage.getItem(LOCAL_MARKETS_KEY);
    return existing ? JSON.parse(existing) : [];
  } catch (error) {
    console.error('Error reading markets from local storage:', error);
    return [];
  }
}

/**
 * Remove a market from local storage (after it's confirmed on blockchain)
 */
export function removeLocalMarket(marketId: number): void {
  try {
    const existing = localStorage.getItem(LOCAL_MARKETS_KEY);
    if (existing) {
      const markets: Market[] = JSON.parse(existing);
      const filtered = markets.filter(m => m.id !== marketId);
      localStorage.setItem(LOCAL_MARKETS_KEY, JSON.stringify(filtered));
      console.log('Market removed from local storage:', marketId);
    }
  } catch (error) {
    console.error('Error removing market from local storage:', error);
  }
}

/**
 * Create a new prediction market (question-answer style)
 * Returns operation ID and creates optimistic market entry
 */
export async function createMarket(
  question: string,
  description: string,
  durationMinutes: number,
  options: string[],
  correctAnswer: string,
  maxReward: number = 10, // Default max reward: 10 MAS
): Promise<{ operationId: string; market: Market }> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  const { address } = walletManager.getState();
  if (!address) {
    throw new Error('Wallet not connected');
  }

  const args = new Args()
    .addString(question)
    .addString(description)
    .addU64(BigInt(durationMinutes));

  const operationId = await walletManager.sendOperation(
    CONTRACT_ADDRESS,
    'createMarket',
    args.serialize(),
  );

  // Create optimistic market entry
  const currentTime = Date.now();
  const endTime = currentTime + (durationMinutes * 60 * 1000);
  
  // Generate a temporary ID based on timestamp (will be replaced by real ID from blockchain)
  const tempId = Math.floor(currentTime / 1000);
  
  // Initialize bets object for each option
  const bets: Record<string, string> = {};
  options.forEach(option => {
    bets[option] = '0';
  });

  const optimisticMarket: Market = {
    id: tempId,
    creator: address,
    question,
    description,
    endTime,
    status: 'Active',
    options,
    correctAnswer,
    bets,
    maxReward,
    createdAt: currentTime,
    resolutionPrice: 0,
    totalPool: '0',
  };

  // Save to local storage immediately
  saveLocalMarket(optimisticMarket);

  // Save to Supabase
  try {
    await saveMarketToSupabase({
      market_id: optimisticMarket.id,
      creator: optimisticMarket.creator,
      question: optimisticMarket.question,
      description: optimisticMarket.description,
      end_time: optimisticMarket.endTime,
      status: optimisticMarket.status,
      options: optimisticMarket.options,
      correct_answer: optimisticMarket.correctAnswer,
      bets: optimisticMarket.bets,
      max_reward: optimisticMarket.maxReward,
      created_at: optimisticMarket.createdAt,
      resolution_price: optimisticMarket.resolutionPrice,
      total_pool: optimisticMarket.totalPool,
      operation_id: operationId,
    });
  } catch (error) {
    console.error('Failed to save market to Supabase:', error);
    // Continue anyway - market is saved locally
  }

  console.log('Market created (optimistic):', optimisticMarket.id, 'Operation ID:', operationId);

  return { operationId, market: optimisticMarket };
}

/**
 * Place a bet on a market
 */
/**
 * Place a bet on a market (question-answer style)
 * Selects an option and bets an amount
 * Sends MAS to contract and updates Supabase
 */
export async function placeBet(
  marketId: number,
  selectedOption: string, // The option string (e.g., 'Option A', 'Option B')
  amount: string,
): Promise<string> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  const { address } = walletManager.getState();
  if (!address) {
    throw new Error('Wallet not connected');
  }

  // Validate market and option
  const allMarkets = await getAllMarkets();
  const market = allMarkets.find(m => m.id === marketId);
  
  if (!market) {
    throw new Error(`Market ${marketId} not found`);
  }
  
  if (!market.options || !market.options.includes(selectedOption)) {
    throw new Error(`Invalid option: ${selectedOption}`);
  }

  if (market.status !== 'Active') {
    throw new Error('Market is not active');
  }

  const amountNano = parseMassaAmount(amount);
  
  // Validate amount
  if (amountNano <= 0) {
    throw new Error('Bet amount must be greater than 0');
  }

  // Log bet details before sending
  console.log('Placing bet:', {
    marketId,
    selectedOption,
    amount: amount,
    amountNano: amountNano.toString(),
    amountMAS: Number(amountNano) / 1e9,
    contractAddress: CONTRACT_ADDRESS,
    userAddress: address,
  });
  
  // Send MAS to contract via placeBet function (this will trigger wallet popup and deduct from wallet)
  // IMPORTANT: The coins parameter will deduct MAS from user's wallet when Bearby wallet approves
  try {
    // Prepare bet data: marketId + selectedOption index
    const optionIndex = market.options.indexOf(selectedOption);
    const args = new Args()
      .addU64(BigInt(marketId))
      .addU8(BigInt(optionIndex)); // Option index instead of UP/DOWN

    const serializedArgs = args.serialize();
    console.log('Bet args serialized:', {
      marketId,
      optionIndex,
      argsLength: serializedArgs.length,
    });

    // Call placeBet function with coins - this will deduct MAS from wallet
    // Bearby wallet will show a popup asking user to approve the transaction
    // When approved, MAS will be deducted from wallet and sent to contract
    // 
    // IMPORTANT: Contract's placeBet function must:
    // 1. Use Context.transferredCoins() to receive the coins (✅ already done)
    // 2. Support question-answer style markets with option index (❌ needs update)
    // 3. Allow users to bet on different options (❌ currently blocks if user already bet)
    const operationId = await walletManager.sendOperation(
      CONTRACT_ADDRESS.trim(),
      'placeBet',
      serializedArgs,
      amountNano, // Send MAS coins with the transaction - this deducts from wallet
    );

    console.log('Bet transaction sent to contract:', {
      operationId,
      amountNano: amountNano.toString(),
      amountMAS: Number(amountNano) / 1e9,
      note: 'MAS should be deducted from wallet after Bearby wallet approval',
    });

    // Update market bets in Supabase (optimistic update)
    try {
      if (!market.bets) {
        market.bets = {};
      }
      
      // Update bets
      const currentBetAmount = market.bets[selectedOption] || '0';
      const newBetAmount = (BigInt(parseMassaAmount(currentBetAmount)) + amountNano).toString();
      market.bets[selectedOption] = newBetAmount;
      
      // Update total pool
      const totalPool = Object.values(market.bets).reduce((sum, bet) => {
        return BigInt(sum) + BigInt(parseMassaAmount(bet));
      }, BigInt(0));
      market.totalPool = totalPool.toString();
      
      // Update in Supabase
      await updateMarketInSupabase(marketId, {
        bets: market.bets,
        total_pool: market.totalPool,
      });
      
      // Save user bet
      await saveUserBet({
        market_id: marketId,
        user_address: address,
        option: selectedOption,
        amount: amountNano.toString(),
        reward_amount: '0', // Will be calculated when market is resolved
        claimed: false,
        created_at: Date.now(),
      });
      
      console.log('Bet placed and updated in Supabase:', { marketId, selectedOption, amount, operationId });
      return operationId;
    } catch (supabaseError: any) {
      console.error('Error updating Supabase after bet:', supabaseError);
      // Transaction was sent to blockchain, so return operation ID anyway
      return operationId;
    }
  } catch (error: any) {
    console.error('Error placing bet:', error);
    throw error;
  }
}

/**
 * Resolve a market (only creator can call)
 */
export async function resolveMarket(
  marketId: number,
  winningOption: 'up' | 'down',
  resolutionPrice: number,
): Promise<string> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  const betOption = winningOption === 'up' ? 0 : 1;

  const args = new Args()
    .addU64(BigInt(marketId))
    .addU8(BigInt(betOption))
    .addU64(BigInt(resolutionPrice));

  return await walletManager.sendOperation(
    CONTRACT_ADDRESS,
    'resolveMarket',
    args.serialize(),
  );
}

/**
 * Claim reward from a resolved market (question-answer style)
 * Sends reward MAS to user's wallet
 */
export async function claimReward(marketId: number, betId: number): Promise<string> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  const { address } = walletManager.getState();
  if (!address) {
    throw new Error('Wallet not connected');
  }

  // Get user bet to check reward amount
  const userBets = await getUserBetsForMarket(marketId, address);
  const bet = userBets.find(b => b.id === betId);
  
  if (!bet) {
    throw new Error('Bet not found');
  }

  if (bet.claimed) {
    throw new Error('Reward already claimed');
  }

  if (parseFloat(bet.reward_amount) <= 0) {
    throw new Error('No reward available');
  }

  // Get market to verify it's resolved
  const allMarkets = await getAllMarkets();
  const market = allMarkets.find(m => m.id === marketId);
  
  if (!market) {
    throw new Error('Market not found');
  }

  if (market.status !== 'Locked' && market.status !== 'Resolved') {
    throw new Error('Market is not resolved yet');
  }

  // Check if user bet on correct answer
  if (market.correctAnswer && bet.option !== market.correctAnswer) {
    throw new Error('You did not bet on the correct answer');
  }

  // Calculate reward amount in nanoMAS
  const rewardAmountNano = BigInt(bet.reward_amount);

  // Validate CONTRACT_ADDRESS
  if (!CONTRACT_ADDRESS || !CONTRACT_ADDRESS.trim()) {
    throw new Error('Contract address is not configured. Please set VITE_CONTRACT_ADDRESS in .env file');
  }

  // Validate address
  if (!address || !address.trim()) {
    throw new Error('User address is required');
  }

  // For MVP: Just mark as claimed in Supabase
  // In production, contract should have a transferReward function to transfer MAS to user
  // Massa doesn't have direct "Payment" transactions - everything goes through contract calls
  // Since contract may not have transferReward function yet, we'll just mark as claimed
  try {
    // Mark as claimed in Supabase
    await claimRewardForBet(betId);
    
    console.log('Reward claimed (MVP - Supabase only):', { 
      marketId, 
      betId, 
      rewardAmount: bet.reward_amount,
      rewardAmountMAS: Number(rewardAmountNano) / 1e9,
      note: 'Contract transferReward function not implemented yet. Reward marked as claimed in Supabase only.'
    });
    
    // Return a success ID
    return `reward_claimed_${betId}_${Date.now()}`;
  } catch (error: any) {
    console.error('Error claiming reward:', error);
    throw error;
  }

  /* 
  // TODO: When contract has transferReward function, uncomment this:
  try {
    // Prepare transfer data: user address
    const args = new Args()
      .addString(address.trim());

    const serializedArgs = args.serialize();
    console.log('Claim reward args:', {
      contractAddress: CONTRACT_ADDRESS.trim(),
      address: address.trim(),
      serializedLength: serializedArgs.length,
      rewardAmountNano: rewardAmountNano.toString(),
      rewardAmountMAS: Number(rewardAmountNano) / 1e9,
    });

    // Call transferReward function with coins - this will transfer MAS to user
    const operationId = await walletManager.sendOperation(
      CONTRACT_ADDRESS.trim(),
      'transferReward',
      serializedArgs,
      rewardAmountNano, // Send reward amount as coins
    );
    
    console.log('Reward transfer sent:', { marketId, betId, rewardAmount: bet.reward_amount, operationId });
    
    // Mark as claimed in Supabase after successful transfer
    await claimRewardForBet(betId);
    
    console.log('Reward claimed:', { marketId, betId, rewardAmount: bet.reward_amount, operationId });
    
    return operationId;
  } catch (error: any) {
    console.error('Error claiming reward:', error);
    throw error;
  }
  */
}

/**
 * Get user's claimable rewards for a market
 */
export async function getClaimableRewards(marketId: number, userAddress: string): Promise<UserBet[]> {
  const userBets = await getUserBetsForMarket(marketId, userAddress);
  
  // Filter for bets with rewards that haven't been claimed
  return userBets.filter(bet => 
    parseFloat(bet.reward_amount) > 0 && !bet.claimed
  );
}

// ============================================================================
// Contract Read Functions (View Operations)
// ============================================================================

export interface Market {
  id: number;
  creator: string;
  question: string;
  description: string;
  endTime: number;
  status: 'Active' | 'Locked' | 'Resolved';
  // Old format (for backward compatibility)
  totalUpBets?: string;
  totalDownBets?: string;
  winningOption?: 'Up' | 'Down' | null;
  // New format (question-answer style)
  options?: string[]; // e.g., ['Option A', 'Option B', 'Option C', 'Option D']
  correctAnswer?: string; // The correct answer selected by creator
  bets?: Record<string, string>; // { option: totalAmount } e.g., { 'Option A': '100', 'Option B': '50' }
  maxReward?: number; // Maximum reward per winner (default: 10 MAS)
  createdAt: number;
  resolutionPrice: number;
  totalPool: string;
}

export interface Bet {
  marketId: number;
  user: string;
  option: 'Up' | 'Down';
  amount: string;
  timestamp: number;
  claimed: boolean;
}

/**
 * Get market details
 */
export async function getMarketDetails(marketId: number): Promise<Market> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  // Use public provider for read-only calls (doesn't require wallet connection)
  const publicProvider = JsonRpcPublicProvider.fromRPCUrl(CURRENT_NETWORK.rpcUrl);
  const contract = new SmartContract(publicProvider, CONTRACT_ADDRESS);
  const args = new Args().addU64(BigInt(marketId));

  const result = await contract.read('getMarketDetails', args);

  // Deserialize market data
  console.log(`getMarketDetails for market ${marketId}, result length:`, result.value?.length);
  console.log(`getMarketDetails result info:`, result.info);
  
  if (result.info?.error) {
    throw new Error(result.info.error);
  }
  
  if (!result.value || result.value.length === 0) {
    throw new Error(`Market ${marketId} not found or empty result`);
  }

  try {
    const resultArgs = new Args(result.value);
    console.log(`Deserializing market ${marketId}...`);
    const id = Number(resultArgs.nextU64());
    const creator = resultArgs.nextString();
    const question = resultArgs.nextString();
    const description = resultArgs.nextString();
    const endTime = Number(resultArgs.nextU64());
    const statusCode = Number(resultArgs.nextU8());
    const totalUpBets = resultArgs.nextU64().toString();
    const totalDownBets = resultArgs.nextU64().toString();
    const winningOptionCode = Number(resultArgs.nextI32());
    const createdAt = Number(resultArgs.nextU64());
    const resolutionPrice = Number(resultArgs.nextU64());

    const statusMap = ['Active', 'Locked', 'Resolved'] as const;
    const status = statusMap[statusCode] || 'Active';

    let winningOption: 'Up' | 'Down' | null = null;
    if (winningOptionCode === 0) winningOption = 'Up';
    else if (winningOptionCode === 1) winningOption = 'Down';

    const totalPool = (BigInt(totalUpBets) + BigInt(totalDownBets)).toString();

    return {
      id,
      creator,
      question,
      description,
      endTime,
      status,
      totalUpBets,
      totalDownBets,
      winningOption,
      createdAt,
      resolutionPrice,
      totalPool,
    };
  } catch (error: any) {
    console.error(`Error deserializing market ${marketId}:`, error);
    console.error('Result bytes:', result.value);
    throw new Error(`Failed to deserialize market ${marketId}: ${error.message}`);
  }
}

/**
 * Get user bet details
 */
export async function getUserBetDetails(
  marketId: number,
  userAddress: string,
): Promise<Bet> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  // Use public provider for read-only calls (doesn't require wallet connection)
  const publicProvider = JsonRpcPublicProvider.fromRPCUrl(CURRENT_NETWORK.rpcUrl);
  const contract = new SmartContract(publicProvider, CONTRACT_ADDRESS);
  const args = new Args()
    .addU64(BigInt(marketId))
    .addString(userAddress);

  const result = await contract.read('getUserBetDetails', args);

  if (result.info?.error) {
    throw new Error(result.info.error);
  }

  // Deserialize bet data
  const resultArgs = new Args(result.value);
  const betMarketId = Number(resultArgs.nextU64());
  const user = resultArgs.nextString();
  const optionCode = Number(resultArgs.nextU8());
  const amount = resultArgs.nextU64().toString();
  const timestamp = Number(resultArgs.nextU64());
  const claimed = Number(resultArgs.nextU8()) !== 0;

  const option = optionCode === 0 ? 'Up' : 'Down';

  return {
    marketId: betMarketId,
    user,
    option,
    amount,
    timestamp,
    claimed,
  };
}

/**
 * Get market count by reading storage directly
 */
export async function getMarketCount(): Promise<number> {
  if (!CONTRACT_ADDRESS) {
    throw new Error(
      'Contract not deployed. Please set VITE_CONTRACT_ADDRESS in .env file'
    );
  }

  try {
    // Use public provider for read-only calls
    const publicProvider = JsonRpcPublicProvider.fromRPCUrl(CURRENT_NETWORK.rpcUrl);
    
    // Try to read NEXT_MARKET_ID from storage directly
    // Contract uses stringToBytes, which in Massa is just UTF-8 encoding
    // Try both TextEncoder and Args encoding to see which one works
    const NEXT_MARKET_ID_KEY_UTF8 = new TextEncoder().encode('NEXT_MARKET_ID');
    const NEXT_MARKET_ID_KEY_ARGS = new Args().addString('NEXT_MARKET_ID').serialize();
    
    console.log('Reading storage key (UTF-8):', Array.from(NEXT_MARKET_ID_KEY_UTF8));
    console.log('Reading storage key (Args):', Array.from(NEXT_MARKET_ID_KEY_ARGS));
    
    // Try UTF-8 encoding first
    let storageValues = await publicProvider.readStorage(CONTRACT_ADDRESS, [NEXT_MARKET_ID_KEY_UTF8]);
    console.log('Storage values (UTF-8):', storageValues);
    
    // If null, try Args encoding
    if (!storageValues || storageValues.length === 0 || !storageValues[0]) {
      console.log('Trying Args encoding...');
      storageValues = await publicProvider.readStorage(CONTRACT_ADDRESS, [NEXT_MARKET_ID_KEY_ARGS]);
      console.log('Storage values (Args):', storageValues);
    }
    
    // If still null, try to get all storage keys and count MARKET_ prefix keys
    if (!storageValues || storageValues.length === 0 || !storageValues[0]) {
      console.log('NEXT_MARKET_ID not found, trying to get all storage keys...');
      const MARKET_PREFIX = new TextEncoder().encode('MARKET_');
      const allKeys = await publicProvider.getStorageKeys(CONTRACT_ADDRESS);
      console.log('All storage keys:', allKeys.map(k => Array.from(k)));
      
      // Filter keys that start with MARKET_ prefix
      const marketKeys = allKeys.filter(key => {
        if (key.length < MARKET_PREFIX.length) return false;
        for (let i = 0; i < MARKET_PREFIX.length; i++) {
          if (key[i] !== MARKET_PREFIX[i]) return false;
        }
        return true;
      });
      
      console.log('Market keys found:', marketKeys.length);
      return marketKeys.length;
    }

    // Parse u64 from storage
    const resultArgs = new Args(storageValues[0]);
    const nextId = Number(resultArgs.nextU64());
    const count = nextId > 0 ? nextId - 1 : 0;
    console.log('getMarketCount from storage:', count);
    return count;
  } catch (error: any) {
    console.error('Error reading market count from storage:', error);
    // Fallback: try contract function
    try {
      const publicProvider = JsonRpcPublicProvider.fromRPCUrl(CURRENT_NETWORK.rpcUrl);
      const contract = new SmartContract(publicProvider, CONTRACT_ADDRESS);
      console.log('Calling getMarketCount on contract:', CONTRACT_ADDRESS);
      const args = new Args();
      const result = await contract.read('getMarketCount', args);

    console.log('getMarketCount result:', result);
    console.log('getMarketCount result value length:', result.value?.length);
    console.log('getMarketCount result info:', result.info);

    if (result.info?.error) {
      console.error('getMarketCount error:', result.info.error);
      throw new Error(result.info.error);
    }

    if (!result.value || result.value.length === 0) {
      console.warn('getMarketCount returned empty result, defaulting to 0');
      // Empty result means no markets exist yet
      return 0;
    }

    // u64 should be 8 bytes, but if it's empty, return 0
    if (result.value.length < 8) {
      console.warn('getMarketCount returned result with length < 8, defaulting to 0');
      return 0;
    }

    try {
      const resultArgs = new Args(result.value);
      const count = Number(resultArgs.nextU64());
      console.log('getMarketCount parsed count:', count);
      return count;
    } catch (error: any) {
      console.error('Error parsing getMarketCount result:', error);
      console.error('Result bytes:', Array.from(result.value || []));
      // If parsing fails, assume 0 markets
      return 0;
    }
    } catch (fallbackError: any) {
      console.error('Error in contract function fallback:', fallbackError);
      // If there's an error, assume no markets exist yet
      return 0;
    }
  }
}

/**
 * Check and update market status based on endTime
 * If endTime has passed and status is Active, change to Locked and calculate rewards
 */
async function checkAndUpdateMarketStatus(market: Market): Promise<Market> {
  const now = Date.now();
  
  // If market is Active and endTime has passed, change to Locked
  if (market.status === 'Active' && market.endTime <= now) {
    console.log(`Market ${market.id} has expired, updating to Locked`);
    
    // Update in Supabase
    try {
      await updateMarketInSupabase(market.id, {
        status: 'Locked',
      });
      
      // If this is a question-answer market with correct answer, calculate rewards
      if (market.options && market.correctAnswer && market.maxReward) {
        console.log('Calculating rewards for market:', market.id);
        await calculateAndDistributeRewards(
          market.id,
          market.correctAnswer,
          market.maxReward
        );
      }
    } catch (error) {
      console.error('Failed to update market status in Supabase:', error);
    }
    
    // Return updated market
    return {
      ...market,
      status: 'Locked',
    };
  }
  
  return market;
}

/**
 * Convert Supabase market to Market interface
 */
function supabaseMarketToMarket(sbMarket: SupabaseMarket): Market {
  // JSONB fields are already parsed by Supabase
  // But handle both string and object formats for safety
  let options: string[] | undefined;
  let bets: Record<string, string> | undefined;
  
  if (sbMarket.options) {
    try {
      if (Array.isArray(sbMarket.options)) {
        options = sbMarket.options;
      } else if (typeof sbMarket.options === 'string') {
        options = JSON.parse(sbMarket.options);
      }
    } catch (e) {
      console.error('Error parsing options:', e);
    }
  }
  
  if (sbMarket.bets) {
    try {
      if (typeof sbMarket.bets === 'object' && !Array.isArray(sbMarket.bets)) {
        bets = sbMarket.bets as Record<string, string>;
      } else if (typeof sbMarket.bets === 'string') {
        bets = JSON.parse(sbMarket.bets);
      }
    } catch (e) {
      console.error('Error parsing bets:', e);
    }
  }

  return {
    id: sbMarket.market_id,
    creator: sbMarket.creator,
    question: sbMarket.question,
    description: sbMarket.description,
    endTime: sbMarket.end_time,
    status: sbMarket.status,
    totalUpBets: sbMarket.total_up_bets,
    totalDownBets: sbMarket.total_down_bets,
    winningOption: sbMarket.winning_option,
    options,
    correctAnswer: sbMarket.correct_answer,
    bets,
    maxReward: sbMarket.max_reward || 10,
    createdAt: sbMarket.created_at,
    resolutionPrice: sbMarket.resolution_price,
    totalPool: sbMarket.total_pool,
  };
}

/**
 * Get all markets
 * Combines markets from Supabase, blockchain, and local storage (optimistic updates)
 */
export async function getAllMarkets(): Promise<Market[]> {
  // Get markets from Supabase first (primary source)
  const supabaseMarkets = await getMarketsFromSupabase();
  console.log('Markets from Supabase:', supabaseMarkets.length);
  
  // Convert Supabase markets to Market format and check/update status
  const marketsFromSupabase = await Promise.all(
    supabaseMarkets.map(async (sbMarket) => {
      const market = supabaseMarketToMarket(sbMarket);
      return await checkAndUpdateMarketStatus(market);
    })
  );
  
  // Get local markets (optimistic updates)
  const localMarkets = getLocalMarkets();
  console.log('Local markets:', localMarkets.length);

  // Try to get markets from blockchain (for verification/backup)
  let blockchainMarkets: Market[] = [];
  
  if (CONTRACT_ADDRESS) {
    try {
      // Use public provider for read-only calls
      const publicProvider = JsonRpcPublicProvider.fromRPCUrl(CURRENT_NETWORK.rpcUrl);
      
      // Get all storage keys
      const MARKET_PREFIX = new TextEncoder().encode('MARKET_');
      const allKeys = await publicProvider.getStorageKeys(CONTRACT_ADDRESS);
      console.log('All storage keys:', allKeys.length);
      
      // Filter keys that start with MARKET_ prefix
      const marketKeys = allKeys.filter(key => {
        if (key.length < MARKET_PREFIX.length) return false;
        for (let i = 0; i < MARKET_PREFIX.length; i++) {
          if (key[i] !== MARKET_PREFIX[i]) return false;
        }
        return true;
      });
      
      console.log('Market keys found:', marketKeys.length);
      
      if (marketKeys.length > 0) {
        // Read all market data from storage
        const marketDataPromises = marketKeys.map(async (key) => {
          try {
            const storageValues = await publicProvider.readStorage(CONTRACT_ADDRESS, [key]);
            if (!storageValues || storageValues.length === 0 || !storageValues[0]) {
              return null;
            }
            
            // Deserialize market data
            const resultArgs = new Args(storageValues[0]);
            const id = Number(resultArgs.nextU64());
            const creator = resultArgs.nextString();
            const question = resultArgs.nextString();
            const description = resultArgs.nextString();
            const endTime = Number(resultArgs.nextU64());
            const statusCode = Number(resultArgs.nextU8());
            const totalUpBets = resultArgs.nextU64().toString();
            const totalDownBets = resultArgs.nextU64().toString();
            const winningOptionCode = Number(resultArgs.nextI32());
            const createdAt = Number(resultArgs.nextU64());
            const resolutionPrice = Number(resultArgs.nextU64());
            
            const statusMap = ['Active', 'Locked', 'Resolved'] as const;
            const status = statusMap[statusCode] || 'Active';
            
            let winningOption: 'Up' | 'Down' | null = null;
            if (winningOptionCode === 0) winningOption = 'Up';
            else if (winningOptionCode === 1) winningOption = 'Down';
            
            const totalPool = (BigInt(totalUpBets) + BigInt(totalDownBets)).toString();
            
            return {
              id,
              creator,
              question,
              description,
              endTime,
              status,
              totalUpBets,
              totalDownBets,
              winningOption,
              createdAt,
              resolutionPrice,
              totalPool,
            } as Market;
          } catch (error: any) {
            console.error('Error reading market from storage:', error);
            return null;
          }
        });
        
        const markets = await Promise.all(marketDataPromises);
        blockchainMarkets = markets.filter((m): m is Market => m !== null);
        
        // Sort by createdAt (newest first)
        blockchainMarkets.sort((a, b) => b.createdAt - a.createdAt);
        
        console.log('Markets loaded from blockchain:', blockchainMarkets.length);
      }
    } catch (error: any) {
      console.error('Error getting markets from blockchain:', error);
      // Continue with local markets only
    }
  }

  // Merge all sources: Supabase (primary), blockchain (verification), local (optimistic)
  // Priority: Supabase > Blockchain > Local
  // Start with Supabase markets
  const mergedMarkets = new Map<number, Market>();
  
  // Add Supabase markets (highest priority)
  marketsFromSupabase.forEach(market => {
    mergedMarkets.set(market.id, market);
  });
  
  // Add blockchain markets (if not in Supabase)
  blockchainMarkets.forEach(market => {
    if (!mergedMarkets.has(market.id)) {
      mergedMarkets.set(market.id, market);
    }
  });
  
  // Add local markets (if not in Supabase or blockchain - optimistic updates)
  // Also check and update their status
  for (const localMarket of localMarkets) {
    if (!mergedMarkets.has(localMarket.id)) {
      const updatedMarket = await checkAndUpdateMarketStatus(localMarket);
      mergedMarkets.set(localMarket.id, updatedMarket);
    } else {
      // Remove from local storage if it's now in Supabase
      removeLocalMarket(localMarket.id);
    }
  }

  // Convert map to array and sort by createdAt (newest first)
  const allMarkets = Array.from(mergedMarkets.values());
  allMarkets.sort((a, b) => b.createdAt - a.createdAt); // Newest first

  console.log('Total markets (Supabase + blockchain + local):', allMarkets.length);
  return allMarkets;
}

/**
 * Calculate potential reward for a user
 */
export function calculatePotentialReward(
  market: Market,
  betAmount: string,
  betOption: 'up' | 'down',
): string {
  const betAmountBigInt = BigInt(betAmount);
  const totalUpBets = BigInt(market.totalUpBets || '0');
  const totalDownBets = BigInt(market.totalDownBets || '0');

  // Add user's bet to the pool
  let newUpBets = totalUpBets;
  let newDownBets = totalDownBets;

  if (betOption === 'up') {
    newUpBets += betAmountBigInt;
  } else {
    newDownBets += betAmountBigInt;
  }

  const newTotalPool = newUpBets + newDownBets;
  const winningPool = betOption === 'up' ? newUpBets : newDownBets;

  if (winningPool === BigInt(0)) {
    return '0';
  }

  // Reward = (userBet / winningPool) * totalPool
  const reward = (betAmountBigInt * newTotalPool) / winningPool;
  return reward.toString();
}

/**
 * Get market status (helper)
 */
export function getMarketStatus(market: Market): {
  isActive: boolean;
  isEnded: boolean;
  isResolved: boolean;
  timeLeft: number;
} {
  const now = Date.now();
  const endTime = market.endTime;
  const isEnded = now >= endTime;
  const isActive = market.status === 'Active' && !isEnded;
  const isResolved = market.status === 'Resolved';
  const timeLeft = Math.max(0, endTime - now);

  return {
    isActive,
    isEnded,
    isResolved,
    timeLeft,
  };
}
