#!/bin/bash

# LYNORA Deployment Script
# Deploys the contract to Linera Testnet Conway

set -e

echo "🚀 Deploying LYNORA to Testnet Conway..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if Linera CLI is installed
if ! command -v linera &> /dev/null; then
    echo "❌ Linera CLI not found. Please install it first:"
    echo "   cargo install linera-cli"
    exit 1
fi

# Check if contract is built
if [ ! -f "contract/target/wasm32-unknown-unknown/release/lynora.wasm" ]; then
    echo -e "${YELLOW}Contract not built. Building now...${NC}"
    cd contract
    cargo build --release --target wasm32-unknown-unknown
    cd ..
fi

# Deploy contract
echo -e "${BLUE}📡 Deploying contract to Testnet Conway...${NC}"
cd contract

OUTPUT=$(linera project publish-and-create 2>&1)
echo "$OUTPUT"

# Extract application ID and chain ID from output
APP_ID=$(echo "$OUTPUT" | grep -oP 'Application ID: \K[a-f0-9]+' || echo "")
CHAIN_ID=$(echo "$OUTPUT" | grep -oP 'Chain ID: \K[a-f0-9]+' || echo "")

if [ -z "$APP_ID" ] || [ -z "$CHAIN_ID" ]; then
    echo "❌ Failed to extract deployment information"
    echo "Please check the output above and manually update .env"
    exit 1
fi

echo -e "${GREEN}✓ Contract deployed successfully!${NC}"
echo ""
echo "Application ID: $APP_ID"
echo "Chain ID: $CHAIN_ID"
echo ""

# Update frontend .env
cd ../frontend

if [ -f ".env" ]; then
    echo -e "${YELLOW}Updating .env file...${NC}"
    sed -i.bak "s/VITE_CONTRACT_ADDRESS=.*/VITE_CONTRACT_ADDRESS=$APP_ID/" .env
    sed -i.bak "s/VITE_CHAIN_ID=.*/VITE_CHAIN_ID=$CHAIN_ID/" .env
    rm .env.bak
else
    echo -e "${YELLOW}Creating .env file...${NC}"
    cat > .env << EOF
VITE_CONTRACT_ADDRESS=$APP_ID
VITE_CHAIN_ID=$CHAIN_ID
VITE_GRAPHQL_HTTP_URL=http://localhost:8080/graphql
VITE_GRAPHQL_WS_URL=ws://localhost:8080/graphql
VITE_DYNAMIC_ENVIRONMENT_ID=your_dynamic_environment_id
EOF
fi

echo -e "${GREEN}✓ Frontend configuration updated${NC}"
echo ""
echo "Next steps:"
echo "  1. Start Linera service: linera service --port 8080"
echo "  2. Test locally: cd frontend && npm run dev"
echo "  3. Deploy frontend: npm run build && vercel deploy"
echo ""
echo "Don't forget to update VITE_DYNAMIC_ENVIRONMENT_ID in .env!"

cd ..



