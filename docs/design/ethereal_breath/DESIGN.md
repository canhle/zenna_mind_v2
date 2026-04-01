# Design System Strategy: The Breathable Interface

## 1. Overview & Creative North Star: "Atmospheric Serenity"
This design system moves away from the rigid, boxed-in structures of traditional utility apps. Our Creative North Star is **Atmospheric Serenity**—a philosophy where the interface feels less like a software tool and more like a gentle morning mist.

By leveraging intentional asymmetry, expansive negative space, and a "borderless" architecture, we create an environment that invites the user to exhale. We use the **24px (1.5rem)** corner radius and soft tonal shifts to guide the eye.

---

## 2. Colors & Surface Architecture
We use a Teal-based palette inspired by calm water and natural serenity.

### The "No-Line" Rule
Solid 1px borders are strictly prohibited for sectioning. Boundaries must be defined through background shifts.

### Surface Hierarchy & Nesting
- **Base Layer:** `surface` (#F0FDFA) — The infinite mint horizon.
- **Sectional Layer:** `surface_container_low` (#F8FAFC)
- **Action Layer:** `surface_container_lowest` (#FFFFFF)
- **Focus Layer:** `surface_container_highest` (#E2E8F0)

### The "Glass & Gradient" Rule
- **Liquid Teal Gradient:** `primary` (#0D9488) to `primary_container` (#CCFBF1) at 135°.
- **Glassmorphism:** `surface` at 70% opacity + Backdrop Blur (20px to 40px).

---

## 3. Typography
We utilize **Plus Jakarta Sans** for all text.

- **Display:** Tight letter spacing (-0.02em)
- **Body:** Generous line-height (1.6x), use `on_surface_variant` (#475569) for long-form
- **Hierarchy:** Extreme contrast between `display-lg` and `label-sm`

---

## 4. Elevation & Depth: Tonal Layering
- Stack `surface_container` tiers instead of shadows.
- **Ambient Shadows:** blur 30-60px with 4-8% opacity, tinted with teal: `rgba(13, 148, 136, 0.08)`.
- **Ghost Border:** `outline_variant` at 20% opacity.

---

## 5. Components
All components must adhere to **full (24px/9999px)** roundedness.

- **Buttons Primary:** Liquid Teal gradient. No border.
- **Cards:** No dividers. Use spacing and surface tiers.
- **Selection Chips:** Pill-shaped. Selected: `primary` with `on_primary` text.
- **Progress Bar:** Teal fill with ambient glow.

---

## 6. Do's and Don'ts

### Do
- Use white space as structure. If enough, add 20% more.
- Use teal for focus/morning, forest green for nature/breathing.
- Use asymmetrical layouts.

### Don't
- Don't use 1px dividers or borders.
- Don't use pure black (#000000) or heavy shadows.
- Don't crowd edges. Min margin: `spacing-6` (2rem).
- Don't use sharp corners. Minimum `lg` roundness.