# LYNORA Quick Start Guide

Get LYNORA running in 10 minutes!

## Step 1: Prerequisites (2 min)

Install required tools:

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add wasm32 target
rustup target add wasm32-unknown-unknown

# Install Linera CLI
cargo install linera-cli

# Install Node.js (if not installed)
# Visit https://nodejs.org or use nvm
```

## Step 2: Clone & Setup (1 min)

```bash
# Clone repository
git clone <your-repo-url>
cd lynora

# Make scripts executable
chmod +x scripts/*.sh
```

## Step 3: Build (3 min)

```bash
# Build contract and frontend
./scripts/build.sh
```

Expected output:
```
🚀 Building LYNORA...
📦 Building Rust contract...
✓ Contract built successfully
📦 Building frontend...
✓ Frontend built successfully
✓ Build complete!
```

## Step 4: Deploy (2 min)

```bash
# Deploy to Testnet Conway
./scripts/deploy.sh
```

This will:
- Deploy the smart contract
- Get your Application ID and Chain ID
- Update frontend .env file

## Step 5: Run Locally (1 min)

Open two terminals:

**Terminal 1** - Start Linera service:
```bash
linera service --port 8080
```

**Terminal 2** - Start frontend:
```bash
cd frontend
npm run dev
```

## Step 6: Test (1 min)

1. Open http://localhost:3000
2. Click "Connect Wallet"
3. Connect with Dynamic Labs
4. You're ready to go!

## What's Next?

### Create Your First Market

1. Click "Create Market"
2. Enter question: "Will Bitcoin reach $100,000?"
3. Set duration: 7 days
4. Click "Create Market"
5. Wait for confirmation ✅

### Place Your First Bet

1. Go to homepage
2. Find a market
3. Click "Bet UP" or "Bet DOWN"
4. Enter amount
5. Confirm ✅

### Track Your Markets

1. Click "My Markets"
2. See markets you created
3. See your active bets
4. Track your positions

## Troubleshooting

### Build fails?

```bash
# Clean and rebuild
cd contract
cargo clean
cd ..
./scripts/build.sh
```

### Deploy fails?

```bash
# Check Linera CLI
linera --version

# Request testnet tokens
linera faucet --testnet conway

# Try again
./scripts/deploy.sh
```

### Frontend won't start?

```bash
# Reinstall dependencies
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### Can't connect wallet?

1. Make sure Linera service is running
2. Check .env file has correct values
3. Add Dynamic Labs environment ID

## Common Commands

```bash
# Build everything
./scripts/build.sh

# Deploy contract
./scripts/deploy.sh

# Run tests
./scripts/test.sh

# Start Linera service
linera service --port 8080

# Start frontend
cd frontend && npm run dev

# Build for production
cd frontend && npm run build
```

## Environment Variables

Update `frontend/.env`:

```env
# Required
VITE_CONTRACT_ADDRESS=<from deploy.sh>
VITE_CHAIN_ID=<from deploy.sh>

# Optional (defaults work for local dev)
VITE_GRAPHQL_HTTP_URL=http://localhost:8080/graphql
VITE_GRAPHQL_WS_URL=ws://localhost:8080/graphql

# Get from Dynamic Labs dashboard
VITE_DYNAMIC_ENVIRONMENT_ID=your_id_here
```

## Production Deployment

### Deploy Frontend to Vercel

```bash
cd frontend
npm install -g vercel
vercel
```

### Deploy Frontend to Netlify

```bash
cd frontend
npm run build
npx netlify-cli deploy --prod --dir=dist
```

### Deploy to Linera DeWeb

```bash
cd frontend
npm run build
linera deweb deploy dist/
```

## Need Help?

- 📚 Read [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions
- 🏗️ Read [ARCHITECTURE.md](ARCHITECTURE.md) to understand the system
- 🎥 Watch [DEMO_SCRIPT.md](DEMO_SCRIPT.md) for demo guidance
- 📝 Check [SUBMISSION.md](SUBMISSION.md) for buildathon details

## Quick Links

- Linera Docs: https://docs.linera.io
- Discord: https://discord.gg/linera
- Buildathon: https://linera.io/buildathon

---

**You're all set! 🚀 Start creating markets and placing bets!**



