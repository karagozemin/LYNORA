#!/bin/bash

# LYNORA Build Script
# Builds the Massa contract and frontend

set -e

echo "🚀 Building LYNORA..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Build contract
echo -e "${BLUE}📦 Building AssemblyScript contract...${NC}"
cd contract
npm install
npm run build

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Contract built successfully${NC}"
    echo "  Location: build/main.wasm"
else
    echo "❌ Contract build failed"
    exit 1
fi

cd ..

# Build frontend
echo -e "${BLUE}📦 Building frontend...${NC}"
cd frontend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

npm run build

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Frontend built successfully${NC}"
    echo "  Location: frontend/dist/"
else
    echo "❌ Frontend build failed"
    exit 1
fi

cd ..

echo -e "${GREEN}✓ Build complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Deploy contract: cd contract && node deploy.js"
echo "  2. Update frontend .env with contract address"
echo "  3. Start frontend: cd frontend && npm run dev"



