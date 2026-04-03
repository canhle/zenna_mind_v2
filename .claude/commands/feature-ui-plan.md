---
description: Create a UI implementation plan for a screen from design files in docs/design/
tools: Read, Write, Glob, Grep, Bash(dart run build_runner build --delete-conflicting-outputs), Bash(flutter gen-l10n), Bash(flutter analyze), Bash(ls)
---

You are a senior Flutter engineer creating a UI implementation plan from HTML/CSS/PNG design files stored in `docs/design/`.

## Input

Parse `$ARGUMENTS` for the following:

1. **Screen name** (required) — name of the subfolder in `docs/design/` (e.g., `home`, `browser`, `welcome`)
2. **Data source annotations** (optional) — which data items are static vs dynamic (from API)
3. **Additional instructions** (optional) — e.g., reusable components to consider

### Example inputs

**Screen name only:**
```
home
```

**With annotations:**
```
home static: title, labels dynamic: meditation list, user info
```

### Design source resolution

Each screen folder in `docs/design/{screen_name}/` may contain:
- `screen.png` — visual screenshot of the design
- `code.html` — HTML/CSS source code with exact styles

If no argument is provided:
- List all subfolders in `docs/design/` and ask the user to choose one

### Data source defaults

If data source annotations are NOT provided:
- Default: treat all UI label text as static (l10n)
- For ambiguous data (could be static or from API), mark as **"NEEDS CONFIRMATION"** and ask the user to clarify before implementation

---

## STEP 0 — Load Project Context (MANDATORY)

Read these files before any planning:

**Coding rules:**
1. `docs/coding-conventions.md` — coding conventions
2. `docs/coding-checklist.md` — enforcement checklist

**Design system tokens:**
3. `lib/design_system/tokens/ds_colors.dart` — color tokens (`DsColors.*`)
4. `lib/design_system/tokens/ds_typography.dart` — text theme (`DsTypography.textTheme`)
5. `lib/design_system/tokens/ds_spacing.dart` — spacing tokens (`DsSpacing.*`)
6. `lib/design_system/tokens/ds_radius.dart` — border radius tokens (`DsRadius.*`)
7. `lib/design_system/tokens/ds_shadows.dart` — shadow tokens (`DsShadows.*`)
8. `lib/design_system/tokens/ds_durations.dart` — animation durations (`DsDurations.*`)
9. `lib/design_system/theme/ds_theme.dart` — ThemeData builder
10. `lib/design_system/design_system.dart` — barrel export (list of available components)

**Design system components:**
11. `lib/design_system/components/` — read all files to know available reusable components

**Reference implementations:**
12. `lib/features/welcome/welcome_screen.dart` — screen pattern (ConsumerStatefulWidget)
13. `lib/features/welcome/welcome_view_model.dart` — ViewModel pattern (Notifier<UiState>)
14. `lib/features/welcome/models/welcome_ui_state.dart` — UiState + Events pattern
15. `lib/features/product_list/product_list_view_model.dart` — ViewModel with data loading pattern
16. `lib/features/product_list/models/product_list_ui_state.dart` — UiState with AsyncValue + data wrapper

**L10n:**
17. `lib/core/l10n/arb/app_en.arb` — existing English strings
18. `lib/core/l10n/arb/app_vi.arb` — existing Vietnamese strings

**Router:**
19. `lib/core/router/app_router.dart` — existing routes

---

## STEP 1 — Extract Design

### 1.1 Read Design Files

1. Read the screenshot image (`docs/design/{screen_name}/screen.png`) — analyze visual layout, elements, spacing, colors
2. Read the HTML/CSS code (`docs/design/{screen_name}/code.html`) — extract exact values:
   - Complete color palette (hex, rgba values)
   - Typography styles (font family, sizes, weights, letter-spacing, line-height)
   - Spacing values (padding, margin, gaps)
   - Border radius values
   - Shadow definitions
   - Layout structure (flex direction, alignment, positioning)
   - Component hierarchy (cards, buttons, inputs, lists, etc.)
   - All text content (for mock data and l10n)
   - All icon usage
   - Gradient definitions
   - Glassmorphism / backdrop-blur effects
3. Cross-reference screenshot visuals with HTML/CSS values for accuracy

### 1.2 Screen Overview

- Screen name (English + Vietnamese if applicable)
- Purpose and user flow context
- Design source: screenshot path + code file path

### 1.3 Visual Hierarchy

List every visual element top-to-bottom:
- Element type (text, button, input, list, card, image, icon, etc.)
- Content / label text
- Position (fixed header, scrollable body, fixed footer, etc.)

### 1.4 Design Tokens Mapping

For each text element, map design styles to project tokens:

| Element | Design Size/Weight/Font | Project TextStyle | Notes |
|---------|------------------------|-------------------|-------|
| Title | 30px/w800/PlusJakartaSans | `Theme.of(context).textTheme.headlineMedium` | |
| Body | 18px/w300/Manrope | `Theme.of(context).textTheme.bodyLarge` | |

**Typography reference (from `DsTypography`):**
- Headline font: **Plus Jakarta Sans** (displayLarge → titleLarge)
- Body/Label font: **Manrope** (titleMedium → labelSmall)
- Access via `Theme.of(context).textTheme.*`

For each color, map to project tokens:

| Usage | Design Color | Project Token | Notes |
|-------|-------------|---------------|-------|
| Background | #F0FDFA | `DsColors.surface` | |
| Primary | #0D9488 | `DsColors.primary` | |
| Text | #0F172A | `DsColors.onSurface` | |

**Important:** If a design color does not match any existing `DsColors` token, flag it and propose adding it as an app-specific token.

### 1.5 Spacing & Layout

Document all spacing values and map to `DsSpacing` tokens:

| Usage | Design Value | Project Token |
|-------|-------------|---------------|
| Screen padding | 16px | `DsSpacing.md` (16) |
| Section gap | 24px | `DsSpacing.lg` (24) |
| Item gap | 8px | `DsSpacing.sm` (8) |

**Available spacing tokens:** xs=4, sm=8, md=16, lg=24, xl=32, xxl=48
**Semantic aliases:** screenPadding=16, sectionGap=24, itemGap=8

For border radius, map to `DsRadius`:

| Usage | Design Value | Project Token |
|-------|-------------|---------------|
| Card | 12px | `DsRadius.md` (12) |
| Button | 16px | `DsRadius.lg` (16) |

**Available radius tokens:** xs=4, sm=8, md=12, lg=16, xl=24, full=999

Document:
- Scroll behavior (which sections fixed, which scrollable)
- SafeArea usage
- Overflow handling

### 1.6 Interactive Elements

For each interactive element:
- Type (button, radio, checkbox, text input, dropdown, etc.)
- States (enabled, disabled, selected, error)
- Behavior on tap / change
- Existing DS component to use (e.g., `DsButton`, `DsTextField`, `DsCard`)

### 1.7 Data Source Classification

Classify every data item on the screen:

| Data Item | Source | Notes |
|-----------|--------|-------|
| App bar title | Static (l10n) | |
| Body text | Static (l10n) | |
| Item list | Dynamic (API) | NEEDS CONFIRMATION |

Source types:
- **Static (l10n)** — UI text, localized via ARB files, accessed via `S.of(context)!.key`
- **Static (constant)** — values not requiring l10n
- **Dynamic (API)** — fetched from backend via Repository → Provider → ViewModel
- **Dynamic (local)** — user input or computed from other state
- **Dynamic (mock)** — mock data for now, API later
- **NEEDS CONFIRMATION** — ambiguous, must be confirmed with user

---

## STEP 2 — Localization Keys

### 2.1 Check Existing Keys

Search `lib/core/l10n/arb/app_en.arb` for any existing keys that match the screen's text.

### 2.2 Plan New Keys

For each static text that needs localization:

| Key | EN | VI | Reuse Existing? |
|-----|----|----|-----------------|
| `{screen}_title` | ... | ... | No |
| `{screen}_subtitle` | ... | ... | No |

Rules:
- Use `{screen_name}_` prefix for screen-specific strings
- Reuse existing common keys when available
- Do NOT create keys for data that will come from the backend

---

## STEP 3 — Architecture Plan

### 3.1 File Structure

```
lib/features/{feature_name}/
  ├── {feature_name}_screen.dart                # ConsumerStatefulWidget
  ├── {feature_name}_view_model.dart            # @riverpod Notifier<UiState>
  ├── models/
  │   ├── {feature_name}_ui_state.dart          # @freezed UiState + sealed Events
  │   ├── {feature_name}_arguments.dart         # @freezed Arguments (if needed)
  │   └── {feature_name}_mock_data.dart         # Mock data (if needed)
  └── components/
      ├── {component_a}.dart                    # Sub-widget
      └── {component_b}.dart                    # Sub-widget
```

If the feature needs domain/data layer:
```
lib/domain/
  ├── entities/{entity_name}.dart               # @freezed Entity
  ├── repositories/{feature}_repository.dart    # Abstract interface
  ├── usecases/{feature}/
  │   └── {use_case}_usecase.dart               # UseCase class
  └── providers/{feature}_domain_providers.dart  # UseCase + functional providers

lib/data/
  ├── models/{model_name}_model.dart            # @JsonSerializable Model
  ├── datasources/{feature}_remote_datasource.dart
  ├── repositories/{feature}_repository_impl.dart
  └── providers/{feature}_data_providers.dart
```

### 3.2 UiState Design

Define the UiState class following the project pattern:

```dart
@freezed
class {ScreenName}UiState with _${ScreenName}UiState {
  const factory {ScreenName}UiState({
    // Use AsyncValue for fields with loading/error states
    // Wrap List<T> in a Freezed data class (never AsyncValue<List<T>>)
    // Use @Default for initial values
    {ScreenName}Event? event,
  }) = _{ScreenName}UiState;
}
```

Rules (from coding-conventions.md):
- **§2.1:** UiState must be `@freezed`, ViewModel state must be synchronous (NOT AsyncNotifier)
- **§2.2:** Use `AsyncValue` for loading/error — never `bool isLoading`
- **§2.2:** Never `AsyncValue<List<T>>` — wrap in Freezed data class
- **§6.1:** No mutable instance fields in ViewModel

### 3.3 Events (if needed)

```dart
sealed class {ScreenName}Event {
  const {ScreenName}Event();
}
```

Convention §2.4: Use Event only for one-time effects (navigation, toast). API loading/error goes in UiState.

### 3.4 ViewModel Methods

| Method | Trigger | Action | State Update |
|--------|---------|--------|--------------|
| `build()` | Init | Returns initial UiState, calls fetch | Initial state |
| `fetchXxx()` | `build()` | `listenWithAutoClose` on provider | Updates AsyncValue |
| `onXxxTap()` | User tap | Business logic | `copyWith(...)` |
| `consumeEvent()` | After event | Clears event | `copyWith(event: null)` |

Rules:
- **§1.2:** Use `listenWithAutoClose` for initial data loading
- **§1.2:** Use `ref.read` only for user-triggered actions
- **§1.2:** Do NOT use `ref.watch` in ViewModels
- **Mixin:** `with ListenWithAutoClose` (from `core/mixins/listen_with_auto_close.dart`)

### 3.5 Provider Functions (if dynamic data)

| Provider | Signature | Repository Method |
|----------|-----------|-------------------|
| `fetchXxxProvider` | `Future<XxxData>` | `xxxRepository.getXxx()` |

Convention §1.1: ViewModel accesses Repositories via Providers only.

### 3.6 Repository Methods (if dynamic data)

| Method | Return Type | Current (Mock) | Future (Backend) |
|--------|-------------|----------------|------------------|
| `getXxx()` | `Future<List<Xxx>>` | Hardcoded data | API call |

---

## STEP 4 — Widget Decomposition

### 4.1 Component Tree

```
{ScreenName}Screen (ConsumerStatefulWidget)
  ├── Scaffold
  │   └── Body
  │       ├── {SectionA} (StatelessWidget / ConsumerWidget)
  │       ├── {SectionB} (ConsumerWidget)
  │       │   └── {ListItem} (StatelessWidget)
  │       └── {BottomAction} (ConsumerWidget)
```

### 4.2 Component Details

For each component:

| Component | Type | Watches (via .select) | File |
|-----------|------|----------------------|------|
| Screen | `ConsumerStatefulWidget` | Full state (events) | `{screen}_screen.dart` |
| SectionA | `StatelessWidget` | Nothing (pure) | `components/section_a.dart` |
| SectionB | `ConsumerWidget` | `s.fieldB` | `components/section_b.dart` |

Rules:
- **§5.6:** Extract to `components/` subfolder, prefer `StatelessWidget` over `_buildXxx()`
- **§5.7:** Each ConsumerWidget uses `.select()` to watch only needed fields
- **§5.4:** Use `const` constructors wherever possible
- **Design Tokens:** Use `DsColors.*`, `DsSpacing.*`, `DsRadius.*`, `DsShadows.*` — never raw hex values
- **Typography:** Use `Theme.of(context).textTheme.*` — never raw TextStyle with hardcoded font

### 4.3 Reusable Components Check

Search existing `lib/design_system/components/` for reusable widgets before creating new ones:
- Buttons → `DsButton` (primary, secondary, text variants; small, medium, large sizes)
- App bar → `DsAppBar`
- Text input → `DsTextField`
- Card → `DsCard`
- Badge → `DsBadge`
- Dialog → `DsDialog`
- Bottom sheet → `DsBottomSheet`
- Toast → `DsToast`

Also check `lib/core/widgets/`:
- `LoadingView` — loading spinner/state display
- `ErrorView` — error display component

---

## STEP 5 — Design System Token Updates

Compare extracted design values against current tokens. If the design uses values not in the current token set:

### 5.1 New Colors

| Color | Hex | Proposed Token Name | Reason |
|-------|-----|-------------------|--------|
| e.g. | #xxx | `DsColors.xxxNew` | Used for... |

### 5.2 New Spacing / Radius / Shadows

Only propose additions if design values differ significantly from existing tokens.

### 5.3 New Components

If the screen uses UI patterns not in `lib/design_system/components/`:
- Propose new DS component
- Follow naming: `ds_{component_name}.dart`
- Add export to `lib/design_system/design_system.dart`

---

## STEP 6 — Implementation Checklist

Generate a checklist of tasks in implementation order:

```
1. [ ] Update design system tokens if needed (Step 5)
2. [ ] Create new DS components if needed (Step 5.3)
3. [ ] Create domain entities (if dynamic data)
4. [ ] Create abstract repository interface (if dynamic data)
5. [ ] Create repository implementation (if dynamic data)
6. [ ] Create data providers (if dynamic data)
7. [ ] Create use case (if dynamic data)
8. [ ] Create domain providers (if dynamic data)
9. [ ] Create UiState + Events (`features/{name}/models/`)
10. [ ] Run build_runner: `dart run build_runner build --delete-conflicting-outputs`
11. [ ] Create ViewModel (`features/{name}/`)
12. [ ] Run build_runner again
13. [ ] Add l10n keys to `app_en.arb` and `app_vi.arb`
14. [ ] Run l10n generation: `flutter gen-l10n`
15. [ ] Create mock data file (if needed)
16. [ ] Create screen widget (`features/{name}/`)
17. [ ] Create component widgets (`features/{name}/components/`)
18. [ ] Add route to `app_router.dart`
19. [ ] Run analyzer: `flutter analyze`
20. [ ] Verify against design screenshot (Step 7)
```

---

## STEP 7 — Post-Implementation Design Verification

After implementation is complete, this verification step MUST be performed.

### 7.1 Verification Procedure

1. Re-read the screenshot (`docs/design/{screen_name}/screen.png`)
2. Re-read the HTML code (`docs/design/{screen_name}/code.html`)
3. Read all implemented source files
4. Compare element-by-element against the design

### 7.2 Verification Checklist

| # | Check | Design Value | Code Value | Match? |
|---|-------|-------------|------------|--------|
| 1 | Background color | #xxx | `DsColors.xxx` | |
| 2 | Text style: heading | 30px/w800 | `textTheme.headlineMedium` | |
| 3 | Section padding | 16px | `DsSpacing.md` | |
| 4 | Card border radius | 12px | `DsRadius.md` | |
| 5 | Gap between A and B | 24px | `DsSpacing.lg` | |
| ... | ... | ... | ... | |

### 7.3 Scroll & Layout Verification

- Which sections are fixed (header, footer)
- Which sections scroll
- SafeArea applied correctly
- Overflow handling

### 7.4 Interactive State Verification

For each interactive element:
- Default state renders correctly
- Selected/active state renders correctly
- Disabled state renders correctly (if applicable)

### 7.5 Discrepancy Resolution

If any mismatch is found:
- Document the discrepancy
- Provide the code change needed
- Re-run `flutter analyze` after fixing

---

## STEP 8 — Coding Convention Compliance Matrix

Verify the plan against `docs/coding-checklist.md`, organized by file type.

**UiState:**

| # | Rule | How Satisfied |
|---|------|---------------|
| §3.1 | `@freezed`, synchronous | Defined as `@freezed` class |
| §3.2 | AsyncValue for loading/error | All async fields use AsyncValue |
| §3.3 | No `AsyncValue<List<T>>` | Wrapped in Freezed data class |
| §3.5 | Event pattern | Sealed class, consumeEvent() |

**ViewModel:**

| # | Rule | How Satisfied |
|---|------|---------------|
| §2.1 | Notifier<UiState>, not AsyncNotifier | ViewModel extends _$...ViewModel |
| §2.2 | listenWithAutoClose for initial load | Used in fetch methods |
| §13.1 | No mutable instance fields | All state in UiState |

**Widgets:**

| # | Rule | How Satisfied |
|---|------|---------------|
| §1 | UI reads only from UiState | Components watch ViewModel |
| §12.4 | const, .select(), StatelessWidget | Applied per component |
| §12.5 | No `_buildXxx()` for reusable UI | Extracted to components/ |

**Design System:**

| # | Rule | How Satisfied |
|---|------|---------------|
| — | All colors via DsColors tokens | Mapped in §1.4 |
| — | All text via Theme.textTheme | Mapped in §1.4 |
| — | All spacing via DsSpacing | Mapped in §1.5 |

Skip rows that don't apply to this screen.

---

## OUTPUT

Write the plan to: `docs/design/{screen_name}/ui_plan.md`

The plan must be self-contained — another developer (or Claude with `/feature-ui-impl`) should be able to implement the screen from this plan alone without needing to re-analyze the design files.
