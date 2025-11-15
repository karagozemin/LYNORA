import { Link } from 'react-router-dom'
import { formatDistanceToNow } from 'date-fns'
import clsx from 'clsx'
import { Market } from '../lib/contract'
import ElectricBorder from './ElectricBorder'

interface MarketCardProps {
  market: Market
}

// Color palette for options
const OPTION_COLORS = [
  'bg-blue-600',
  'bg-purple-600',
  'bg-pink-600',
  'bg-indigo-600',
  'bg-teal-600',
  'bg-orange-600',
  'bg-cyan-600',
  'bg-rose-600',
]

const OPTION_COLORS_LIGHT = [
  'bg-blue-500',
  'bg-purple-500',
  'bg-pink-500',
  'bg-indigo-500',
  'bg-teal-500',
  'bg-orange-500',
  'bg-cyan-500',
  'bg-rose-500',
]

export default function MarketCard({ market }: MarketCardProps) {
  const endTime = new Date(market.endTime) // endTime is already in milliseconds
  const isActive = market.status === 'Active'
  const timeLeft = formatDistanceToNow(endTime, { addSuffix: true })
  
  // Convert totalPool from nanoMAS (string) to MAS (number)
  const totalPoolNano = BigInt(market.totalPool || '0')
  const totalPool = Number(totalPoolNano) / 1e9
  
  // Check if this is a question-answer market (has options)
  const isQuestionAnswer = market.options && market.options.length > 0
  const options = market.options || []
  const bets = market.bets || {}
  
  // Calculate option totals and percentages
  const optionTotals = options.map((opt, idx) => {
    const betAmountNano = BigInt(bets[opt] || '0')
    const betAmountMAS = Number(betAmountNano) / 1e9
    return {
      option: opt,
      amount: betAmountMAS,
      color: OPTION_COLORS[idx % OPTION_COLORS.length],
      colorLight: OPTION_COLORS_LIGHT[idx % OPTION_COLORS_LIGHT.length],
    }
  })
  
  // Calculate total from all options
  const optionTotalPool = optionTotals.reduce((sum, opt) => sum + opt.amount, 0)
  
  // Calculate percentages based on option total pool
  const optionTotalsWithPercent = optionTotals.map(opt => ({
    ...opt,
    percentage: optionTotalPool > 0 ? (opt.amount / optionTotalPool) * 100 : (100 / options.length),
  }))
  
  // For old format (UP/DOWN), use green/red
  const upBets = parseFloat(market.totalUpBets || '0') || 0
  const downBets = parseFloat(market.totalDownBets || '0') || 0
  const oldFormatTotal = upBets + downBets
  const upPercentage = oldFormatTotal > 0 ? (upBets / oldFormatTotal) * 100 : 50
  const downPercentage = oldFormatTotal > 0 ? (downBets / oldFormatTotal) * 100 : 50

  // Determine border color - each market gets a unique color based on ID
  // Use a palette of vibrant electric colors
  const ELECTRIC_COLORS = [
    '#7df9ff', // Electric cyan
    '#9333ea', // Purple
    '#db2777', // Pink
    '#4f46e5', // Indigo
    '#0d9488', // Teal
    '#ea580c', // Orange
    '#0891b2', // Cyan
    '#e11d48', // Rose
    '#10b981', // Green
    '#f59e0b', // Amber
    '#3b82f6', // Blue
    '#ec4899', // Fuchsia
  ]

  const getBorderColor = () => {
    // Use market ID to get a consistent color for each market
    const colorIndex = market.id % ELECTRIC_COLORS.length
    let baseColor = ELECTRIC_COLORS[colorIndex]
    
    // Adjust color based on status
    if (!isActive) {
      if (market.status === 'Resolved') {
        // Resolved markets - slightly dimmer green
        return '#10b981'
      } else {
        // Locked markets - slightly dimmer orange
        return '#f59e0b'
      }
    }
    
    return baseColor
  }

  const borderColor = getBorderColor()

  return (
    <ElectricBorder
      color={borderColor}
      speed={0.3}
      chaos={0.15}
      thickness={1.5}
      style={{ borderRadius: 12 }}
      className="market-card-border"
    >
      <div className="card transition-all hover:shadow-lg bg-gray-800 border-0">
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <Link to={`/market/${market.id}`}>
            <h3 className="text-xl font-semibold text-white hover:text-primary-400 transition-colors line-clamp-2">
              {market.question}
            </h3>
          </Link>
          {market.description && (
            <p className="text-gray-400 text-sm mt-2 line-clamp-2">{market.description}</p>
          )}
        </div>
        
        <span className={clsx(
          'badge ml-4 whitespace-nowrap',
          isActive ? 'badge-success' : 
          market.status === 'Resolved' ? 'badge-info' : 'badge-warning'
        )}>
          {market.status}
        </span>
      </div>

      <div className="mb-4">
        <div className="flex items-center justify-between text-sm text-gray-400 mb-3">
          <span className="font-medium">Total Pool</span>
          <span className="font-mono font-semibold text-white">{totalPool.toFixed(2)} MAS</span>
        </div>
        
        {isQuestionAnswer && options.length > 0 ? (
          // Question-answer format with options
          <>
            <div className="flex h-10 rounded-lg overflow-hidden mb-3 shadow-inner">
              {optionTotalsWithPercent.map((opt, idx) => (
                <div
                  key={idx}
                  className={clsx(
                    opt.color,
                    'flex items-center justify-center text-white text-xs font-medium transition-all',
                    opt.percentage > 0 ? 'min-w-[2px]' : 'w-0'
                  )}
                  style={{ width: `${Math.max(opt.percentage, 0)}%` }}
                  title={`${opt.option}: ${opt.amount.toFixed(2)} MAS (${opt.percentage.toFixed(1)}%)`}
                >
                  {opt.percentage > 8 && (
                    <span className="truncate px-1">{opt.percentage.toFixed(0)}%</span>
                  )}
                </div>
              ))}
            </div>
            
            <div className="grid grid-cols-2 gap-2">
              {optionTotalsWithPercent.map((opt, idx) => (
                <div
                  key={idx}
                  className={clsx(
                    'flex items-center justify-between p-2 rounded-lg text-xs',
                    opt.colorLight,
                    'bg-opacity-20'
                  )}
                >
                  <span className="text-gray-300 font-medium truncate mr-2">{opt.option}</span>
                  <span className="text-white font-semibold whitespace-nowrap">
                    {opt.amount.toFixed(2)} MAS
                  </span>
                </div>
              ))}
            </div>
          </>
        ) : (
          // Old format (UP/DOWN)
          <>
            <div className="flex h-10 rounded-lg overflow-hidden mb-3 shadow-inner">
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
            
            <div className="flex items-center justify-between text-sm">
              <span className="text-green-400 font-medium">↑ UP: {upBets.toFixed(2)} MAS</span>
              <span className="text-red-400 font-medium">↓ DOWN: {downBets.toFixed(2)} MAS</span>
            </div>
          </>
        )}
      </div>

      <div className="mt-4 pt-4 border-t border-gray-700 flex items-center justify-between text-sm text-gray-400">
        <span className="flex items-center gap-1">
          <span className={clsx(
            'w-2 h-2 rounded-full',
            isActive ? 'bg-green-500' : 'bg-gray-500'
          )}></span>
          {isActive ? `Ends ${timeLeft}` : `Ended ${timeLeft}`}
        </span>
        <span className="font-mono text-gray-500">#{market.id}</span>
      </div>
      </div>
    </ElectricBorder>
  )
}



