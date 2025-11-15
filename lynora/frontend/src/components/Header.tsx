import { Link } from 'react-router-dom'
import { useWallet } from '../lib/wallet'
import { shortAddress } from '../lib/massa'
import logo from '../assets/logo.jpeg'

export default function Header() {
  const { isConnected, address, connect, disconnect } = useWallet()

  const handleConnect = async () => {
    try {
      await connect()
    } catch (error: any) {
      console.error('Failed to connect:', error)
      alert(error.message || 'Failed to connect wallet. Please install Massa Station or Bearby Wallet.')
    }
  }

  return (
    <header className="bg-black bg-opacity-30 backdrop-blur-md border-b border-gray-700 border-opacity-50">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-8">
            <Link to="/" className="flex items-center space-x-3">
              <img 
                src={logo} 
                alt="LYNORA Logo" 
                className="h-12 w-auto object-contain"
              />
              <div>
                <span className="text-2xl font-bold text-white">LYNORA</span>
                <p className="text-xs text-gray-400">on Massa</p>
              </div>
            </Link>
            
            <nav className="hidden md:flex items-center space-x-6">
              <Link 
                to="/" 
                className="text-gray-300 hover:text-white transition-colors"
              >
                Markets
              </Link>
              <Link 
                to="/create" 
                className="text-gray-300 hover:text-white transition-colors"
              >
                Create
              </Link>
              <Link 
                to="/my-markets" 
                className="text-gray-300 hover:text-white transition-colors"
              >
                My Markets
              </Link>
            </nav>
          </div>

          <div className="flex items-center space-x-4">
            {isConnected && address ? (
              <div className="flex items-center gap-3">
                <div className="px-4 py-2 bg-gray-700 rounded-lg">
                  <div className="text-gray-400 text-xs">Connected</div>
                  <div className="text-white font-medium">{shortAddress(address)}</div>
                </div>
                <button
                  onClick={disconnect}
                  className="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg transition-colors"
                >
                  Disconnect
                </button>
              </div>
            ) : (
              <button
                onClick={handleConnect}
                className="px-6 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg transition-all"
              >
                Connect Massa Wallet
              </button>
            )}
          </div>
        </div>
      </div>
    </header>
  )
}
