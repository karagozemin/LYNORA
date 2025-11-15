/**
 * Massa Network Configuration
 * Configures connection to Massa BuildNet
 */

// Massa BuildNet Configuration
export const MASSA_BUILDNET_CONFIG = {
  name: 'Massa BuildNet',
  chainId: 77658366n, // BuildNet Chain ID
  rpcUrl: 'https://buildnet.massa.net/api/v2',
  explorerUrl: 'https://buildnet-explorer.massa.net',
  faucetUrl: 'https://discord.gg/massa', // Discord #buildernet-faucet channel
};

// Massa MainNet Configuration (for future use)
export const MASSA_MAINNET_CONFIG = {
  name: 'Massa MainNet',
  chainId: 77658377n, // MainNet Chain ID
  rpcUrl: 'https://mainnet.massa.net/api/v2',
  explorerUrl: 'https://explorer.massa.net',
};

// Current network (use BuildNet for hackathon)
export const CURRENT_NETWORK = MASSA_BUILDNET_CONFIG;

/**
 * Get Massa Explorer URL for address
 */
export function getExplorerAddressUrl(address: string): string {
  return `${CURRENT_NETWORK.explorerUrl}/address/${address}`;
}

/**
 * Get Massa Explorer URL for operation
 */
export function getExplorerOperationUrl(operationId: string): string {
  return `${CURRENT_NETWORK.explorerUrl}/operation/${operationId}`;
}

/**
 * Format Massa amount (convert from smallest unit to MAS)
 */
export function formatMassaAmount(amount: bigint | string): string {
  const amountBigInt = typeof amount === 'string' ? BigInt(amount) : amount;
  const divisor = BigInt(10 ** 9); // Massa uses 9 decimals
  const wholePart = amountBigInt / divisor;
  const fractionalPart = amountBigInt % divisor;
  
  if (fractionalPart === BigInt(0)) {
    return wholePart.toString();
  }
  
  const fractionalStr = fractionalPart.toString().padStart(9, '0').replace(/0+$/, '');
  return `${wholePart}.${fractionalStr}`;
}

/**
 * Parse Massa amount (convert from MAS to smallest unit)
 */
export function parseMassaAmount(amount: string): bigint {
  const parts = amount.split('.');
  const wholePart = BigInt(parts[0] || '0');
  const fractionalPart = parts[1] || '0';
  const paddedFractional = fractionalPart.padEnd(9, '0').slice(0, 9);
  
  const multiplier = BigInt(10 ** 9);
  return wholePart * multiplier + BigInt(paddedFractional);
}

/**
 * Short address format (0x1234...5678)
 */
export function shortAddress(address: string): string {
  if (address.length < 10) return address;
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
}
