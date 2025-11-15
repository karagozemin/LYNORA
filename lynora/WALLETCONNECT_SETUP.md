# WalletConnect Setup Guide

LYNORA now uses RainbowKit + WalletConnect for wallet connections!

## Getting Your WalletConnect Project ID

1. Go to [WalletConnect Cloud](https://cloud.walletconnect.com)
2. Sign up or log in
3. Create a new project
4. Copy your Project ID

## Setup Steps

### 1. Add Project ID to Environment

Create or update `frontend/.env`:

```env
VITE_WALLETCONNECT_PROJECT_ID=your_project_id_here
VITE_GRAPHQL_HTTP_URL=http://localhost:8080/graphql
VITE_GRAPHQL_WS_URL=ws://localhost:8080/graphql
VITE_CONTRACT_ADDRESS=your_contract_address
VITE_CHAIN_ID=your_chain_id
```

### 2. Install Dependencies (Already Done)

```bash
cd frontend
npm install
```

### 3. Start Development Server

```bash
npm run dev
```

## What Changed?

### Replaced Dynamic Labs with RainbowKit

**Before:**
- Dynamic Labs SDK
- Single provider setup

**After:**
- RainbowKit + Wagmi + Viem
- Modern, customizable wallet UI
- Support for 100+ wallets
- Better mobile support

### Supported Wallets

RainbowKit automatically supports:
- MetaMask
- Rainbow
- Coinbase Wallet
- WalletConnect (all compatible wallets)
- Trust Wallet
- Ledger
- And 100+ more!

### Updated Components

1. **App.tsx**: Now uses WagmiProvider, QueryClientProvider, and RainbowKitProvider
2. **Header.tsx**: Uses `<ConnectButton />` from RainbowKit
3. **All Pages**: Use `useAccount()` from Wagmi instead of Dynamic Labs hooks

### Hook Changes

**Before (Dynamic Labs):**
```tsx
import { useDynamicContext } from '@dynamic-labs/sdk-react-core'
const { primaryWallet } = useDynamicContext()
```

**After (Wagmi):**
```tsx
import { useAccount } from 'wagmi'
const { address, isConnected } = useAccount()
```

## Customizing RainbowKit

### Change Theme

Edit `frontend/src/App.tsx`:

```tsx
<RainbowKitProvider theme={darkTheme()}>
  {/* ... */}
</RainbowKitProvider>
```

Options:
- `darkTheme()` - Dark mode
- `lightTheme()` - Light mode
- `midnightTheme()` - Midnight theme

### Custom Chains

Edit `frontend/src/lib/wagmi.ts` to add custom chains:

```typescript
export const lineraTestnet = {
  id: 1337,
  name: 'Linera Testnet Conway',
  nativeCurrency: {
    decimals: 18,
    name: 'Linera',
    symbol: 'LINERA',
  },
  rpcUrls: {
    default: {
      http: ['http://localhost:8080'],
    },
  },
  testnet: true,
}
```

Then add to chains array:
```typescript
chains: [mainnet, sepolia, lineraTestnet]
```

## Benefits of RainbowKit

1. **Better UX**: Beautiful, modern wallet connection UI
2. **More Wallets**: Support for 100+ wallets out of the box
3. **Mobile Friendly**: Better mobile wallet support
4. **Customizable**: Easy to theme and customize
5. **Standards Compliant**: Uses industry-standard Wagmi/Viem
6. **Well Maintained**: Active development and support

## Troubleshooting

### "Invalid Project ID" Error

Make sure you've set `VITE_WALLETCONNECT_PROJECT_ID` in your `.env` file.

### Wallet Not Connecting

1. Check your WalletConnect Project ID is valid
2. Make sure your wallet app is updated
3. Try a different wallet
4. Check browser console for errors

### RainbowKit Styles Not Loading

Make sure you have the CSS import in `App.tsx`:
```tsx
import '@rainbow-me/rainbowkit/styles.css'
```

## Resources

- [RainbowKit Docs](https://www.rainbowkit.com/docs/introduction)
- [Wagmi Docs](https://wagmi.sh)
- [WalletConnect Cloud](https://cloud.walletconnect.com)
- [Viem Docs](https://viem.sh)

## Next Steps

1. Get your WalletConnect Project ID
2. Update `.env` file
3. Test wallet connection
4. Deploy to production

---

**Note**: RainbowKit is currently configured for Ethereum-compatible chains. For Linera blockchain integration, you may need to add custom chain configuration.


