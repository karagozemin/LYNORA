import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Header from './components/Header'
import HomePage from './pages/HomePage'
import CreateMarketPage from './pages/CreateMarketPage'
import MarketDetailPage from './pages/MarketDetailPage'
import MyMarketsPage from './pages/MyMarketsPage'

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900">
        <Header />
        <main className="container mx-auto px-4 py-8">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/create" element={<CreateMarketPage />} />
            <Route path="/market/:id" element={<MarketDetailPage />} />
            <Route path="/my-markets" element={<MyMarketsPage />} />
          </Routes>
        </main>
        
        </div>
    </Router>
  )
}

export default App



