# DESIGN.md — MBTI.BLUE Front-End Contract

> **Status**: AUTHORITATIVE. Every color, size, spacing, and motion value in the
> app MUST trace back to a token defined here. If it isn't here, it doesn't ship.
> Authoring order: this document was written BEFORE any component code. Tokens are
> locked; ad-hoc values are a bug.
>
> **Direction**: Vibrant Personality — content-first darkness (Spotify-derived)
> crossed with Awwwards-tier polish (gpt-tasteskill). The resolved MBTI type is
> the only color in the room. Chrome is achromatic.

---

## 0. Research Log

- **Layer A (taste)**: `gpt-tasteskill` — Awwwards-tier. Chosen for vibrant
  personality over the rejected `minimalist` (too cold) and `soft` (too luxury).
- **Layer B (reference)**: `spotify` — UI recedes so the **personality type**
  glows (Spotify: album art glows). Linear/Stripe/Notion rejected as B2B/editor-y.
- **Lazyweb**: skipped — codebase has working UI to redesign, not greenfield.
- **Motion stack**: vanilla JS + CSS keyframes. No GSAP (Phoenix HEEx compatible).
- **Font stack**: 2 families only. Satoshi display (Fontshare) + system body.

## 1. Target Atmosphere (one paragraph)

Content-first darkness. The canvas is near-black with a subtle blue undertone
(`oklch(0.14 0.005 260)`, `#0E0E12`). Chrome — navigation, footer, surfaces, type —
sits in tightly-spaced dark steps (oklch 0.14 → 0.25) so the only color in the
room is the **resolved MBTI type's accent**, drawn from a 16-entry oklch palette
grouped by temperament (Analysts cyan, Diplomats magenta, Sentinels amber,
Explorers green). Typography is binary — Satoshi display for personality moments,
system stack for chrome — at Spotify-compact sizes. Motion is sparse and
load-bearing: the 4-letter type name cascades in on result reveal, sections fade
in on scroll, hover physics give cards dimension. Heavy shadows are mandatory on
dark surfaces. The signature is **the type is the album art**.

## 2. Color Tokens

### 2.1 Surfaces (Spotify-derived, bluer undertone)

| Role             | Token                  | Light         | Dark                              |
|------------------|------------------------|---------------|-----------------------------------|
| Canvas (app)     | `--color-canvas`       | `#fafafa`     | `oklch(0.14 0.005 260)` `#0E0E12` |
| Surface raised   | `--color-surface`      | `#ffffff`     | `oklch(0.18 0.006 260)` `#181820` |
| Surface card     | `--color-surface-2`    | `#f4f4f6`     | `oklch(0.21 0.007 260)` `#1F1F28` |
| Surface elevated | `--color-surface-3`    | `#ececef`     | `oklch(0.25 0.008 260)` `#25252E` |
| Border subtle    | `--color-border`       | `#e4e4e7`     | `oklch(0.30 0.008 260)` `#2F2F38` |
| Border default   | `--color-border-strong`| `#d4d4d8`     | `oklch(0.38 0.008 260)` `#3D3D48` |
| Text primary     | `--color-text`         | `oklch(0.18 0.01 260)` | `#ffffff`               |
| Text secondary   | `--color-text-muted`   | `oklch(0.45 0.01 260)` | `oklch(0.70 0.008 260)` `#B3B3BE` |
| Text tertiary    | `--color-text-faint`   | `oklch(0.60 0.008 260)` | `oklch(0.50 0.008 260)` `#7C7C88` |

**Dark is default.** Light is opt-in via toggle.

### 2.2 Per-type accent palette (16 types, the only color in the room)

oklch L floor `0.70` for WCAG AA on near-black.

**Analysts (NT)** — cool cyan/blue (intellect, logic)

| Type  | Hue (oklch)            | Token         |
|-------|------------------------|---------------|
| INTJ  | `oklch(0.72 0.15 250)` | `--type-intj` |
| INTP  | `oklch(0.74 0.14 230)` | `--type-intp` |
| ENTJ  | `oklch(0.70 0.17 255)` | `--type-entj` |
| ENTP  | `oklch(0.75 0.16 215)` | `--type-entp` |

**Diplomats (NF)** — warm magenta/pink (emotion, connection)

| Type  | Hue (oklch)            | Token         |
|-------|------------------------|---------------|
| INFJ  | `oklch(0.70 0.17 340)` | `--type-infj` |
| INFP  | `oklch(0.74 0.16 0)`   | `--type-infp` |
| ENFJ  | `oklch(0.72 0.18 350)` | `--type-enfj` |
| ENFP  | `oklch(0.76 0.17 15)`  | `--type-enfp` |

**Sentinels (SJ)** — earthy amber/gold (tradition, duty)

| Type  | Hue (oklch)            | Token         |
|-------|------------------------|---------------|
| ISTJ  | `oklch(0.72 0.14 75)`  | `--type-istj` |
| ISFJ  | `oklch(0.74 0.13 95)`  | `--type-isfj` |
| ESTJ  | `oklch(0.70 0.15 70)`  | `--type-estj` |
| ESFJ  | `oklch(0.76 0.14 85)`  | `--type-esfj` |

**Explorers (SP)** — vivid green/lime (action, sensation)

| Type  | Hue (oklch)            | Token         |
|-------|------------------------|---------------|
| ISTP  | `oklch(0.72 0.16 155)` | `--type-istp` |
| ISFP  | `oklch(0.74 0.15 140)` | `--type-isfp` |
| ESTP  | `oklch(0.70 0.18 165)` | `--type-estp` |
| ESFP  | `oklch(0.76 0.17 145)` | `--type-esfp` |

**Temperament → cardinal group**

| Group     | Code | Types                | Hue range |
|-----------|------|----------------------|-----------|
| Analysts  | NT   | INTJ INTP ENTJ ENTP  | 215–255°  |
| Diplomats | NF   | INFJ INFP ENFJ ENFP  | 340–15°   |
| Sentinels | SJ   | ISTJ ISFJ ESTJ ESFJ  | 70–95°    |
| Explorers | SP   | ISTP ISFP ESTP ESFP  | 140–165°  |

### 2.3 Shadows (mandatory heavy on dark)

| Token       | Value                                              | Use                          |
|-------------|----------------------------------------------------|------------------------------|
| Subtle      | `0 1px 2px rgba(0,0,0,0.08)`                       | Flat surfaces                |
| Default     | `0 2px 8px rgba(0,0,0,0.12)`                       | Raised surfaces              |
| Prominent   | `0 8px 24px rgba(0,0,0,0.40)`                      | Cards on dark                |
| Glow (per-type) | `0 0 0 1px var(--type-accent), 0 0 24px -4px var(--type-accent)` | Accent focus |

## 3. Typography

**Stacks** (2 families):

- **Display**: `"Satoshi", system-ui, sans-serif` — type names, hero, dimensional
  headings. Loaded via Fontshare CDN with `font-display: swap`.
- **Body**: `-apple-system, BlinkMacSystemFont, "Segoe UI", system-ui, sans-serif` —
  Spotify-style, compact, zero font payload.
- **Numeric/tabular**: body stack with `font-variant-numeric: tabular-nums`.

**Type scale** (body never below 14px):

| Level       | Size                         | Weight | LineHeight | Tracking  | Use                |
|-------------|------------------------------|--------|------------|-----------|--------------------|
| Hero (H1)   | `clamp(2.75rem, 6vw, 5rem)`  | 700    | 1.02       | -0.03em   | Home hero          |
| Type name   | `clamp(3rem, 8vw, 6rem)`     | 700    | 0.95       | -0.04em   | Result type name   |
| H2 section  | `1.75rem` (28px)             | 700    | 1.15       | -0.02em   | Result sections    |
| H3 card     | `1.25rem` (20px)             | 600    | 1.25       | -0.01em   | Card titles        |
| Body L      | `1.125rem` (18px)            | 400    | 1.55       | 0         | Lead paragraphs    |
| Body        | `1rem` (16px)                | 400    | 1.55       | 0         | Default            |
| Body bold   | `1rem` (16px)                | 700    | 1.55       | 0         | Inline emphasis    |
| Small       | `0.875rem` (14px)            | 400    | 1.45       | 0         | Metadata           |
| Button      | `0.875rem` (14px)            | 700    | 1          | 0.04em    | Uppercase buttons  |
| Badge       | `0.75rem` (12px)             | 600    | 1          | 0.06em    | Tags, dim labels   |
| Micro       | `0.6875rem` (11px)           | 600    | 1.2        | 0.08em    | Uppercase eyebrows|

## 4. Geometry & Layout

### 4.1 Radius scale (pills everywhere buttons live)

| Token            | Value  | Use                              |
|------------------|--------|----------------------------------|
| `--radius-xs`    | 4px    | Badges, tags                     |
| `--radius-sm`    | 6px    | Album-type-art cards             |
| `--radius-md`    | 8px    | Default cards                    |
| `--radius-lg`    | 12px   | Panels, sheets                   |
| `--radius-xl`    | 20px   | Large feature cards              |
| `--radius-pill`  | 9999px | Buttons, search inputs, pills    |
| `--radius-full`  | 50%    | Circular controls, type orbs     |

### 4.2 Spacing scale (4px base)

`--space-1` 4 · `--space-2` 8 · `--space-3` 12 · `--space-4` 16 · `--space-5` 20 ·
`--space-6` 24 · `--space-8` 32 · `--space-10` 40 · `--space-12` 48 · `--space-16` 64 ·
`--space-20` 80 · `--space-24` 96 · `--space-32` 128.

**Section rhythm**: `py-20 md:py-32` between result sections.

### 4.3 Grid

- **Content max**: `--content-max: 80rem` (1280px). Previous `max-w-2xl` was the
  horizontal clip bug.
- **Result content**: `--content-result: 48rem` (768px) — single-column result story.
- **Bento grid**: 12-col `lg`, 6-col `md`, 4-col `sm`.
- **Breakpoints**: Tailwind defaults — sm 640, md 768, lg 1024, xl 1280, 2xl 1536.
- **Overflow guard**: `<main>` always wraps with `overflow-x-hidden w-full max-w-full`.

## 5. Component Primitives

> Forward-declared here; implemented in Phase 3 as `MbtiComponents`. Every primitive
> consumes §2–4 tokens only — no hard-coded colors/sizes. The accent color flows
> via `style={"--type-accent: var(#{@mbti_info.accent_css_var})"}` on the result
> card root.

| Primitive        | Props                                          | Notes                                  |
|------------------|------------------------------------------------|----------------------------------------|
| `<.type_hero>`       | `type`, `mbti_info`, `animated?`           | Big type card: name + desc + orb       |
| `<.dimension_grid>`  | `dimensions` (E/I..J/P), `accent`          | 4-card grid with slider bars           |
| `<.traits_list>`     | `traits`, `accent`, `tone: :pos\|:neg`     | Reused for Strengths/Weaknesses        |
| `<.careers_list>`    | `careers`, `accent`                        | Pill-grid of career tags               |
| `<.famous_people>`   | `famous_people`, `accent`                  | Compact list with avatar initials      |
| `<.ai_reason>`       | `reason`                                   | Styled blockquote                      |
| `<.share_bar>`       | `share_url`, `actions`                     | Copy/select/regenerate action row      |
| `<.result_empty>`    | `handle`                                   | Pre-result placeholder                 |
| `<.result_loading>`  | `accent`                                   | Per-type-colored progress              |
| `<.result_error>`    | `error`                                    | Async error block                      |
| `<.search_input>`    | `form`, `phx-submit`, `loading?`           | Handle search bar                      |

## 6. Motion

Vanilla JS (Phoenix HEEx, no GSAP). IntersectionObserver for scroll; CSS for the rest.

| Tier         | Duration    | Easing                       | Use                          |
|--------------|-------------|------------------------------|------------------------------|
| Micro        | 120ms       | ease-out                     | Hover, focus, press          |
| Standard     | 220ms       | `cubic-bezier(0.4,0,0.2,1)`  | Theme toggle, dropdown       |
| Emphasis     | 480ms       | `cubic-bezier(0.16,1,0.3,1)` | Type reveal, section entry   |
| Type cascade | 32ms/letter | linear                       | Stagger on type-name reveal  |

**Signature moments** (defined as keyframes in `app.css`):

1. **Type reveal** — on result mount, 4-letter type cascades letter-by-letter
   (32ms stagger, scale 0.8→1.0 + opacity 0→1, 480ms/letter). Total wall-clock < 600ms.
2. **Section entries** — each result section IntersectionObserver-fades in
   (opacity 0→1 + translateY 16px→0, 480ms Emphasis, 80ms stagger between cards).
3. **Per-type orb** — radial-gradient orb (accent @ 80% transparent) behind the
   type name, scale 0.7→1.0 over 600ms.
4. **Hover physics** — cards `group-hover:scale-[1.02]` + `transition-transform
   duration-300` inside `overflow-hidden` parents. Interactive cards only.

`prefers-reduced-motion: reduce` → disable all entries except opacity-only fades.
No stagger, no scale.

## 7. Theme Toggle

- `<.theme_toggle>` lives in `layouts.ex`; uncommented in the header.
- **Default theme is DARK.** `root.html.heex` theme-init IIFE defaults to `"dark"`.
- Light is opt-in via toggle. Both themes defined via the `@theme` block + `dark:`
  Tailwind variant keyed on `data-theme`.
- Toggle dispatches `phx:set-theme` → root IIFE writes `localStorage["phx:theme"]`.

## 8. Accessibility & Accepted Debt

### 8.1 A11y commitments

- All per-type accent oklch values have L ≥ 0.70 for WCAG AA on near-black. Verified
  in `/visual-qa` with a contrast check at the gate.
- `prefers-reduced-motion: reduce` disables stagger + scale (keeps opacity fade).
- IntersectionObserver usage is feature-detected (`if ("IntersectionObserver" in window)`).
- Focus rings preserved on all interactive primitives.
- Body type never below 14px.

### 8.2 Accepted debt (pre-existing, documented)

- `mix credo --strict` not run — credo is not installed in this project. Installing
  it is a separate task. Tracked in plan §Out of Scope.
- Pre-existing `mix compile` warnings unrelated to this redesign may exist; only
  warnings introduced by this work are blocking.

### 8.3 Out of scope (future tasks)

- AI prompt augmentation (`confidence`, `tweet_count`, `sample_tweets`).
- Authentication / `current_scope` wiring.
- New routes (only `/` and `/result/:handle` exist).
- Backend caching policy changes (24h TTL stays).
- Bluesky OAuth or persistent user accounts.
- i18n.

### 8.4 Post-redesign verification (Lighthouse, home page `/`)

| Category        | Mobile | Desktop |
|-----------------|--------|---------|
| Accessibility   | 100    | 100     |
| Best Practices  | 100    | 100     |
| SEO             | 100    | 100     |
| Performance     | 77     | 97      |

Accessibility / Best Practices / SEO hit the floor-100 gate after the footer
contrast fix (`text-faint` → `text-muted`, 3.31:1 → ~7:1) and the addition of a
`<meta name="description">`.

Mobile performance is LCP-bound (6.6s). Root cause is the Satoshi webfont loaded
via render-blocking `@import` from the Fontshare CDN, compounded by Phoenix
LiveView's WebSocket bootstrap on throttled mobile CPU. Desktop performance is
near-perfect (97, LCP 1.2s). Reaching mobile performance 100 requires
**self-hosting Satoshi with `<link rel="preload">` + `font-display: swap`**
(tracked as future work; out of this redesign's scope).

### 8.5 Minor motion deviations from §6 (intentional)

1. **§6.3 orb bloom duration**: implemented at `--motion-emphasis` (480ms) rather
   than the specified 600ms. Keeps the orb within the Emphasis motion tier for
   consistency with the type-reveal and section-entry timing; the visual bloom is
   imperceptibly different.
2. **§6.4 hover physics**: implemented as `hover:-translate-y-0.5` (−2px lift) +
   `hover:shadow-default` rather than `group-hover:scale-[1.02]`. A translate-lift
   preserves card-content readability (no reflow/scaling of text) while delivering
   the same tactile intent. Both are valid hover-physics patterns; the chosen one
   reads as more premium.
