#!/bin/bash

# LYNORA Testing Script
# Runs tests for contract and frontend

set -e

echo "🧪 Testing LYNORA..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test contract
echo -e "${BLUE}Testing Rust contract...${NC}"
cd contract
cargo test

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Contract tests passed${NC}"
else
    echo "❌ Contract tests failed"
    exit 1
fi

cd ..

# Test frontend
echo -e "${BLUE}Testing frontend...${NC}"
cd frontend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

npm run lint

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Frontend tests passed${NC}"
else
    echo "❌ Frontend tests failed"
    exit 1
fi

cd ..

echo -e "${GREEN}✓ All tests passed!${NC}"



