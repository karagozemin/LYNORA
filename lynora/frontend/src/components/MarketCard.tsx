import { Link } from 'react-router-dom'
import { formatDistanceToNow } from 'date-fns'
import clsx from 'clsx'
import { Market } from '../lib/contract'

interface MarketCardProps {
  market: Market
  onBet?: (marketId: number, option: 'up' | 'down') => void
}

export default function MarketCard({ market, onBet }: MarketCardProps) {
  const endTime = new Date(market.endTime) // endTime is already in milliseconds
  const isActive = market.status === 'Active'
  const timeLeft = formatDistanceToNow(endTime, { addSuffix: true })
  
  const totalPool = parseFloat(market.totalPool) || 0
  const upBets = parseFloat(market.totalUpBets || '0') || 0
  const downBets = parseFloat(market.totalDownBets || '0') || 0
  
  const upPercentage = totalPool > 0 ? (upBets / totalPool) * 100 : 50
  const downPercentage = totalPool > 0 ? (downBets / totalPool) * 100 : 50

  return (
    <div className="card hover:border-primary-500 transition-all">
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <Link to={`/market/${market.id}`}>
            <h3 className="text-xl font-semibold text-white hover:text-primary-400 transition-colors">
              {market.question}
            </h3>
          </Link>
          {market.description && (
            <p className="text-gray-400 text-sm mt-2">{market.description}</p>
          )}
        </div>
        
        <span className={clsx(
          'badge ml-4',
          isActive ? 'badge-success' : 'badge-warning'
        )}>
          {market.status}
        </span>
      </div>

      <div className="mb-4">
        <div className="flex items-center justify-between text-sm text-gray-400 mb-2">
          <span>Pool Distribution</span>
          <span className="font-mono">{totalPool.toFixed(2)} MAS</span>
        </div>
        
        <div className="flex h-8 rounded-lg overflow-hidden">
          <div 
            className="bg-green-600 flex items-center justify-center text-white text-sm font-medium"
            style={{ width: `${upPercentage}%` }}
          >
            {upPercentage > 15 && `${upPercentage.toFixed(0)}%`}
          </div>
          <div 
            className="bg-red-600 flex items-center justify-center text-white text-sm font-medium"
            style={{ width: `${downPercentage}%` }}
          >
            {downPercentage > 15 && `${downPercentage.toFixed(0)}%`}
          </div>
        </div>
        
        <div className="flex items-center justify-between mt-2 text-sm">
          <span className="text-green-400">↑ UP: {upBets.toFixed(2)}</span>
          <span className="text-red-400">↓ DOWN: {downBets.toFixed(2)}</span>
        </div>
      </div>

      {isActive && onBet && (
        <div className="flex gap-3">
          <button
            onClick={() => onBet(market.id, 'up')}
            className="flex-1 btn bg-green-600 hover:bg-green-700"
          >
            ↑ Bet UP
          </button>
          <button
            onClick={() => onBet(market.id, 'down')}
            className="flex-1 btn bg-red-600 hover:bg-red-700"
          >
            ↓ Bet DOWN
          </button>
        </div>
      )}

      <div className="mt-4 pt-4 border-t border-gray-700 flex items-center justify-between text-sm text-gray-400">
        <span>Ends {timeLeft}</span>
        <span>ID: {market.id}</span>
      </div>
    </div>
  )
}



