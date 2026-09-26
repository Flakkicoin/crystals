# CrystalFlakCoin Brand Guidelines

This document is the source of truth for how the CrystalFlakCoin (CFC) brand is presented. If you're unsure whether a usage is on-brand, refer here.

## Voice & tone

CrystalFlakCoin writes like a careful engineer, not a marketer. Concretely:

- **We use concrete, verifiable statements.** No fake statistics, no "best", no "leading".
- **We name what is not built yet.** "To be announced", "Not yet deployed", "Planned (not committed)".
- **We acknowledge risk.** Every page that touches tokens, staking, or swapping must carry a risk disclaimer (see `src/components/layout/risk-disclaimer.tsx`).
- **We never promise returns.** No "guaranteed profit", "risk-free", "passive income", "you cannot lose", or similar language.
- **We never recruit for income.** No "earn by recruiting", no "MLM", no "compensation plan".
- **We are honest about limitations.** When a feature is incomplete, we say so.

## Logo

### Files

| File | Use |
|------|-----|
| `public/press/logo-primary.svg` | Default, full color. Use on dark backgrounds. |
| `public/press/logo-with-wordmark.svg` | Horizontal lockup with "CrystalFlakCoin" text. Use in headers. |
| `public/press/logo-icon.svg` | Just the crystal mark. Use in app icons, favicons, social avatars. |
| `public/press/logo-mono-light.svg` | Monochrome. Use on light backgrounds when full color isn't desired. |
| `public/press/logo-mono-dark.svg` | Monochrome. Use on dark backgrounds when full color isn't desired. |
| `public/favicon.svg` | Browser favicon. |

### Do

- ✅ Use the official SVG files. Don't screenshot the raster logo.
- ✅ Maintain clear space on all sides equal to the height of the crystal's horizontal seam.
- ✅ Use the violet/ice color palette (see `src/lib/brand-tokens.ts`).
- ✅ When scaling, scale proportionally.
- ✅ When placing on a busy image, place a subtle dark or light backing plate first.

### Don't

- ❌ Don't recolor the logo outside the approved palette.
- ❌ Don't skew, rotate, or stretch the crystal.
- ❌ Don't add drop shadows, bevels, or 3D effects.
- ❌ Don't place the logo on backgrounds with low contrast.
- ❌ Don't recreate the logo by hand — use the SVG files.

### Minimum size

- **Print**: 12 mm high
- **Web**: 32 px high
- **Favicon**: 16 px high (use the icon-only variant below this size)

## Brand colors

The full color palette is defined in `src/lib/brand-tokens.ts` as TypeScript constants. The most important ones:

| Name | Hex | Use |
|------|-----|-----|
| Crystal White | `#ffffff` | Text on dark backgrounds |
| Ink Light | `#e9d8ff` | Body text on dark |
| Ink Muted | `#b6a3d4` | Secondary text |
| Background | `#07021a` | Page background |
| Surface | `#0d0530` | Card backgrounds |
| Crystal | `#7dd3fc` | Primary accent, ice glow |
| Ice | `#38bdf8` | Links, highlights |
| Violet Deep | `#7c3aed` | Headings, deep accents |
| Violet | `#a855f7` | Brand primary |
| Magenta | `#d946ef` | Energy, gradients |

CSS variables (`--cfc-*`) are available globally and are the preferred way to reference these colors in CSS.

## Typography

| Role | Family | Weight | Use |
|------|--------|--------|-----|
| Display | Orbitron | 600–800 | Headings, hero text, page titles |
| Body | Inter | 400–600 | Body text, paragraphs, UI |
| Mono | ui-monospace | 400 | Addresses, hashes, code |

Orbitron is licensed under SIL OFL 1.1 and is bundled locally — no third-party CDN required.

## Boilerplate

For press and partner usage, three pre-written boilerplate lengths are available:

- **Short** — 50 words, single paragraph, for listings
- **Medium** — 100 words, single paragraph, for short mentions
- **Long** — 250 words, multi-paragraph, for full articles

Source: `src/lib/boilerplate.ts`. All three are honest, non-promotional, and explicitly disclaim investment characteristics.

## What to avoid (summary)

This project is honest-by-design. The following types of language and claims are forbidden in any public-facing artifact:

- Investment vehicle language ("buy CFC", "invest in CFC", "hold for X days")
- Return promises ("earn", "yield", "APY", "guaranteed profit", "passive income")
- Recruiting language ("earn by recruiting", "referral income", "MLM")
- FOMO / time-pressure language ("limited time", "don't miss out", "act now")
- Comparison / superiority ("best trading bot", "most powerful compensation plan", "#1 platform")
- Risk denial ("risk-free", "you cannot lose", "97% win rate")

These terms and patterns are enforced by `scripts/legacy-brand-scan.mjs` (CI), which fails the build if any of them are reintroduced.

## Related documents

- `MONETIZATION.md` — Honest monetization policy
- `SECURITY.md` — Security policy and threat model
- `TRANSPARENCY.md` — What's verifiable and what isn't
- `LEGAL.md` — Risk disclosure language
- `LAUNCH_PLAYBOOK.md` — How we launch publicly
