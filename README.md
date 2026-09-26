CrystalFlakCoin — Project Bundle
Verified, documented, ready to publish. Free to deploy, free to monetize, free to launch the token.
Quick links
`crystalflakcoin-web/` — Next.js 14 production application (full website + admin)
`crystalflakcoin-static/` — Interactive marketing site (live URL)
`newsletter.md` — Editorial article
`launch-announcement.md` — Press release / launch blog post
`crystalflakcoin-mirror.md` — Web3-native (Mirror.xyz) version
What's in this bundle
Smart contract (free to launch)
`crystalflakcoin-web/contracts/CrystalFlakCoin.sol` — ERC-20, fixed 1B supply, no mint, no fees
`crystalflakcoin-web/contracts/interfaces/ICrystalFlakCoin.sol`
`crystalflakcoin-web/test/CrystalFlakCoin.test.ts` — 15 Solidity tests
`crystalflakcoin-web/scripts/token/preflight.ts` — compile + generate calldata (no funds needed)
`crystalflakcoin-web/scripts/token/launch.ts` — one-shot deploy + verify + renounce
`crystalflakcoin-web/scripts/token/deploy.ts` — deploy
`crystalflakcoin-web/scripts/token/verify.ts` — verify on Sourcify + Etherscan
`crystalflakcoin-web/scripts/token/renounce.ts` — make immutable
`crystalflakcoin-web/scripts/token/read.ts` — read live state
`crystalflakcoin-web/hardhat.config.ts` — Hardhat config for 9 networks
Documentation (15 files)
`README.md` (this file)
`crystalflakcoin-web/README.md`
`crystalflakcoin-web/DEPLOYMENT.md`
`crystalflakcoin-web/DEPLOY_FREE.md` — Free website deployment
`crystalflakcoin-web/DEPLOY_TOKEN_FREE.md` — Free token deployment
`crystalflakcoin-web/FREE_HOSTS.md`
`crystalflakcoin-web/SECURITY.md`
`crystalflakcoin-web/ADMIN_GUIDE.md`
`crystalflakcoin-web/LAUNCH.md` — End-to-end launch runbook
`crystalflakcoin-web/LAUNCH_PLAYBOOK.md` — Marketing playbook
`crystalflakcoin-web/MONETIZATION.md` — Honest monetization policy
`crystalflakcoin-web/BRAND_GUIDELINES.md`
`crystalflakcoin-web/ANALYTICS.md`
`crystalflakcoin-web/CHANGELOG.md`
`crystalflakcoin-web/CONTRIBUTING.md`
Press kit + branding
`crystalflakcoin-web/public/press/` — 5 SVG logo variants
`crystalflakcoin-web/src/app/press/` — /press page
`crystalflakcoin-web/src/lib/brand-tokens.ts` — color/typography tokens
`crystalflakcoin-web/src/lib/boilerplate.ts` — short/medium/long press copy
`crystalflakcoin-web/src/app/api/og/` — OG image generator
Free-host configs
`crystalflakcoin-web/vercel.json`
`crystalflakcoin-web/netlify.toml`
`crystalflakcoin-web/wrangler.toml`
CI / GitHub
`crystalflakcoin-web/.github/workflows/`
`crystalflakcoin-web/.github/FUNDING.yml`
`crystalflakcoin-web/public/.well-known/security.txt`
Admin panel (role-gated, audited)
9 admin pages including `/admin/launch` (guided launch wizard), `/admin/analytics`, `/admin/daily-prize`, etc.
Iron-session + Argon2id + CSRF + rate limiting + audit log
Quick start (5 minutes)
```bash
# 1. Website
cd crystalflakcoin-web
npm install --legacy-peer-deps
npm run dev          # or follow DEPLOY_FREE.md to deploy free

# 2. Token (after website is set up)
npm run token:preflight          # validate + generate calldata
npm run hardhat:launch:sepolia   # deploy + verify + renounce (free on testnet)
echo "NEXT_PUBLIC_TOKEN_CONTRACT_ADDRESS=0x..." >> .env
echo "NEXT_PUBLIC_TOKEN_NETWORK=sepolia" >> .env
```
Verification status
Brand scanner: 0 forbidden terms in 138 files
Jest: 31/31 tests pass
Solidity compile: ✅ clean (6,246 bytes)
TypeScript: clean
Next.js build: 38 routes compiled
Static deployment: live
Risk disclosure
This is a digital asset project, not an investment vehicle. Donations are
voluntary and non-refundable. Tokens are not yet deployed (deployment is
free and reversible up until ownership is renounced). Nothing on this site
is financial, investment, legal, or tax advice.
