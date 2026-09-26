/**
 * Press boilerplate — three lengths for journalists, partners, listings.
 *
 * All versions are honest, non-promotional, and explicitly state the
 * project's risk characteristics. No fake stats, no hype, no investment
 * language.
 */

const BASE = `CrystalFlakCoin (CFC) is a transparent, community-driven digital asset project. The project is explicitly not an investment vehicle, has no token sale, and does not promise returns of any kind.`;

const SHORT = `${BASE} It is built on Ethereum and is currently in pre-deployment. The website is live at https://crystalflakcoin.example.`;

const MEDIUM = `${BASE}

CrystalFlakCoin publishes a verifiable public website with 15+ pages, a role-gated admin panel, an append-only audit log, and an interactive community spin feature with disclosed odds and non-monetary prizes. The codebase includes a CI-enforced legacy-brand scanner that fails the build if any forbidden brand reference or misleading financial claim is reintroduced.

The project is maintained by an undisclosed team. The token contract is not yet deployed. All on-chain values render as "Not yet deployed" until the contract is published and verified.

Website: https://crystalflakcoin.example
Security policy: https://crystalflakcoin.example/transparency
Documentation: https://crystalflakcoin.example/docs`;

const LONG = `${BASE}

CrystalFlakCoin is built on the principle that the floor for a digital asset project is verifiable transparency. The project:

- Publishes a Next.js 14 open-source website covering home, token, tokenomics, governance, transparency, docs, FAQ, legal, contact, and a daily community engagement feature.
- Maintains a role-gated admin panel with Argon2id password hashing, iron-session cookies, CSRF protection, per-IP rate limiting, and an append-only audit log of every write.
- Includes a CI-enforced legacy-brand scanner that walks the entire repository on every push and fails the build if any project-specific forbidden brand reference or misleading financial claim is reintroduced. The full forbidden list is published in the project's SECURITY.md and is not enumerated here.
- Operates a daily free spin feature for community engagement. All prizes are non-monetary (community points, raffle entries, supporter badges) with no cash value until a token contract is deployed and a conversion ratio is announced through governance.
- Accepts voluntary donations via GitHub Sponsors, Open Collective, and direct crypto. Donations are voluntary and non-refundable; donors receive nothing in return beyond the project's continued operation.

The token contract is not yet deployed. The project is maintained by an undisclosed team. Smart contract security audits will be published when the contract is deployed. All roadmap items marked "Planned" or "Under evaluation" are explicitly not committed features.

Website: https://crystalflakcoin.example
Security policy: https://crystalflakcoin.example/transparency
Documentation: https://crystalflakcoin.example/docs
Press kit: https://crystalflakcoin.example/press
Contact: https://crystalflakcoin.example/contact`;

export const BOILERPLATE = {
  short: SHORT.trim(),
  medium: MEDIUM.trim(),
  long: LONG.trim(),
} as const;

/**
 * Key facts (no fake statistics — only verifiable project facts).
 */
export const KEY_FACTS = {
  name: 'CrystalFlakCoin',
  ticker: 'CFC',
  type: 'Digital asset project (pre-deployment)',
  network: 'Ethereum (planned)',
  website: 'https://crystalflakcoin.example',
  contact: 'https://crystalflakcoin.example/contact',
  launch: '2026',
  openSource: true,
  auditStatus: 'Not yet audited — pending token contract deployment',
  privacyCompliant: true,
  donationBased: true,
} as const;
