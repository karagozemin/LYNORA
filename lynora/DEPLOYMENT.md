# LYNORA Deployment Guide - Massa Blockchain

This guide will help you deploy LYNORA to Massa BuildNet.

## Prerequisites

### Required Tools

1. **Node.js** (18+)
```bash
# Using nvm
nvm install 18
nvm use 18
```

2. **Massa Station Wallet**
   - Download from: https://station.massa.net
   - Create a wallet and save your seed phrase
   - Switch to BuildNet in settings

3. **Get BuildNet Tokens**
   - Join Massa Discord: https://discord.gg/massa
   - Go to `#buildernet-faucet` channel
   - Request tokens: `/faucet <your_massa_address>`
   - Wait for confirmation (you'll receive ~100 MAS)

## Step 1: Set Up Project

1. **Clone the repository**
```bash
git clone <repo-url>
cd lynora
```

2. **Install dependencies**
```bash
# Install contract dependencies
cd contract
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

## Step 2: Build Smart Contract

1. **Navigate to contract directory**
```bash
cd contract
```

2. **Build the contract**
```bash
npm run build
```

This will create `build/main.wasm` - your compiled smart contract.

3. **Verify the build**
```bash
ls -lh build/main.wasm
```

You should see a `.wasm` file (typically 10-50 KB).

## Step 3: Deploy Smart Contract

### Option A: Using Massa Station (Recommended for Beginners)

1. Open Massa Station
2. Go to "Deploy Contract" section
3. Upload `build/main.wasm`
4. Set deployment parameters:
   - **Gas**: Auto (or 1,000,000)
   - **Coins**: 0 (no coins needed for deployment)
5. Click "Deploy"
6. Confirm transaction in Massa Station
7. **Copy the contract address** (starts with `AS...`)

### Option B: Using massa-sc-scripts CLI

1. **Configure deployment** in `package.json`:
```json
{
  "scripts": {
    "deploy": "massa-sc-scripts deploy"
  }
}
```

2. **Run deployment**
```bash
npm run deploy
```

3. **Enter your wallet private key** when prompted
4. **Copy the contract address** from output

### Option C: Using Massa Web3 Directly

Create a deployment script `deploy.js`:

```javascript
const { ClientFactory, DefaultProviderUrls, WalletClient, fromMAS } = require('@massalabs/massa-web3');
const fs = require('fs');
const path = require('path');

async function deploy() {
  // Load contract bytecode
  const wasmPath = path.join(__dirname, 'build', 'main.wasm');
  const contractCode = fs.readFileSync(wasmPath);

  // Create client with your private key
  const privateKey = process.env.MASSA_PRIVATE_KEY;
  if (!privateKey) {
    throw new Error('MASSA_PRIVATE_KEY not set');
  }

  const client = await ClientFactory.createDefaultClient(
    DefaultProviderUrls.BUILDNET,
    true,
    {
      publicKey: '', // Will be derived
      privateKey: privateKey,
    }
  );

  console.log('Deploying contract...');

  // Deploy contract
  const result = await client.smartContracts().deploySmartContract({
    contractDataBinary: Array.from(contractCode),
    maxGas: 1000000,
    coins: fromMAS(0),
  });

  console.log('Contract deployed!');
  console.log('Contract Address:', result);
  
  return result;
}

deploy().catch(console.error);
```

Run with:
```bash
MASSA_PRIVATE_KEY=your_private_key node deploy.js
```

## Step 4: Configure Frontend

1. **Navigate to frontend directory**
```bash
cd frontend
```

2. **Create `.env` file**
```bash
cp .env.example .env
```

If `.env.example` doesn't exist, create `.env`:

```env
# Massa Contract Address (from deployment step)
VITE_CONTRACT_ADDRESS=AS12...your_contract_address_here

# Optional: CoinGecko API for oracle (if you implement it)
VITE_COINGECKO_API_KEY=your_api_key
```

3. **Update contract address**
   - Open `.env`
   - Paste your contract address from Step 3

## Step 5: Test Locally

1. **Start development server**
```bash
cd frontend
npm run dev
```

2. **Open browser**
   - Go to `http://localhost:5173`
   - Connect Massa Station wallet
   - Create a test market
   - Place a test bet

3. **Verify on Explorer**
   - Go to https://buildnet-explorer.massa.net
   - Search for your contract address
   - View operations and state

## Step 6: Deploy Frontend

### Option A: Massa DeWeb (Recommended for Buildathon)

**Note**: DeWeb deployment is experimental. Use traditional hosting for now.

1. **Build frontend**
```bash
npm run build
```

2. **Install DeWeb CLI** (if available)
```bash
npm install -g @massalabs/massa-deweb-cli
```

3. **Deploy to DeWeb**
```bash
massa-deweb deploy dist/
```

### Option B: Vercel (Quick & Easy)

1. **Install Vercel CLI**
```bash
npm install -g vercel
```

2. **Deploy**
```bash
cd frontend
vercel
```

3. **Follow prompts**:
   - Link to your account
   - Set project name
   - Confirm settings

4. **Add environment variables** in Vercel dashboard:
   - `VITE_CONTRACT_ADDRESS`: Your contract address

### Option C: Netlify

1. **Build the app**
```bash
npm run build
```

2. **Deploy**
```bash
npx netlify-cli deploy --prod --dir=dist
```

3. **Set environment variables** in Netlify dashboard

### Option D: GitHub Pages

1. **Update `vite.config.ts`**:
```typescript
export default defineConfig({
  base: '/lynora/', // Your repo name
  // ...
})
```

2. **Build**
```bash
npm run build
```

3. **Deploy to gh-pages branch**
```bash
npm install -g gh-pages
gh-pages -d dist
```

## Step 7: Verify Deployment

### Test Smart Contract

1. **Read market data** (if you have markets):
```bash
# Using massa-web3 or Massa Station
# Call getMarketDetails(0) to read market #0
```

2. **Create test market** through frontend

3. **Place test bet**

4. **Check on Explorer**:
   - https://buildnet-explorer.massa.net
   - Search your contract address
   - View operations and events

### Test Frontend

- [ ] Homepage loads
- [ ] Wallet connects (Massa Station)
- [ ] Can create market
- [ ] Can view markets
- [ ] Can place bets
- [ ] UI updates correctly
- [ ] No console errors

## Troubleshooting

### Contract Deployment Fails

**Error**: "Insufficient balance"
- **Solution**: Get more MAS from faucet

**Error**: "Invalid bytecode"
- **Solution**: Rebuild contract with `npm run build`

**Error**: "Gas limit exceeded"
- **Solution**: Increase max gas to 2,000,000

### Frontend Connection Issues

**Error**: "Contract not found"
- **Solution**: Verify contract address in `.env`

**Error**: "Wallet not detected"
- **Solution**: Install Massa Station and refresh page

**Error**: "Network mismatch"
- **Solution**: Switch Massa Station to BuildNet

### Build Errors

**AssemblyScript build fails**:
```bash
cd contract
rm -rf node_modules package-lock.json
npm install
npm run build
```

**Frontend build fails**:
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run build
```

## Production Checklist

- [ ] Smart contract deployed to BuildNet
- [ ] Contract address in frontend `.env`
- [ ] Frontend builds without errors
- [ ] Wallet connection works
- [ ] Create market works
- [ ] Place bet works
- [ ] UI responsive on mobile
- [ ] Error handling tested
- [ ] Explorer shows operations

## Useful Commands

### Contract

```bash
# Build contract
npm run build

# Test contract
npm run test

# Deploy contract
npm run deploy
```

### Frontend

```bash
# Development
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint
npm run lint
```

## Network Information

### Massa BuildNet

- **Chain ID**: 77658366
- **RPC URL**: https://buildnet.massa.net/api/v2
- **Explorer**: https://buildnet-explorer.massa.net
- **Faucet**: Discord #buildernet-faucet channel

### Massa MainNet (Future)

- **Chain ID**: 77658377
- **RPC URL**: https://mainnet.massa.net/api/v2
- **Explorer**: https://explorer.massa.net
- **No Faucet**: Need to buy MAS

## Next Steps

1. Test all features thoroughly
2. Create demo video (max 5 minutes)
3. Prepare pitch deck (optional, max 10 slides)
4. Update README with deployment URLs
5. Submit to buildathon

## Support Resources

- **Massa Docs**: https://docs.massa.net
- **Massa Discord**: https://discord.gg/massa
- **GitHub Issues**: Report bugs in your repo
- **Massa Forum**: https://forum.massa.net

## Security Notes

⚠️ **Important**:
- Never commit private keys to git
- Use environment variables for sensitive data
- Test on BuildNet before MainNet
- Audit contract before handling real funds

---

Good luck with your deployment! 🚀
