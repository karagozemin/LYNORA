// Oracle service for market resolution
// Provides price data from external sources

export interface PriceData {
  symbol: string
  price: number
  timestamp: number
  source: string
}

export class OracleService {
  private coingeckoApiUrl = 'https://api.coingecko.com/api/v3'

  /**
   * Get current price from CoinGecko
   */
  async getCurrentPrice(symbol: string): Promise<PriceData> {
    try {
      const coinId = this.getCoinGeckoId(symbol)
      const response = await fetch(
        `${this.coingeckoApiUrl}/simple/price?ids=${coinId}&vs_currencies=usd&include_last_updated_at=true`
      )

      if (!response.ok) {
        throw new Error('Failed to fetch price data')
      }

      const data = await response.json()
      const coinData = data[coinId]

      return {
        symbol,
        price: coinData.usd,
        timestamp: coinData.last_updated_at * 1000,
        source: 'CoinGecko',
      }
    } catch (error) {
      console.error('Error fetching price:', error)
      throw error
    }
  }

  /**
   * Get historical price at specific timestamp
   */
  async getHistoricalPrice(symbol: string, timestamp: number): Promise<PriceData> {
    try {
      const coinId = this.getCoinGeckoId(symbol)
      const date = new Date(timestamp)
      const dateStr = `${date.getDate()}-${date.getMonth() + 1}-${date.getFullYear()}`

      const response = await fetch(
        `${this.coingeckoApiUrl}/coins/${coinId}/history?date=${dateStr}`
      )

      if (!response.ok) {
        throw new Error('Failed to fetch historical price')
      }

      const data = await response.json()

      return {
        symbol,
        price: data.market_data.current_price.usd,
        timestamp,
        source: 'CoinGecko',
      }
    } catch (error) {
      console.error('Error fetching historical price:', error)
      throw error
    }
  }

  /**
   * Resolve market based on price comparison
   */
  async resolveMarket(params: {
    symbol: string
    targetPrice: number
    resolveTime?: number
  }): Promise<{
    winningOption: 'up' | 'down'
    actualPrice: number
    targetPrice: number
  }> {
    const priceData = params.resolveTime
      ? await this.getHistoricalPrice(params.symbol, params.resolveTime)
      : await this.getCurrentPrice(params.symbol)

    const winningOption = priceData.price >= params.targetPrice ? 'up' : 'down'

    return {
      winningOption,
      actualPrice: priceData.price,
      targetPrice: params.targetPrice,
    }
  }

  /**
   * Map common symbols to CoinGecko IDs
   */
  private getCoinGeckoId(symbol: string): string {
    const mapping: Record<string, string> = {
      BTC: 'bitcoin',
      ETH: 'ethereum',
      SOL: 'solana',
      AVAX: 'avalanche-2',
      MATIC: 'matic-network',
      DOT: 'polkadot',
      LINK: 'chainlink',
      UNI: 'uniswap',
      AAVE: 'aave',
    }

    return mapping[symbol.toUpperCase()] || symbol.toLowerCase()
  }

  /**
   * Test oracle connection
   */
  async testConnection(): Promise<boolean> {
    try {
      const btcPrice = await this.getCurrentPrice('BTC')
      return btcPrice.price > 0
    } catch {
      return false
    }
  }
}

// Create singleton instance
export const oracleService = new OracleService()

// Example usage:
// const result = await oracleService.resolveMarket({
//   symbol: 'BTC',
//   targetPrice: 100000,
// })
// console.log(`Winner: ${result.winningOption}`)
// console.log(`Price: $${result.actualPrice} vs Target: $${result.targetPrice}`)



