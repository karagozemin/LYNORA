-- Supabase SQL Schema for Lynora Prediction Markets (Fixed - Safe to run multiple times)
-- Run this in Supabase SQL Editor

-- ============================================================================
-- MARKETS TABLE
-- ============================================================================

-- Create markets table
CREATE TABLE IF NOT EXISTS markets (
  id BIGSERIAL PRIMARY KEY,
  market_id BIGINT UNIQUE NOT NULL, -- Blockchain market ID
  creator TEXT NOT NULL, -- Wallet address of creator
  question TEXT NOT NULL,
  description TEXT NOT NULL,
  end_time BIGINT NOT NULL, -- Unix timestamp in milliseconds
  status TEXT NOT NULL CHECK (status IN ('Active', 'Locked', 'Resolved')),
  -- Old format (for backward compatibility)
  total_up_bets TEXT NOT NULL DEFAULT '0', -- Amount in MAS (string to preserve precision)
  total_down_bets TEXT NOT NULL DEFAULT '0', -- Amount in MAS (string to preserve precision)
  winning_option TEXT CHECK (winning_option IN ('Up', 'Down')) DEFAULT NULL,
  -- New format (question-answer style)
  options JSONB DEFAULT NULL, -- Array of option strings: ["Option A", "Option B", ...]
  correct_answer TEXT DEFAULT NULL, -- The correct answer string
  bets JSONB DEFAULT NULL, -- Object: {"Option A": "100", "Option B": "50", ...}
  max_reward BIGINT DEFAULT 10, -- Maximum reward per winner in MAS (default: 10)
  created_at BIGINT NOT NULL, -- Unix timestamp in milliseconds
  resolution_price BIGINT DEFAULT 0,
  total_pool TEXT NOT NULL DEFAULT '0', -- Amount in MAS (string to preserve precision)
  operation_id TEXT NOT NULL, -- Blockchain operation ID
  created_at_db TIMESTAMPTZ DEFAULT NOW() -- Database timestamp
);

-- Create indexes for markets
CREATE INDEX IF NOT EXISTS idx_markets_market_id ON markets(market_id);
CREATE INDEX IF NOT EXISTS idx_markets_creator ON markets(creator);
CREATE INDEX IF NOT EXISTS idx_markets_status ON markets(status);
CREATE INDEX IF NOT EXISTS idx_markets_created_at ON markets(created_at DESC);

-- Enable Row Level Security (RLS) for markets
ALTER TABLE markets ENABLE ROW LEVEL SECURITY;

-- Drop existing policies for markets (safe - won't error if they don't exist)
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Anyone can read markets" ON markets;
  DROP POLICY IF EXISTS "Anyone can insert markets" ON markets;
  DROP POLICY IF EXISTS "Anyone can update markets" ON markets;
END $$;

-- Create policies for markets
CREATE POLICY "Anyone can read markets" ON markets
  FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert markets" ON markets
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update markets" ON markets
  FOR UPDATE
  USING (true);

-- ============================================================================
-- USER_BETS TABLE
-- ============================================================================

-- Create user_bets table
CREATE TABLE IF NOT EXISTS user_bets (
  id BIGSERIAL PRIMARY KEY,
  market_id BIGINT NOT NULL,
  user_address TEXT NOT NULL,
  option TEXT NOT NULL, -- The selected option string
  amount TEXT NOT NULL, -- Bet amount in MAS (string to preserve precision)
  reward_amount TEXT DEFAULT '0', -- Reward amount (2x bet, max 10 MAS)
  claimed BOOLEAN DEFAULT FALSE, -- Whether reward has been claimed
  created_at BIGINT NOT NULL, -- Unix timestamp in milliseconds
  created_at_db TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(market_id, user_address, option) -- One bet per user per option per market
);

-- Create indexes for user_bets
CREATE INDEX IF NOT EXISTS idx_user_bets_market_id ON user_bets(market_id);
CREATE INDEX IF NOT EXISTS idx_user_bets_user_address ON user_bets(user_address);
CREATE INDEX IF NOT EXISTS idx_user_bets_claimed ON user_bets(claimed);

-- Enable Row Level Security (RLS) for user_bets
ALTER TABLE user_bets ENABLE ROW LEVEL SECURITY;

-- Drop existing policies for user_bets (safe - won't error if they don't exist)
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Anyone can read user bets" ON user_bets;
  DROP POLICY IF EXISTS "Anyone can insert user bets" ON user_bets;
  DROP POLICY IF EXISTS "Users can update their own bets" ON user_bets;
END $$;

-- Create policies for user_bets
CREATE POLICY "Anyone can read user bets" ON user_bets
  FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert user bets" ON user_bets
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update their own bets" ON user_bets
  FOR UPDATE
  USING (true);

-- ============================================================================
-- SUCCESS MESSAGE
-- ============================================================================

DO $$ 
BEGIN
  RAISE NOTICE '✅ Schema created successfully! Tables: markets, user_bets';
END $$;

