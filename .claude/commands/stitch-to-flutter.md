---
description: Convert a Stitch screen into Flutter code following Clean Architecture conventions
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(dart run build_runner build --delete-conflicting-outputs), Bash(flutter gen-l10n), Bash(flutter analyze), Bash(ls), mcp__stitch__get_screen, mcp__stitch__get_project, mcp__stitch__list_screens, mcp__stitch__list_design_systems, WebFetch
---

# /stitch-to-flutter

Convert a Stitch screen design into Flutter code with mock data, following the project's Clean Architecture conventions.

## Usage

```
/stitch-to-flutter <screen_name_or_id>
```

If no argument is provided, list all visible screens from the Stitch project and ask the user to choose one.

## Constants

- **Project ID:** `1811552885964999424`
- **Project name:** `projects/1811552885964999424`

## Process

### Step 1 — Identify the target screen

If the user provided a screen name or ID:
- Use `mcp__stitch__list_screens` to find the matching screen
- Match by title (partial, case-insensitive) or by screen ID

If no argument provided:
- List all screens from the project using `mcp__stitch__list_screens`
- Filter to only show visible screens (exclude hidden ones from the project's screenInstances where `hidden: true`)
- Present a numbered list with screen titles
- Ask the user to choose

### Step 2 — Fetch the screen design

1. Use `mcp__stitch__get_screen` to get full screen details (HTML code URL + screenshot URL)
2. Use `WebFetch` to download the HTML code and extract:
   - Complete color palette used (hex, rgba values)
   - Typography styles (font family, sizes, weights, letter-spacing)
   - Spacing values (padding, margin, gaps)
   - Border radius values
   - Shadow definitions
   - Layout structure (flex direction, alignment, positioning)
   - Component hierarchy (cards, buttons, inputs, lists, etc.)
   - All text content (for mock data)
   - All icon usage
   - Gradient definitions
   - Glassmorphism / backdrop-blur effects

### Step 3 — Verify and update Design System tokens

Before generating screen code, ensure the design system tokens in `lib/design_system/tokens/` match the Stitch design.

**Read current tokens:**
- `lib/design_system/tokens/ds_colors.dart`
- `lib/design_system/tokens/ds_typography.dart`
- `lib/design_system/tokens/ds_spacing.dart`
- `lib/design_system/tokens/ds_radius.dart`
- `lib/design_system/tokens/ds_shadows.dart`
- `lib/design_system/tokens/ds_durations.dart`
- `lib/design_system/theme/ds_theme.dart`

**Compare and update if needed:**

For `ds_colors.dart`, map colors from the Stitch design system. Use the full Material Design 3 color token set:

```dart
abstract class DsColors {
  // Primary
  static const Color primary = Color(0xFF______);
  static const Color onPrimary = Color(0xFF______);
  static const Color primaryContainer = Color(0xFF______);
  static const Color onPrimaryContainer = Color(0xFF______);

  // Secondary
  static const Color secondary = Color(0xFF______);
  static const Color onSecondary = Color(0xFF______);
  static const Color secondaryContainer = Color(0xFF______);
  static const Color onSecondaryContainer = Color(0xFF______);

  // Tertiary
  static const Color tertiary = Color(0xFF______);
  static const Color onTertiary = Color(0xFF______);
  static const Color tertiaryContainer = Color(0xFF______);
  static const Color onTertiaryContainer = Color(0xFF______);

  // Error
  static const Color error = Color(0xFF______);
  static const Color onError = Color(0xFF______);
  static const Color errorContainer = Color(0xFF______);

  // Surface hierarchy
  static const Color surface = Color(0xFF______);
  static const Color surfaceDim = Color(0xFF______);
  static const Color surfaceBright = Color(0xFF______);
  static const Color surfaceContainerLowest = Color(0xFF______);
  static const Color surfaceContainerLow = Color(0xFF______);
  static const Color surfaceContainer = Color(0xFF______);
  static const Color surfaceContainerHigh = Color(0xFF______);
  static const Color surfaceContainerHighest = Color(0xFF______);
  static const Color onSurface = Color(0xFF______);
  static const Color onSurfaceVariant = Color(0xFF______);

  // Background
  static const Color background = Color(0xFF______);
  static const Color onBackground = Color(0xFF______);

  // Outline
  static const Color outline = Color(0xFF______);
  static const Color outlineVariant = Color(0xFF______);

  // Inverse
  static const Color inverseSurface = Color(0xFF______);
  static const Color inverseOnSurface = Color(0xFF______);
  static const Color inversePrimary = Color(0xFF______);

  // Misc
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color surfaceTint = Color(0xFF______);
}
```

For `ds_typography.dart`, update font families to match Stitch design:
- Headline font: from Stitch `headlineFont`
- Body font: from Stitch `bodyFont`
- Label font: from Stitch `labelFont`
- Ensure fonts are added to `pubspec.yaml` if using Google Fonts or asset fonts

For `ds_radius.dart`, `ds_spacing.dart`, `ds_shadows.dart` — update only if the Stitch design uses values that differ significantly from current tokens.

For `ds_theme.dart`, ensure `ColorScheme` uses the updated `DsColors` tokens. Build a complete `ColorScheme`:

```dart
static ThemeData light() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: DsColors.primary,
      onPrimary: DsColors.onPrimary,
      primaryContainer: DsColors.primaryContainer,
      onPrimaryContainer: DsColors.onPrimaryContainer,
      secondary: DsColors.secondary,
      onSecondary: DsColors.onSecondary,
      secondaryContainer: DsColors.secondaryContainer,
      onSecondaryContainer: DsColors.onSecondaryContainer,
      tertiary: DsColors.tertiary,
      onTertiary: DsColors.onTertiary,
      tertiaryContainer: DsColors.tertiaryContainer,
      onTertiaryContainer: DsColors.onTertiaryContainer,
      error: DsColors.error,
      onError: DsColors.onError,
      errorContainer: DsColors.errorContainer,
      surface: DsColors.surface,
      onSurface: DsColors.onSurface,
      onSurfaceVariant: DsColors.onSurfaceVariant,
      outline: DsColors.outline,
      outlineVariant: DsColors.outlineVariant,
      shadow: DsColors.shadow,
      scrim: DsColors.scrim,
      inverseSurface: DsColors.inverseSurface,
      onInverseSurface: DsColors.inverseOnSurface,
      inversePrimary: DsColors.inversePrimary,
      surfaceTint: DsColors.surfaceTint,
    ),
    textTheme: DsTypography.textTheme,
    // ... rest of theme config
  );
}
```

**Important:** Only update tokens that are actually different. Do not modify tokens that already match.

### Step 4 — Plan the screen structure

Analyze the HTML structure and plan:

1. **Feature name** (`snake_case`) — derive from screen title
2. **Screen sections** — identify major visual sections
3. **Components to extract** — reusable sub-widgets for `components/` folder
4. **Mock data needed** — what data to hardcode
5. **Navigation** — what routes/navigation this screen needs

Present the plan to the user and ask for confirmation before generating code.

### Step 5 — Generate Flutter code

Generate files following the project's conventions strictly:

#### 5a. Screen Arguments (if screen receives parameters)

```
features/{feature_name}/models/{feature_name}_arguments.dart
```

- `@freezed` class with only ID fields (never full entities)

#### 5b. UiState + Events

```
features/{feature_name}/models/{feature_name}_ui_state.dart
```

- `@freezed` UiState with `AsyncValue` for async data fields
- Wrap `List<T>` in a dedicated Freezed data class
- `sealed class` for Events
- Use mock data as default values where appropriate

#### 5c. ViewModel

```
features/{feature_name}/{feature_name}_view_model.dart
```

- `Notifier<XxxUiState>` — never `AsyncNotifier`
- Initialize with mock data in `build()` method
- Add `// TODO: Replace mock data with real API call` comments
- Include `consumeEvent()` method

#### 5d. Screen widget

```
features/{feature_name}/{feature_name}_screen.dart
```

- `ConsumerStatefulWidget`
- Use `ref.listen` for events, `ref.watch` for state
- Use `.select()` in sub-widgets
- Use design system tokens (`DsColors`, `DsSpacing`, `DsRadius`, etc.) — never hardcode values
- Use `Theme.of(context).textTheme` for text styles
- Use `Theme.of(context).colorScheme` for colors from theme
- Use `const` constructors wherever possible
- Extract sub-widgets into `components/` folder

#### 5e. Components

```
features/{feature_name}/components/{component_name}.dart
```

- Extract reusable sections as `StatelessWidget` or `ConsumerWidget`
- Accept only primitive inputs or domain entities
- Use `const` constructors

#### 5f. Mock data file

```
features/{feature_name}/models/{feature_name}_mock_data.dart
```

- Create a dedicated file with mock data constants
- Use realistic Vietnamese text content matching the Stitch design
- Mark with `// TODO: Remove when API integration is complete`

### Step 6 — Design system components (if needed)

If the screen uses UI patterns not yet in `lib/design_system/components/`, create new design system components:

- Place in `lib/design_system/components/`
- Follow naming: `ds_{component_name}.dart`
- Accept only primitive inputs (`String`, `VoidCallback`, `Color`, etc.)
- Add export to `lib/design_system/design_system.dart`
- Use design tokens internally

### Step 7 — Run code generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 8 — Summary

After generating all files:
- Show the complete file tree of created/modified files
- List any new dependencies needed in `pubspec.yaml`
- List any new fonts to add
- Note any design system tokens that were updated
- List TODO items for future API integration
- Remind about running `flutter analyze` to check for issues

## Key Rules

### Architecture
- ViewModel is `Notifier<XxxUiState>` — never `AsyncNotifier`
- UiState is `@freezed` — never `bool isLoading`
- Never `AsyncValue<List<T>>` — wrap in a Freezed data class
- ViewModel imports only from `domain/providers/` — never from `data/`
- Pass only IDs in Arguments — never full entities
- Extract sub-widgets into `components/` — avoid `_buildXxx()` methods

### Design System Usage
- Always use `DsColors`, `DsSpacing`, `DsRadius`, `DsShadows`, `DsDurations` tokens
- Never hardcode color hex values in screen code
- Use `Theme.of(context).colorScheme` and `Theme.of(context).textTheme`
- For colors not in the theme (e.g., custom gradients), reference `DsColors` directly
- Follow the "No-Line" rule: no 1px borders for sectioning, use background color shifts
- Use glassmorphism effects where the Stitch design shows them

### Mock Data
- Use realistic data matching the Vietnamese content from Stitch
- Wrap mock data in a dedicated file, not inline in the ViewModel
- Mark all mock data with `// TODO: Remove when API integration is complete`
- For images, use placeholder asset paths or `https://picsum.photos/` URLs

### Fonts
- Headline: Plus Jakarta Sans (from Stitch design)
- Body/Label: Manrope (from Stitch design)
- Ensure Google Fonts package is added or font assets are bundled
