# Design System Strategy: The Ethereal Flow

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Digital Sanctuary."** Unlike standard utility apps that prioritize high-velocity interaction, this system is designed to slow the heart rate. It moves away from the "grid-locked" look of traditional SaaS products, instead embracing **Organic Asymmetry** and **Tonal Depth**.

The interface should feel like light filtering through tropical leaves. We achieve a premium, custom feel by rejecting harsh structural lines and instead using overlapping "frosted" layers, generous white space (kerning and margins), and a sophisticated hierarchy of blurs. This system doesn't just display information; it holds space for the user.

---

## 2. Colors & Atmospheric Layers
Our palette is rooted in nature — specifically the calming tones of teal water, forest canopy, and morning mist. We use Material Design token conventions to manage a serene, teal-driven ecosystem.

### The "No-Line" Rule
**Prohibit 1px solid borders for sectioning.** To create a premium, "airy" feel, boundaries must be defined solely through background color shifts. For instance, a `surface-container-low` section should sit on a `surface` background without a stroke.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical, semi-transparent layers—like stacked sheets of fine vellum.
- **Base Layer:** `surface` (#F0FDFA) — The infinite mint horizon.
- **Content Zones:** `surface-container-low` (#F8FAFC)
- **Interactive Cards:** `surface-container-lowest` (#FFFFFF) for maximum lift and "pure" feel.

### The "Glass & Gradient" Rule
To capture the "Liquid Teal" palette, use linear gradients for primary CTAs and hero backgrounds:
- **Liquid Teal Gradient:** `primary` (#0D9488) transitioning to `primary-container` (#CCFBF1) at 135° angle.
- **Forest Accent Gradient:** `tertiary` (#2D6A4F) to `tertiary-container` (#D1FAE5).
- **Glassmorphism:** For floating navigation or modals, use `surface-container-lowest` with 70-80% opacity and a `20px` backdrop-blur. This allows the soft mint background to bleed through.

---

## 3. Typography: The Editorial Breath
We use a pairing of **Plus Jakarta Sans** (Display/Headlines) and **Manrope** (Body/Labels) to balance modern geometry with human softness.

- **The Breathable Title:** All `display` and `headline` styles must use a `letter-spacing` of `0.05rem` to `0.1rem`.
- **Thin Secondary Text:** For `body-sm` and `label` styles, use a `Light (300)` font weight.
- **Scale Usage:**
- `display-lg` (3.5rem) is reserved for morning greetings or session titles.
- `body-md` (0.875rem) is the workhorse for all instructional text.

---

## 4. Elevation & Depth
In this design system, shadows are treated as "glows" or "ambience" rather than structural supports.

- **Tonal Layering:** Achieve 90% of your hierarchy by stacking `surface-container` tiers.
- **Ambient Shadows:** When a "floating" effect is required, use an extra-diffused shadow: `Y: 10, Blur: 30, Opacity: 6%`. Use a tinted shadow with teal tones.
- **The "Ghost Border" Fallback:** If a divider is essential for accessibility, use the `outline-variant` token at **15% opacity**.

---

## 5. Components

### Buttons (The Core Interaction)
- **Primary:** Gradient-filled (Liquid Teal), `20px` border radius. No border. Soft ambient shadow.
- **Secondary:** `surface-container-high` background with `primary` text.
- **Tertiary:** Ghost style. No background, `0.1rem` letter-spacing on text.

### Cards (The Content Vessel)
- **Style:** `24px` border radius.
- **Treatment:** Use `surface-container-lowest` with a very subtle `primary` tint (2% overlay).
- **Spacing:** Minimum internal padding of `spacing-6` (2rem). Never use dividers.

### Chips (The Filter)
- **Style:** `full` (pill) radius.
- **State:** Active chips use the `secondary-container` color; inactive chips use `surface-container-high`.

### Specialized Meditation Components
- **Progress Ring:** Use a thin (`2px`) stroke. The "trail" should be `outline-variant` at 20% opacity, and the "progress" should use the Liquid Teal gradient.
- **Audio Scrubber:** A simple `2px` line. The handle should be a `surface-container-lowest` circle with ambient shadow.

---

## 6. Do's and Don'ts

### Do
- **Do** use asymmetrical layouts.
- **Do** use teal tones for focus/morning content and forest green for nature/breathing exercises.
- **Do** ensure every screen has at least 20% "empty" space.

### Don't
- **Don't** use 100% black (#000000). Use `on-surface` for all text.
- **Don't** use standard "Drop Shadows" from a UI kit.
- **Don't** use sharp corners. Every interactive element must have at least `8px` radius.
- **Don't** use horizontal lines to separate list items. Use background color shifts or spacing.