/**
 * Deploy script for Lynora Prediction Market Contract
 * Uses JSON-RPC API to deploy contract
 */

import 'dotenv/config';
import massaWeb3 from '@massalabs/massa-web3';
const { Account, SmartContract, JsonRpcProvider } = massaWeb3;
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Convert MAS to nanoMAS (1 MAS = 10^9 nanoMAS)
function fromMAS(mas) {
  return BigInt(Math.floor(mas * 1_000_000_000));
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

async function deploy() {
  try {
    console.log('🚀 Starting Lynora Contract Deployment...\n');

    // Read environment variables
    const privateKeyStr = process.env.WALLET_PRIVATE_KEY;
    const rpcUrl = process.env.JSON_RPC_URL_PUBLIC || 'https://buildnet.massa.net/api/v2';

    if (!privateKeyStr) {
      throw new Error('WALLET_PRIVATE_KEY not set in environment variables');
    }

    console.log('📡 Connecting to Massa network:', rpcUrl);

    // Create account from private key
    const account = await Account.fromPrivateKey(privateKeyStr);

    console.log('✅ Connected with address:', account.address.toString());

    // Create provider with account
    const provider = JsonRpcProvider.fromRPCUrl(rpcUrl, account);

    // Read contract bytecode (main contract without constructor)
    const wasmPath = join(__dirname, 'build', 'main.wasm');
    console.log('\n📄 Reading contract bytecode from:', wasmPath);
    const bytecode = readFileSync(wasmPath);
    console.log('✅ Contract size:', bytecode.length, 'bytes');

    // Deploy contract using SmartContract.deploy
    console.log('\n🔨 Deploying contract to Massa Buildnet...');
    console.log('⏳ This may take a few moments...\n');

    console.log('⏳ Deploying contract (this may take 1-2 minutes)...\n');

    const deployedContract = await SmartContract.deploy(
      provider,
      Array.from(bytecode),
      new Uint8Array(), // constructor args (empty)
      {
        fee: fromMAS(0.01), // Minimum fee required
        maxGas: 3_000_000_000n, // Max allowed: ~3.98 billion
        gasPrice: 0n,
        coins: 0n,
        waitFinalExecution: true, // Wait for finalization
      }
    );

    console.log('\n✅ Contract deployed successfully!');
    console.log('━'.repeat(80));
    console.log('📋 DEPLOYMENT DETAILS:');
    console.log('━'.repeat(80));
    console.log('Contract Address:', deployedContract.address.toString());
    console.log('Deployer Address:', account.address.toString());
    console.log('Network:', rpcUrl);
    console.log('Explorer:', `https://buildnet-explorer.massa.net/address/${deployedContract.address.toString()}`);
    console.log('━'.repeat(80));
    
    console.log('\n📝 Next steps:');
    console.log('1. Copy the Contract Address above');
    console.log('2. Add it to frontend/.env:');
    console.log('   VITE_CONTRACT_ADDRESS=' + deployedContract.address.toString());
    console.log('3. Restart your frontend dev server\n');

    console.log('🎉 Deployment completed!\n');

  } catch (error) {
    console.error('\n❌ Deployment failed:', error.message);
    console.error('\nFull error:', error);
    process.exit(1);
  }
}

deploy();


