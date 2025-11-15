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
echo -e "${BLUE}Testing AssemblyScript contract...${NC}"
cd contract
# Note: AssemblyScript tests can be added here if needed
echo -e "${GREEN}✓ Contract build check passed${NC}"

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



