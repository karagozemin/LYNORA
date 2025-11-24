/**
 * Massa Wallet Connection
 * Handles wallet connection using Massa Station or Bearby Wallet
 * Automatically detects and connects to available Massa-compatible wallets
 */

import { useState, useEffect } from 'react';
import { getWallets, Wallet } from '@massalabs/wallet-provider';
import { Provider } from '@massalabs/massa-web3';
import { CURRENT_NETWORK } from './massa';

export interface WalletState {
  isConnected: boolean;
  address: string | null;
  wallet: Wallet | null;
  provider: Provider | null;
}

const WALLET_STORAGE_KEY = 'massa_wallet_state';

interface StoredWalletState {
  address: string;
  walletName: string;
}

class WalletManager {
  private state: WalletState = {
    isConnected: false,
    address: null,
    wallet: null,
    provider: null,
  };

  private listeners: Array<(state: WalletState) => void> = [];

  /**
   * Load wallet state from localStorage
   */
  private loadStoredState(): StoredWalletState | null {
    try {
      const stored = localStorage.getItem(WALLET_STORAGE_KEY);
      if (stored) {
        return JSON.parse(stored) as StoredWalletState;
      }
    } catch (error) {
      console.error('Failed to load wallet state from localStorage:', error);
    }
    return null;
  }

  /**
   * Save wallet state to localStorage
   */
  private saveStoredState(address: string, walletName: string): void {
    try {
      const state: StoredWalletState = { address, walletName };
      localStorage.setItem(WALLET_STORAGE_KEY, JSON.stringify(state));
    } catch (error) {
      console.error('Failed to save wallet state to localStorage:', error);
    }
  }

  /**
   * Clear stored wallet state
   */
  private clearStoredState(): void {
    try {
      localStorage.removeItem(WALLET_STORAGE_KEY);
    } catch (error) {
      console.error('Failed to clear wallet state from localStorage:', error);
    }
  }

  /**
   * Connect to Massa wallet (Massa Station or Bearby)
   */
  async connect(): Promise<WalletState> {
    try {
      // Get available wallets (Massa Station, Bearby, etc.)
      const wallets = await getWallets();

      if (wallets.length === 0) {
        throw new Error(
          'No Massa wallet found. Please install Massa Station (station.massa.net) or Bearby Wallet (bearby.io)'
        );
      }

      // Use first available wallet
      const wallet = wallets[0];
      const walletName = wallet.name();
      console.log(`Connecting to ${walletName}...`);

      // Get accounts (providers) from wallet
      const providers = await wallet.accounts();

      if (providers.length === 0) {
        throw new Error(
          `No accounts found in ${walletName}. Please create or import an account first.`
        );
      }

      // Get first provider and its address
      const provider = providers[0];
      const accountAddress = provider.address;

      // Get network from wallet
      const network = await wallet.networkInfos();
      console.log(`Connected to network: ${network.name} (Chain ID: ${network.chainId})`);
      
      // Verify we're on the correct network
      if (network.chainId !== CURRENT_NETWORK.chainId) {
        console.warn(
          `Warning: Wallet is on chain ${network.chainId}, expected ${CURRENT_NETWORK.chainId}. Please switch to ${CURRENT_NETWORK.name} in your wallet.`
        );
      }

      this.state = {
        isConnected: true,
        address: accountAddress,
        wallet,
        provider,
      };

      // Save to localStorage for persistence
      this.saveStoredState(accountAddress, walletName);

      console.log(`✅ Connected to ${walletName} with address: ${this.state.address}`);
      this.notifyListeners();
      return this.state;
    } catch (error: any) {
      console.error('Failed to connect wallet:', error);
      
      // Provide helpful error messages
      if (error.message?.includes('User rejected')) {
        throw new Error('Connection rejected. Please approve the connection in your wallet.');
      }
      
      throw error;
    }
  }

  /**
   * Disconnect wallet
   */
  disconnect(): void {
    this.state = {
      isConnected: false,
      address: null,
      wallet: null,
      provider: null,
    };
    this.clearStoredState();
    this.notifyListeners();
  }

  /**
   * Auto-reconnect to wallet if previously connected
   */
  async autoReconnect(): Promise<boolean> {
    const stored = this.loadStoredState();
    if (!stored || !stored.address) {
      return false;
    }

    try {
      // Try to reconnect using stored address
      await this.connect();
      return true;
    } catch (error) {
      console.warn('Auto-reconnect failed:', error);
      // Clear stored state if reconnect fails
      this.clearStoredState();
      return false;
    }
  }

  /**
   * Get current wallet state
   */
  getState(): WalletState {
    return { ...this.state };
  }

  /**
   * Subscribe to wallet state changes
   */
  subscribe(listener: (state: WalletState) => void): () => void {
    this.listeners.push(listener);
    
    // Return unsubscribe function
    return () => {
      this.listeners = this.listeners.filter((l) => l !== listener);
    };
  }

  /**
   * Get connected wallet
   */
  getWallet(): Wallet | null {
    return this.state.wallet;
  }

  /**
   * Get connected provider
   */
  getProvider(): Provider | null {
    return this.state.provider;
  }

  /**
   * Get connected address
   */
  getAddress(): string | null {
    return this.state.address;
  }

  /**
   * Sign and send operation
   */
  async sendOperation(
    contractAddress: string,
    functionName: string,
    parameters: Uint8Array,
    coins?: bigint,
  ): Promise<string> {
    if (!this.state.provider) {
      throw new Error('Wallet not connected');
    }

    // Validate parameters
    if (!contractAddress || !contractAddress.trim()) {
      throw new Error('Contract address is required');
    }

    if (!functionName || !functionName.trim()) {
      throw new Error('Function name is required');
    }

    if (!parameters) {
      throw new Error('Parameters are required');
    }

    // Ensure parameters is a valid Uint8Array (even if empty)
    const validParameters = parameters instanceof Uint8Array ? parameters : new Uint8Array(0);

    try {
      const coinsAmount = coins || BigInt(0);
      console.log('Sending operation:', {
        target: contractAddress,
        func: functionName,
        coins: coinsAmount.toString(),
        coinsMAS: Number(coinsAmount) / 1e9,
        parametersLength: validParameters.length,
        parametersIsArray: validParameters instanceof Uint8Array,
      });
      
      // Call smart contract function through provider
      // IMPORTANT: The coins parameter will deduct MAS from user's wallet
      // Bearby wallet will show the amount in the popup and deduct it when approved
      const operation = await this.state.provider.callSC({
        target: contractAddress.trim(),
        func: functionName.trim(),
        parameter: validParameters,
        coins: coinsAmount, // This amount will be deducted from wallet when transaction is approved
        maxGas: BigInt(1000000),
      });

      console.log('Operation sent successfully:', {
        id: operation.id,
        coins: coinsAmount.toString(),
        coinsMAS: Number(coinsAmount) / 1e9,
      });
      return operation.id;
    } catch (error) {
      console.error('Failed to send operation:', error);
      throw error;
    }
  }

  /**
   * Send MAS coins directly to an address (simple transfer/Payment)
   * Uses callSC with target address and coins parameter to create a Payment transaction
   */
  async sendCoins(toAddress: string, amountNano: bigint): Promise<string> {
    if (!this.state.provider) {
      throw new Error('Wallet not connected');
    }

    if (!toAddress || !toAddress.trim()) {
      throw new Error('Recipient address is required');
    }

    if (!amountNano || amountNano <= 0) {
      throw new Error('Amount must be greater than 0');
    }

    try {
      console.log('Sending coins (Payment):', { 
        toAddress, 
        amountNano: amountNano.toString(),
        amountMAS: Number(amountNano) / 1e9 
      });
      
      // Use callSC to send coins directly to address (Payment method)
      // In Massa, sending coins to an address without a function call creates a Payment transaction
      // We use an empty parameter array to indicate direct transfer
      const operation = await this.state.provider.callSC({
        target: toAddress, // Send directly to this address
        func: '', // Empty function name = Payment transaction
        parameter: new Uint8Array(0), // Empty parameters
        coins: amountNano, // Amount to send
        maxGas: BigInt(1000000),
      });
      
      console.log('Payment transaction sent:', {
        id: operation.id,
        amount: amountNano.toString(),
        amountMAS: Number(amountNano) / 1e9,
        to: toAddress,
      });
      
      return operation.id;
    } catch (error: any) {
      console.error('Failed to send coins:', error);
      throw new Error(`Failed to send payment: ${error.message || error}`);
    }
  }

  /**
   * Read contract data (view function)
   */
  async readContract(
    contractAddress: string,
    functionName: string,
    parameters: Uint8Array,
  ): Promise<Uint8Array> {
    if (!this.state.provider) {
      throw new Error('Wallet not connected');
    }

    try {
      // Read from smart contract
      const result = await this.state.provider.readSC({
        target: contractAddress,
        func: functionName,
        parameter: parameters,
      });

      console.log('readSC result:', result);
      console.log('readSC result.value:', result.value);
      console.log('readSC result.info:', result.info);
      console.log('readSC result.value type:', typeof result.value);
      console.log('readSC result.value length:', result.value?.length);
      console.log('readSC target:', contractAddress);
      console.log('readSC func:', functionName);

      // Check if there's an error in result.info
      if (result.info && result.info.error) {
        console.error('readSC error in result.info:', result.info.error);
        throw new Error(result.info.error);
      }

      return result.value;
    } catch (error) {
      console.error('Failed to read contract:', error);
      throw error;
    }
  }

  private notifyListeners(): void {
    this.listeners.forEach((listener) => listener(this.state));
  }
}

// Export singleton instance
export const walletManager = new WalletManager();

// React hook for wallet state
export function useWallet() {
  const [state, setState] = useState<WalletState>(walletManager.getState());
  const [isReconnecting, setIsReconnecting] = useState(true);

  useEffect(() => {
    const unsubscribe = walletManager.subscribe(setState);
    
    // Try to auto-reconnect on mount
    walletManager.autoReconnect().catch((error) => {
      console.warn('Auto-reconnect failed (this is normal if wallet is not connected):', error);
    }).finally(() => {
      setIsReconnecting(false);
    });

    return unsubscribe;
  }, []);

  return {
    ...state,
    isReconnecting,
    connect: () => walletManager.connect(),
    disconnect: () => walletManager.disconnect(),
  };
}
