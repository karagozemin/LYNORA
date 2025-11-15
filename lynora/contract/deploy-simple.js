/**
 * Simple deploy script using JSON-RPC API
 */

import 'dotenv/config';
import { Account } from '@massalabs/massa-web3';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

async function deploy() {
  try {
    console.log('🚀 Starting Lynora Contract Deployment...\n');

    const privateKey = process.env.WALLET_PRIVATE_KEY;
    const rpcUrl = process.env.JSON_RPC_URL_PUBLIC || 'https://buildnet.massa.net/api/v2';

    if (!privateKey) {
      throw new Error('WALLET_PRIVATE_KEY not set in environment variables');
    }

    console.log('📡 Connecting to Massa network:', rpcUrl);

    const account = await Account.fromPrivateKey(privateKey, rpcUrl);
    console.log('✅ Connected with address:', account.address.toString());

    const wasmPath = join(__dirname, 'build', 'main.wasm');
    console.log('\n📄 Reading contract bytecode...');
    const bytecode = readFileSync(wasmPath);
    console.log('✅ Contract size:', bytecode.length, 'bytes');

    console.log('\n🔨 Deploying contract...');
    console.log('⚠️  Note: massa-web3 does not have a direct deploy method.');
    console.log('📝 Please use Massa Station or Bearby wallet to deploy the contract.');
    console.log('\n📋 Contract Details:');
    console.log('   Bytecode file:', wasmPath);
    console.log('   Size:', bytecode.length, 'bytes');
    console.log('   Deployer:', account.address.toString());
    console.log('\n💡 To deploy:');
    console.log('   1. Open Massa Station or Bearby wallet');
    console.log('   2. Go to Smart Contracts section');
    console.log('   3. Deploy new contract');
    console.log('   4. Upload:', wasmPath);
    console.log('   5. Copy the contract address after deployment\n');

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

deploy();

