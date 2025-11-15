import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import MarketCard from '../components/MarketCard'
import { useWallet } from '../lib/wallet'
import { getAllMarkets, getUserBetDetails, Market } from '../lib/contract'

export default function MyMarketsPage() {
  const { isConnected, address } = useWallet()
  const [myMarkets, setMyMarkets] = useState<Market[]>([])
  const [myBets, setMyBets] = useState<(Market & { myBet: { option: 'Up' | 'Down'; amount: string } })[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    if (isConnected && address) {
      loadMyData()
    }
    
    // Reload data when page becomes visible
    const handleVisibilityChange = () => {
      if (!document.hidden && isConnected && address) {
        loadMyData()
      }
    }
    
    document.addEventListener('visibilitychange', handleVisibilityChange)
    
    // Periodically check and update market status (every 30 seconds)
    // This ensures expired markets are automatically locked
    const interval = setInterval(() => {
      if (isConnected && address) {
        loadMyData()
      }
    }, 30000) // 30 seconds
    
    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange)
      clearInterval(interval)
    }
  }, [isConnected, address])

  const loadMyData = async () => {
    try {
      setLoading(true)
      setError(null)
      
      const allMarkets = await getAllMarkets()
      
      // Filter markets I created
      const created = allMarkets.filter(m => m.creator.toLowerCase() === address?.toLowerCase())
      setMyMarkets(created)
      
      // Find markets I bet on
      const betsWithMarkets = []
      for (const market of allMarkets) {
        try {
          const bet = await getUserBetDetails(market.id, address!)
          if (bet) {
            betsWithMarkets.push({
              ...market,
              myBet: {
                option: bet.option,
                amount: bet.amount,
              },
            })
          }
        } catch (err) {
          // User hasn't bet on this market, skip
        }
      }
      setMyBets(betsWithMarkets)
    } catch (err: any) {
      console.error('Error loading my data:', err)
      setError(err.message || 'Failed to load data')
    } finally {
      setLoading(false)
    }
  }

  if (!isConnected) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="text-center py-12">
          <div className="text-6xl mb-4">🔒</div>
          <h2 className="text-2xl font-bold text-white mb-2">
            Connect Your Wallet
          </h2>
          <p className="text-gray-400 mb-6">
            Please connect your wallet to view your markets and bets
          </p>
        </div>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="max-w-7xl mx-auto">
        <div className="text-center py-12">
          <div className="text-4xl mb-4">⏳</div>
          <p className="text-gray-400">Loading your markets and bets...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold text-white mb-2">
          My Markets & Bets
        </h1>
        <p className="text-gray-400 text-lg">
          Manage your prediction markets and track your positions
        </p>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-900 bg-opacity-30 border border-red-700 rounded-lg">
          <p className="text-red-400">{error}</p>
          <button
            onClick={loadMyData}
            className="mt-2 px-4 py-2 bg-red-700 hover:bg-red-600 text-white rounded transition-colors"
          >
            Retry
          </button>
        </div>
      )}

      {/* Markets I Created */}
      <section className="mb-12">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-semibold text-white">
            Markets I Created ({myMarkets.length})
          </h2>
          <Link to="/create" className="btn btn-primary">
            + Create New Market
          </Link>
        </div>

        {myMarkets.length === 0 ? (
          <div className="card text-center py-12">
            <div className="text-5xl mb-4">📊</div>
            <h3 className="text-xl font-semibold text-white mb-2">
              No markets created yet
            </h3>
            <p className="text-gray-400 mb-4">
              Launch your first prediction market on your microchain
            </p>
            <Link to="/create" className="btn btn-primary">
              Create Market
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {myMarkets.map((market) => (
              <MarketCard key={market.id} market={market} />
            ))}
          </div>
        )}
      </section>

      {/* Markets I Bet On */}
      <section>
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-semibold text-white">
            Markets I Bet On ({myBets.length})
          </h2>
        </div>

        {myBets.length === 0 ? (
          <div className="card text-center py-12">
            <div className="text-5xl mb-4">🎯</div>
            <h3 className="text-xl font-semibold text-white mb-2">
              No active bets
            </h3>
            <p className="text-gray-400 mb-4">
              Browse markets and place your first bet
            </p>
            <Link to="/" className="btn btn-primary">
              Explore Markets
            </Link>
          </div>
        ) : (
          <div className="space-y-4">
            {myBets.map((market) => (
              <div key={market.id} className="card">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <Link to={`/market/${market.id}`}>
                      <h3 className="text-xl font-semibold text-white hover:text-primary-400 transition-colors mb-2">
                        {market.question}
                      </h3>
                    </Link>
                    <div className="flex items-center gap-4 text-sm">
                      <span className="text-gray-400">
                        Status: <span className="text-white">{market.status}</span>
                      </span>
                      <span className="text-gray-400">
                        Pool: <span className="text-white">{market.totalPool} MAS</span>
                      </span>
                    </div>
                  </div>
                  
                  {market.myBet && (
                    <div className={`px-4 py-2 rounded-lg ${
                      market.myBet.option === 'Up' 
                        ? 'bg-green-900 bg-opacity-30 border border-green-700' 
                        : 'bg-red-900 bg-opacity-30 border border-red-700'
                    }`}>
                      <div className="text-sm text-gray-400 mb-1">My Position</div>
                      <div className={`font-semibold ${
                        market.myBet.option === 'Up' ? 'text-green-400' : 'text-red-400'
                      }`}>
                        {market.myBet.option === 'Up' ? '↑' : '↓'} {market.myBet.option}
                      </div>
                      <div className="text-white font-semibold">
                        {market.myBet.amount} MAS
                      </div>
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </section>
    </div>
  )
}



