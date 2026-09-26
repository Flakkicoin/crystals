# CrystalFlakCoin — Analytics

CrystalFlakCoin uses **Plausible Analytics** — a privacy-friendly, cookie-free, GDPR/CCPA-compliant analytics tool. We do **not** use Google Analytics, Facebook Pixel, or any other tracker that requires cookie consent.

## Why Plausible (and not Google Analytics)?

| | Plausible | Google Analytics |
|---|---|---|
| Cookie banner required | No | Yes |
| Stores personal data | No | Yes |
| Cross-site tracking | No | Yes |
| GDPR/CCPA compliant out of the box | Yes | Requires additional setup |
| Free tier | < 10k pageviews/month | Free, but at privacy cost |
| Self-hostable | Yes | No |
| Open source | Yes (AGPL) | No |

For a project that explicitly does not promise returns and is built on transparency, the privacy cost of Google Analytics is incompatible with our values. Plausible gives us just enough to know what's working without surveilling our visitors.

## Setup

### Option A — Cloud (recommended for most teams)

1. Sign up at https://plausible.io (free for sites under 10k pageviews/month)
2. Add your domain (e.g. `crystalflakcoin.example`)
3. Copy your domain into `.env`:
   ```
   NEXT_PUBLIC_PLAUSIBLE_DOMAIN=crystalflakcoin.example
   ```
4. (Optional) For self-hosted Plausible:
   ```
   NEXT_PUBLIC_PLAUSIBLE_SCRIPT=https://analytics.your-domain.com/js/script.js
   ```
5. Deploy. The Plausible script is automatically injected in the root layout (`src/app/layout.tsx`) when the domain is set.

### Option B — Self-host Plausible

Plausible is open source (AGPL) and can be self-hosted on a single server with Docker. See https://plausible.io/docs/self-hosting for instructions.

```bash
git clone https://github.com/plausible/analytics.git
cd analytics
docker compose up -d
```

Then point `NEXT_PUBLIC_PLAUSIBLE_SCRIPT` at your instance URL.

### Option C — Self-host Umami (alternative)

If you prefer Umami (also privacy-friendly and self-hostable), see https://umami.is/docs/install. The Plausible component can be replaced with a small Umami script tag in `src/app/layout.tsx` — no other code changes needed.

## What we track

Standard event names are defined in `src/lib/analytics.ts` as the `EVENTS` object. Every event is a no-op when Plausible is not configured.

| Event | Where it fires |
|---|---|
| `wallet_connected` | User picks a wallet from the connect modal |
| `wallet_disconnected` | User disconnects their wallet |
| `daily_prize_page_viewed` | Loads `/daily-prize` |
| `daily_prize_spin_started` | Click "Spin" button |
| `daily_prize_spin_completed` | Server returns the spin result |
| `daily_prize_prize_won` | Prize reveal modal shown |
| `daily_prize_milestone` | Cross a streak milestone |
| `daily_prize_leaderboard_viewed` | Loads `/daily-prize/leaderboard` |
| `daily_prize_draws_viewed` | Loads `/daily-prize/draws` |
| `donation_clicked` | Click any donation method link |
| `sponsors_page_viewed` | Loads `/sponsors` |
| `docs_viewed` | Loads `/docs` |
| `transparency_viewed` | Loads `/transparency` |
| `press_page_viewed` | Loads `/press` |
| `external_link_clicked` | Click an outbound link |
| `admin_login_attempt` | Admin login form submitted |
| `admin_login_success` | Admin login succeeded |
| `admin_login_failed` | Admin login failed |
| `admin_token_metadata_updated` | Admin updated token metadata |
| `admin_raffle_draw_triggered` | Admin triggered a raffle draw |

## Standard properties

No PII is ever sent. Properties are categorical only:

- `wallet_type` — `'MetaMask' | 'WalletConnect' | 'Coinbase Wallet' | 'Rainbow'`
- `prize_code` — opaque prize identifier (e.g. `'supporter_badge'`)
- `prize_category` — prize category (e.g. `'community' | 'raffle' | 'badge'`)
- `streak` — integer (only for milestone events)
- `method` — donation method (`'github_sponsors' | 'open_collective' | 'ethereum' | 'bitcoin' | 'other'`)
- `section` — docs section name (no PII)
- `url` — outbound URL (only when clicked)
- `admin_role` — admin role label (no PII)

## Adding a new event

1. Add the name to the `EVENTS` object in `src/lib/analytics.ts`:
   ```ts
   export const EVENTS = {
     // ...
     MY_NEW_EVENT: 'my_new_event',
   } as const;
   ```
2. Call `trackEvent` from a client component:
   ```ts
   import { trackEvent, EVENTS } from '@/lib/analytics';
   trackEvent(EVENTS.MY_NEW_EVENT, { foo: 'bar' });
   ```
3. Update `src/app/admin/analytics/page.tsx` to add the description.
4. Optional: add the event as a custom goal in your Plausible dashboard.

## Disabling analytics

To turn off analytics entirely, set:

```
NEXT_PUBLIC_ANALYTICS_ENABLED=false
```

The Plausible script will not load and `trackEvent` will be a silent no-op. No errors, no broken layout.

## Compliance checklist

- [x] No cookies set
- [x] No personal data collected
- [x] No cross-site tracking
- [x] No fingerprinting
- [x] Privacy-friendly default (Plausible script only loads when domain is set)
- [x] Disabled by env var (no analytics if env unset)
- [x] Privacy notice updated on `/legal`
- [x] Admin analytics dashboard with full transparency (`/admin/analytics`)

## Files

- `src/components/analytics/plausible.tsx` — the script tag injector
- `src/lib/analytics.ts` — type-safe `trackEvent` + standard event/prop constants
- `src/app/admin/analytics/page.tsx` — admin dashboard
- `src/app/layout.tsx` — `<Plausible />` mounted in root layout
- `src/lib/env.ts` — env var schema (`NEXT_PUBLIC_PLAUSIBLE_DOMAIN`, `NEXT_PUBLIC_PLAUSIBLE_SCRIPT`, `NEXT_PUBLIC_ANALYTICS_ENABLED`)
- `.env.example` — env var template

## References

- Plausible: https://plausible.io
- Plausible self-hosting: https://plausible.io/docs/self-hosting
- Umami (alternative): https://umami.is
- GDPR: https://gdpr.eu
- CCPA: https://oag.ca.gov/privacy/ccpa
