import { useState, useEffect } from 'react'
import MarketList from '../components/MarketList'
import { getAllMarkets, Market } from '../lib/contract'

// Mock markets (finished/resolved) for demo purposes
// Values are in MAS (not nanoMAS) as strings for display
const MOCK_MARKETS: Market[] = [
  {
    id: 1001,
    creator: 'AU12STCVmpQSBeFjDVPM9ErxJJFJtjMZtkTuGtfQzfa3LWN4h2XDJ',
    question: 'Will Bitcoin reach $100,000 by end of 2024?',
    description: 'This market will resolve based on Bitcoin\'s closing price on December 31, 2024. Data source: CoinGecko.',
    endTime: Date.now() - (1 * 24 * 60 * 60 * 1000), // Ended 1 day ago
    status: 'Resolved',
    totalUpBets: '1250.50', // MAS
    totalDownBets: '850.25', // MAS
    winningOption: 'Up',
    createdAt: Date.now() - (15 * 24 * 60 * 60 * 1000), // Created 15 days ago
    resolutionPrice: 102500,
    totalPool: '2100.75', // MAS
  },
  {
    id: 1002,
    creator: 'AU12STCVmpQSBeFjDVPM9ErxJJFJtjMZtkTuGtfQzfa3LWN4h2XDJ',
    question: 'Will Ethereum surpass $5,000 by Q1 2025?',
    description: 'Market resolves based on Ethereum\'s highest price reached in Q1 2025 (Jan-Mar). Data source: CoinMarketCap.',
    endTime: Date.now() - (2 * 24 * 60 * 60 * 1000), // Ended 2 days ago
    status: 'Resolved',
    totalUpBets: '680.00', // MAS
    totalDownBets: '920.50', // MAS
    winningOption: 'Down',
    createdAt: Date.now() - (20 * 24 * 60 * 60 * 1000), // Created 20 days ago
    resolutionPrice: 4200,
    totalPool: '1600.50', // MAS
  },
  {
    id: 1003,
    creator: 'AU12STCVmpQSBeFjDVPM9ErxJJFJtjMZtkTuGtfQzfa3LWN4h2XDJ',
    question: 'Will the S&P 500 close above 5,500 by year end?',
    description: 'Resolution based on S&P 500 closing price on December 31, 2024. Data source: Yahoo Finance.',
    endTime: Date.now() - (3 * 24 * 60 * 60 * 1000), // Ended 3 days ago
    status: 'Resolved',
    totalUpBets: '1850.75', // MAS
    totalDownBets: '650.25', // MAS
    winningOption: 'Up',
    createdAt: Date.now() - (18 * 24 * 60 * 60 * 1000), // Created 18 days ago
    resolutionPrice: 5520,
    totalPool: '2501.00', // MAS
  },
  {
    id: 1004,
    creator: 'AU12STCVmpQSBeFjDVPM9ErxJJFJtjMZtkTuGtfQzfa3LWN4h2XDJ',
    question: 'Will Tesla stock hit $300 before 2025?',
    description: 'Market resolves if Tesla (TSLA) reaches $300 or higher at any point before January 1, 2025.',
    endTime: Date.now() - (4 * 24 * 60 * 60 * 1000), // Ended 4 days ago
    status: 'Resolved',
    totalUpBets: '420.00', // MAS
    totalDownBets: '580.50', // MAS
    winningOption: 'Down',
    createdAt: Date.now() - (22 * 24 * 60 * 60 * 1000), // Created 22 days ago
    resolutionPrice: 285,
    totalPool: '1000.50', // MAS
  },
  {
    id: 1005,
    creator: 'AU12STCVmpQSBeFjDVPM9ErxJJFJtjMZtkTuGtfQzfa3LWN4h2XDJ',
    question: 'Will Apple announce a new iPhone model in Q4 2024?',
    description: 'Market resolves based on official Apple announcement of a new iPhone model in Q4 2024.',
    endTime: Date.now() - (5 * 24 * 60 * 60 * 1000), // Ended 5 days ago
    status: 'Resolved',
    totalUpBets: '2100.00', // MAS
    totalDownBets: '350.25', // MAS
    winningOption: 'Up',
    createdAt: Date.now() - (25 * 24 * 60 * 60 * 1000), // Created 25 days ago
    resolutionPrice: 1, // Yes/No market
    totalPool: '2450.25', // MAS
  },
]

export default function HomePage() {
  const [filter, setFilter] = useState<'all' | 'active' | 'resolved'>('all')
  const [markets, setMarkets] = useState<Market[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    loadMarkets()
    
    // Reload markets when page becomes visible (e.g., returning from create page)
    const handleVisibilityChange = () => {
      if (!document.hidden) {
        loadMarkets()
      }
    }
    
    document.addEventListener('visibilitychange', handleVisibilityChange)
    
    // Periodically check and update market status (every 30 seconds)
    // This ensures expired markets are automatically locked
    const interval = setInterval(() => {
      loadMarkets()
    }, 30000) // 30 seconds
    
    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange)
      clearInterval(interval)
    }
  }, [])

  const loadMarkets = async () => {
    try {
      setLoading(true)
      setError(null)
      const allMarkets = await getAllMarkets()
      
      // Combine real markets with mock markets (avoid duplicates by ID)
      const realMarketIds = new Set(allMarkets.map(m => m.id))
      const uniqueMockMarkets = MOCK_MARKETS.filter(m => !realMarketIds.has(m.id))
      
      // Combine: real markets first, then mock markets
      const combinedMarkets = [...allMarkets, ...uniqueMockMarkets]
      
      // Sort by createdAt (newest first) - allMarkets is already sorted, but we need to sort combined
      combinedMarkets.sort((a, b) => b.createdAt - a.createdAt)
      
      setMarkets(combinedMarkets)
    } catch (err: any) {
      console.error('Error loading markets:', err)
      setError(err.message || 'Failed to load markets')
      // Even if there's an error, show mock markets
      setMarkets(MOCK_MARKETS)
    } finally {
      setLoading(false)
    }
  }

  // Filter markets based on selected filter
  const filteredMarkets = markets.filter((market) => {
    if (filter === 'active') {
      return market.status === 'Active' && Date.now() < market.endTime
    }
    if (filter === 'resolved') {
      return market.status === 'Resolved'
    }
    return true // 'all'
  })
  
  return (
    <div className="max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold text-white mb-2">
          Real-Time Prediction Markets
        </h1>
        <p className="text-gray-400 text-lg">
          Create and trade on decentralized prediction markets powered by Linera microchains
        </p>
      </div>

      <div className="mb-6 flex items-center justify-between">
        <div className="flex gap-2">
          <button
            onClick={() => setFilter('all')}
            className={`btn ${filter === 'all' ? 'btn-primary' : 'btn-secondary'}`}
          >
            All Markets
          </button>
          <button
            onClick={() => setFilter('active')}
            className={`btn ${filter === 'active' ? 'btn-primary' : 'btn-secondary'}`}
          >
            Active
          </button>
          <button
            onClick={() => setFilter('resolved')}
            className={`btn ${filter === 'resolved' ? 'btn-primary' : 'btn-secondary'}`}
          >
            Resolved
          </button>
        </div>

        <div className="text-gray-400">
          <span className="font-semibold text-white">{filteredMarkets.length}</span> markets found
        </div>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-900 bg-opacity-30 border border-red-700 rounded-lg">
          <p className="text-red-400">{error}</p>
          <button
            onClick={loadMarkets}
            className="mt-2 px-4 py-2 bg-red-700 hover:bg-red-600 text-white rounded transition-colors"
          >
            Retry
          </button>
        </div>
      )}

      <MarketList markets={filteredMarkets} loading={loading} />
    </div>
  )
}




