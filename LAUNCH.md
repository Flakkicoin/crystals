# Launch CrystalFlakCoin — Runbook

This is the end-to-end runbook for deploying the CrystalFlakCoin (CFC) smart contract to a public chain and announcing the launch.

> **Honest note**: The project never custodies your private keys. The actual deployment transaction must be signed by your wallet — either locally, in CI, or via a multisig. Everything else (compile, verify, frontend integration, announcement) can be automated.

## Pre-flight checklist

- [ ] GitHub repository created
- [ ] Wallet selected for the deployer (use a fresh key for the deployment tx, then discard)
- [ ] `CFC_INITIAL_HOLDER` decided (the address that receives the 1B initial supply)
- [ ] `CFC_INITIAL_OWNER` decided (the address that owns the contract initially; usually the deployer)
- [ ] Native ETH in the deployer wallet (free on testnets, ~$0.05 on a mainnet L2)
- [ ] (Optional) Etherscan API key from https://etherscan.io/apis

## Five steps to launch

### Step 1 — Set env vars

Add to `crystalflakcoin-web/.env`:

```bash
DEPLOYER_PRIVATE_KEY=0xYOUR_DEPLOYER_KEY_HERE        # never commit
CFC_INITIAL_HOLDER=0xADDRESS_THAT_GETS_THE_1B_SUPPLY
CFC_INITIAL_OWNER=0xADDRESS_THAT_OWNS_THE_CONTRACT

# Optional — for Etherscan verification (Sourcify doesn't need one)
ETHERSCAN_API_KEY=YOUR_KEY

# Optional RPC URLs (defaults are public endpoints)
SEPOLIA_RPC_URL=https://rpc.sepolia.org
BASE_SEPOLIA_RPC_URL=https://sepolia.base.org
OP_SEPOLIA_RPC_URL=https://sepolia.optimism.io
```

> **Important**: `DEPLOYER_PRIVATE_KEY` must NEVER be committed. The `.gitignore` already excludes `.env`. If you accidentally commit a private key, treat it as compromised and rotate immediately.

### Step 2 — Pre-flight (no funds needed)

Run the pre-flight check to compile the contract and generate the deployment calldata:

```bash
npm run token:preflight
```

This prints:
- The constructor argument validation
- The compiled bytecode size (should be ~6,246 bytes)
- The full deployment calldata (paste-ready for Remix, Etherscan deploy tool, or any signer)
- A JSON artifact saved to `deployments/preflight-payload.json`

If anything fails here, fix it before moving on. Don't waste testnet ETH on a broken deployment.

### Step 3 — Fund the deployer wallet

#### Testnet (free)

Pick any public faucet:

- **Ethereum Sepolia**: https://sepoliafaucet.com, https://cloud.google.com/application/web3/faucet/ethereum/sepolia, https://www.alchemy.com/faucets/ethereum-sepolia
- **Base Sepolia**: https://www.alchemy.com/faucets/base-sepolia
- **Optimism Sepolia**: https://www.alchemy.com/faucets/optimism-sepolia
- **Arbitrum Sepolia**: https://www.alchemy.com/faucets/arbitrum-sepolia

Most faucets require a free account (Google, Alchemy, etc.) and give you 0.5 ETH per request. The deployment costs ~0.0015 ETH in gas, so one faucet request is plenty.

#### Mainnet L2 (~$0.05)

Bridge or buy ETH:

- **Base**: https://bridge.base.org
- **Optimism**: https://app.optimism.io/bridge
- **Arbitrum**: https://bridge.arbitrum.io
- Or buy ETH on Coinbase and send to the deployer wallet

### Step 4 — Deploy, verify, renounce (one command)

```bash
# Pick your network
npm run hardhat:launch:sepolia          # free, recommended for first deploy
npm run hardhat:launch:baseSepolia      # free, L2
npm run hardhat:launch:base             # ~$0.05, real mainnet
npm run hardhat:launch:optimism         # ~$0.05
npm run hardhat:launch:arbitrum         # ~$0.05
```

This script:
1. Deploys the contract
2. Verifies on Sourcify (free, no API key)
3. Verifies on Etherscan (free with API key)
4. Renounces ownership (if the deployer is the initial owner)
5. Writes a JSON artifact to `deployments/<network>.json`

After the script finishes, you'll see:

```
===========================================
✅ CrystalFlakCoin launched
===========================================
Address:  0x...
Network:  sepolia (chainId 11155111)
Explorer: https://sepolia.etherscan.io/address/0x...
```

The address is also written to `deployments/sepolia.json` with full provenance (deployer, tx hash, block number, gas used).

### Step 5 — Wire the frontend

```bash
# Add the deployed address to .env
echo "NEXT_PUBLIC_TOKEN_CONTRACT_ADDRESS=0x..." >> .env
echo "NEXT_PUBLIC_TOKEN_NETWORK=sepolia" >> .env

# Redeploy the website (free on Vercel / Netlify / Cloudflare Pages — see DEPLOY_FREE.md)
```

After redeploying, the `/token` page will show live contract data instead of placeholders.

## Verification

After deployment, verify on a block explorer (Sourcify is automatic; Etherscan if `ETHERSCAN_API_KEY` is set).

You can also verify manually:
- Sourcify: https://sourcify.dev (paste the address)
- Etherscan: https://sepolia.etherscan.io/address/<addr>#code

## Renounce ownership (if not done by the launch script)

If the deployer is not the initial owner, or if you skipped renouncement, run:

```bash
CFC_DEPLOYED_ADDRESS=0x... npm run hardhat:renounce -- --network sepolia
```

After this call, no admin function can be performed. The contract is immutable.

## Distribution plan

The initial 1B supply sits in `CFC_INITIAL_HOLDER`. Distribute as planned:

| Approach | Pros | Cons |
|---|---|---|
| **Multisig** (e.g. Gnosis Safe) | Transparent, recoverable | Requires multisig setup |
| **Streaming** via Sablier | Time-locked distribution | Requires contract integration |
| **Airdrop** (one-time, opt-in) | Wide distribution | Gas costs for many recipients |
| **Liquidity pools** (Uniswap, etc.) | Tradeable from day one | Subject to impermanent loss for LP providers |

The project does NOT endorse or arrange any of these automatically. Distribution is the maintainer's responsibility and must be communicated through official channels.

## Announcement

Use `launch-announcement.md` as the basis for your announcement. Suggested channels:

1. **Your own blog / changelog** — publish `launch-announcement.md`
2. **Mirror.xyz** — re-publish `crystalflakcoin-mirror.md` for the Web3-native audience
3. **Hacker News** — Show HN template in `LAUNCH_PLAYBOOK.md`
4. **Twitter / X** — thread template in `LAUNCH_PLAYBOOK.md`
5. **Reddit** — r/ethereum, r/ethdev, r/cryptocurrency, r/defi
6. **Farcaster** — relevant channels
7. **Product Hunt** — copy templates in `LAUNCH_PLAYBOOK.md`

**Do NOT**:
- Promise returns of any kind
- Use "guaranteed profit", "risk-free", or similar language
- Market the contract address to "moonshot" communities
- Claim any feature not actually deployed

## Post-launch (T+1 to T+30)

- **Daily**: respond to comments, questions, feedback
- **Weekly**: post a "what we shipped" update
- **Monthly**: publish a transparency report
- **Quarterly**: review the on-chain state, verify nothing unexpected has happened

## Troubleshooting

### "Insufficient funds" during deployment

You didn't get enough faucet ETH, or you're on the wrong network. Verify the deployer address on a block explorer and check the balance.

### "Already known" during verification

The contract is already verified on that explorer. That's fine — the script detects this and reports success.

### Sourcify verification fails but Etherscan succeeds

Sourcify's matching is strict. If the contract is verified on Etherscan, that's sufficient for transparency. Sourcify verification can be retried manually at https://sourcify.dev.

### Renounce fails with "Ownable: caller is not the owner"

The deployer is not the initial owner. The initial owner must call `renounce()` themselves. This is intentional — only the configured owner can lock the contract.

## Files reference

- `contracts/CrystalFlakCoin.sol` — the contract source
- `scripts/token/preflight.ts` — pre-flight (no funds needed)
- `scripts/token/launch.ts` — one-shot deploy + verify + renounce
- `scripts/token/verify.ts` — manual verification
- `scripts/token/renounce.ts` — manual renouncement
- `scripts/token/read.ts` — read live state
- `deployments/<network>.json` — deployment artifacts
- `DEPLOY_TOKEN_FREE.md` — detailed deployment options and cost comparison
- `SECURITY.md` — security policy and threat model
- `launch-announcement.md` — announcement template

## Related

- [DEPLOY_FREE.md](DEPLOY_FREE.md) — free hosting for the website
- [DEPLOY_TOKEN_FREE.md](DEPLOY_TOKEN_FREE.md) — detailed token deployment options
- [LAUNCH_PLAYBOOK.md](LAUNCH_PLAYBOOK.md) — marketing playbook
- [SECURITY.md](SECURITY.md) — security policy
