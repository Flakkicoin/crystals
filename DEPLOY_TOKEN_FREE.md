# Deploy CrystalFlakCoin (CFC) for free

This guide shows you how to deploy the CrystalFlakCoin smart contract to a public chain **without spending money on deployment fees** (or for <$1 if you want a mainnet L2).

## TL;DR

| Network | Cost to deploy | Where to get native ETH |
|---------|----------------|--------------------------|
| **Ethereum Sepolia** | **Free** | [sepoliafaucet.com](https://sepoliafaucet.com), [Google Cloud faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia), [Alchemy faucet](https://www.alchemy.com/faucets/ethereum-sepolia) |
| **Base Sepolia** | **Free** | [Alchemy faucet](https://www.alchemy.com/faucets/base-sepolia) |
| **Optimism Sepolia** | **Free** | [Alchemy faucet](https://www.alchemy.com/faucets/optimism-sepolia) |
| **Arbitrum Sepolia** | **Free** | [Alchemy faucet](https://www.alchemy.com/faucets/arbitrum-sepolia) |
| **Base** (mainnet) | ~$0.05 | Bridge ETH from L1 or buy on Coinbase |
| **Optimism** (mainnet) | ~$0.05 | Bridge ETH from L1 or buy on Coinbase |
| **Arbitrum** (mainnet) | ~$0.05 | Bridge ETH from L1 or buy on Coinbase |
| **Polygon** (mainnet) | ~$0.50 | Bridge or buy MATIC |
| **Ethereum mainnet** | ~$30–80 | Buy ETH |

**For zero cost**: Deploy to a **testnet** first (Sepolia, Base Sepolia, etc.). The contract is identical, the source is verifiable on Sourcify, and the project is ready for a mainnet promotion later.

**For "real" deployment on a cheap L2**: Base, Optimism, or Arbitrum mainnet. Costs about $0.05.

---

## Step 1 — Prerequisites

- Node.js ≥ 18.18
- A wallet private key for the deployer (testnet ETH or mainnet ETH)
- (Optional) An Etherscan API key from https://etherscan.io/apis (free)

## Step 2 — Install dependencies

The smart contract toolchain adds a few devDependencies:

```bash
npm install --save-dev \
  hardhat @nomicfoundation/hardhat-toolbox \
  @openzeppelin/contracts \
  dotenv
```

`@nomicfoundation/hardhat-toolbox` pulls in `ethers v6`, `chai`, `mocha`, `hardhat-network-helpers`, and the Etherscan / Sourcify plugins.

## Step 3 — Configure env vars

Add to `.env`:

```bash
# Required for deployment
DEPLOYER_PRIVATE_KEY=0xYOUR_PRIVATE_KEY_HERE        # never commit this
CFC_INITIAL_HOLDER=0xADDRESS_THAT_GETS_THE_1B_SUPPLY
CFC_INITIAL_OWNER=0xADDRESS_THAT_OWNS_THE_CONTRACT

# Optional RPC URLs (defaults are public)
SEPOLIA_RPC_URL=https://rpc.sepolia.org
BASE_SEPOLIA_RPC_URL=https://sepolia.base.org
OP_SEPOLIA_RPC_URL=https://sepolia.optimism.io
ARB_SEPOLIA_RPC_URL=https://sepolia-rollup.arbitrum.io/rpc

# Optional mainnet RPC URLs (when you promote)
BASE_RPC_URL=https://mainnet.base.org
OP_RPC_URL=https://mainnet.optimism.io
ARB_RPC_URL=https://arb1.arbitrum.io/rpc

# Optional for Etherscan verification (Sourcify doesn't need one)
ETHERSCAN_API_KEY=
```

> **Never commit `DEPLOYER_PRIVATE_KEY`.** The `.gitignore` already excludes `.env` and `.env.local`.

## Step 4 — Compile and test

```bash
npx hardhat compile
npx hardhat test
```

Expected output: 4 test suites passing, ~15 tests, all green.

## Step 5 — Deploy to a free testnet

### Sepolia (Ethereum testnet)

1. Get testnet ETH from any of these faucets (free, take 1–5 minutes):
   - https://sepoliafaucet.com (requires Alchemy account)
   - https://cloud.google.com/application/web3/faucet/ethereum/sepolia (Google account)
   - https://www.alchemy.com/faucets/ethereum-sepolia (Alchemy account)
2. Deploy:

   ```bash
   npx hardhat run scripts/token/deploy.ts --network sepolia
   ```

3. The script prints the deployed address and a block explorer link. Save the address.

### Base Sepolia

1. Get testnet ETH from https://www.alchemy.com/faucets/base-sepolia (Alchemy account)
2. Deploy:

   ```bash
   npx hardhat run scripts/token/deploy.ts --network baseSepolia
   ```

### Optimism Sepolia

1. Get testnet ETH from https://www.alchemy.com/faucets/optimism-sepolia
2. Deploy:

   ```bash
   npx hardhat run scripts/token/deploy.ts --network opSepolia
   ```

### Arbitrum Sepolia

1. Get testnet ETH from https://www.alchemy.com/faucets/arbitrum-sepolia
2. Deploy:

   ```bash
   npx hardhat run scripts/token/deploy.ts --network arbSepolia
   ```

## Step 6 — Verify the source (free)

### Sourcify (recommended, no API key needed)

Sourcify is configured automatically. After deployment, verify:

```bash
npx hardhat run scripts/token/verify.ts --network sepolia
```

Or visit https://sourcify.dev and paste your deployed address + source.

### Etherscan (requires API key, free)

If you set `ETHERSCAN_API_KEY`, Etherscan verification runs as part of the same script. Alternatively:

```bash
npx hardhat verify --network sepolia \
  <DEPLOYED_ADDRESS> \
  <INITIAL_HOLDER> \
  <INITIAL_OWNER>
```

## Step 7 — Renounce ownership (recommended)

After the contract is verified and your distribution plan is in motion, **renounce ownership** to make the contract fully immutable. No admin function can ever be performed after this call.

```bash
# Make sure CFC_DEPLOYED_ADDRESS is set in your .env
CFC_DEPLOYED_ADDRESS=0x... npx hardhat run scripts/token/renounce.ts --network sepolia
```

You can verify the renounce succeeded:

```bash
CFC_DEPLOYED_ADDRESS=0x... npx hardhat run scripts/token/read.ts --network sepolia
```

The script will print `Owner: (renounced — immutable)`.

## Step 8 — Tell the frontend

Once deployed, set the address in your Next.js `.env`:

```bash
NEXT_PUBLIC_TOKEN_CONTRACT_ADDRESS=0xYOUR_DEPLOYED_ADDRESS
NEXT_PUBLIC_TOKEN_NETWORK=sepolia        # or 'base', 'optimism', etc.
```

The `/token` page will automatically read from the deployed contract (see `src/lib/token/contract.ts`).

## Cost summary

| Stage | Cost |
|-------|------|
| Compile + tests | Free (CPU only) |
| Deploy to Sepolia | Free (faucet ETH) |
| Verify on Sourcify | Free (no API key) |
| Verify on Etherscan | Free (API key) |
| Renounce ownership | Free (gas only, ~$0.01) |
| Read state | Free (RPC call, no signing) |
| **Total** | **$0.00 on a testnet** |

If you want to go to mainnet:

| Mainnet | Approx deploy cost |
|---------|--------------------|
| Base | $0.05 |
| Optimism | $0.05 |
| Arbitrum | $0.05 |
| Polygon | $0.50 |
| Ethereum | $30–80 |

## Promoting from testnet to mainnet

When you're ready:

1. Repeat Steps 5–7 on the mainnet network of your choice (e.g. `--network base`).
2. Update `NEXT_PUBLIC_TOKEN_CONTRACT_ADDRESS` to the new address.
3. Update `NEXT_PUBLIC_TOKEN_NETWORK` to `'base'` (or whatever you deployed to).
4. Announce the deployment through your project's normal communication channels — do not market it as a launch event without a published conversion policy.

## Security notes

- The contract uses OpenZeppelin v5 (audited, widely deployed).
- The contract is fixed supply, no mint, no fees, no pausing.
- Ownership should be renounced before any meaningful distribution.
- A formal third-party audit is recommended before mainnet deployment if user funds will be at risk.
- The deployer key should be a fresh key used only for deployment, then discarded.

## Related files

- `contracts/CrystalFlakCoin.sol` — the contract
- `contracts/interfaces/ICrystalFlakCoin.sol` — external interface
- `hardhat.config.ts` — Hardhat configuration
- `scripts/token/deploy.ts` — deployment script
- `scripts/token/verify.ts` — verification (Etherscan + Sourcify)
- `scripts/token/renounce.ts` — ownership renouncement
- `scripts/token/read.ts` — read state from deployed contract
- `test/CrystalFlakCoin.test.ts` — test suite
- `src/lib/token/contract.ts` — frontend integration (reads from the contract)
