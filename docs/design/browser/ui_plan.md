# Browser Screen — UI Implementation Plan

**Design source:** `docs/design/browser/screen.png` + `docs/design/browser/code.html`
**Data classification:** All data is **static (mock)**. Labels are **static (l10n)**.
**Note:** Bottom navigation bar already exists in app — not part of this screen.

---

## 1. Screen Overview

Browse/Discover screen for the meditation app. Allows users to search meditations, browse trending items, filter by tab (Chủ đề / Cảm xúc), and scroll through multiple topic sections (each with a horizontal card carousel). The route is `/browse`, already wired in `StatefulShellRoute`.

---

## 2. Visual Hierarchy (top → bottom)

| # | Element | Type | Position |
|---|---------|------|----------|
| 1 | Search bar: rounded pill input with search icon | Input | Scrollable |
| 2 | "Xu hướng" section header + "XEM TẤT CẢ" link | Header + action | Scrollable |
| 3 | Trending cards: horizontal scroll, large cards (70% width, 4:5 aspect) with image, glass overlay, badge, title, duration, author | Card list | Scrollable |
| 4 | Tabs: "Chủ đề" (active) / "Cảm xúc" (inactive) | Tab bar | Scrollable |
| 5 | Topic/Mood section × N: section header + "XEM TẤT CẢ" + horizontal scroll of small cards (40% width, 4:5 aspect) | Repeating section | Scrollable |

**Both tabs share the same repeating section pattern:**
- **Tab "Chủ đề"**: sections grouped by topic (e.g. "Tiếng mưa & bão", "Nhạc thiền định", ...)
- **Tab "Cảm xúc"**: sections grouped by mood (e.g. "Bình yên", "Tập trung", ...)

Each section has the same layout: `BrowseSectionHeader` + `BrowseContentSection`. The data source differs per tab but the widget structure is identical. Switching tabs swaps the list of `BrowseTopicSection` items displayed.

---

## 3. Design Tokens Mapping

### 3.1 Typography

| Element | Design | textTheme | Override |
|---------|--------|-----------|----------|
| Search placeholder | 16px/Manrope | `bodyLarge` | `color: DsColors.outlineVariant` |
| Section title "Xu hướng" | 24px/bold/PlusJakartaSans | `headlineSmall` | `letterSpacing: 0.8` |
| "XEM TẤT CẢ" link | 14px/semibold/Manrope | `labelLarge` | `color: DsColors.primary, letterSpacing: 1.5` |
| Trending badge | 10px/bold/Manrope, uppercase | `labelSmall` | `fontSize: 10, letterSpacing: 3.0` |
| Trending title | 24px/bold/PlusJakartaSans | `headlineSmall` | `color: Colors.white` |
| Trending duration/author | 14px/medium/Manrope | `bodyMedium` | `color: white.withAlpha(0.90)` |
| Tab active | 16px/semibold/PlusJakartaSans | `titleMedium` | `fontWeight: w600, color: DsColors.primary` |
| Tab inactive | 16px/medium/PlusJakartaSans | `titleMedium` | `fontWeight: w500, color: DsColors.onSurfaceVariant.withAlpha(0.60)` |
| Small section title | 20px/bold/PlusJakartaSans | `titleLarge` | `fontSize: 20, letterSpacing: 0.8` |
| Small card badge | 8px/bold/Manrope, uppercase | `labelSmall` | `fontSize: 8, letterSpacing: 1.5` |
| Small card title | 16px/bold/PlusJakartaSans | `titleMedium` | `fontWeight: w700, color: Colors.white` |
| Small card duration/author | 10px/medium/Manrope | `labelSmall` | `fontSize: 10, color: white.withAlpha(0.90)` |
| Category card title | 18px/bold/PlusJakartaSans | `titleMedium` | `fontSize: 18, fontWeight: w700, color: Colors.white` |

### 3.2 Colors

| Usage | Design Hex | Token | Notes |
|-------|-----------|-------|-------|
| Background | #EFFCF9 | `DsColors.surface` | Close enough |
| Search bg | #FFFFFF | `DsColors.surfaceContainerLowest` | |
| Search border | primary/10 | `DsColors.primary.withAlpha(0.10)` | |
| Search shadow | primary/5 | `DsColors.primary.withAlpha(0.05)` | |
| Glass card bg | rgba(255,255,255,0.4) | `Colors.white.withAlpha(0.40)` | |
| Glass card border | rgba(255,255,255,0.2) | `Colors.white.withAlpha(0.20)` | |
| Card dark overlay | gradient black/90 → transparent | Gradient | |
| Badge text (trending) | primary-fixed #89F5E7 | `DsColors.secondary` | Closest token |
| Tab indicator | primary | `DsColors.primary` | 2px bottom line |
| Tab border | outline-variant/15 | `DsColors.outlineVariant.withAlpha(0.15)` | |
| Category gradient | #0D9488 → #CCFBF1 | `DsColors.primary → DsColors.primaryContainer` | `liquid-teal-gradient` |
| Category bg 2 (tertiary) | tertiary-container | `DsColors.tertiaryContainer` | |
| Category bg 3 (secondary) | secondary | `DsColors.secondary` | |

### 3.3 Spacing

| Usage | Design | Token |
|-------|--------|-------|
| Screen horizontal padding | 24px | `DsSpacing.lg` (24) |
| Section gap | 40px | `DsSpacing.xxl` (48) — close |
| Section title to cards | 24px | `DsSpacing.lg` (24) |
| Trending card gap | 24px | `DsSpacing.lg` (24) |
| Small card gap | 16px | `DsSpacing.md` (16) |
| Search to first section | 40px | `DsSpacing.xxl` (48) — close |
| Tab to section | 48px | `DsSpacing.xxl` (48) |
| Glass card padding (large) | 32px | `DsSpacing.xl` (32) |
| Glass card padding (small) | 20px | 20 (between md and lg) |
| Search input padding vertical | 20px | 20 |
| Search input padding left | 56px (icon space) | 56 |

### 3.4 Radius

| Usage | Design | Token |
|-------|--------|-------|
| Search bar | 24px | `DsRadius.xl` (24) |
| Trending card | 32px | — (hardcode 32) |
| Glass overlay (trending) | top 32px | — (hardcode 32) |
| Small/category card | 24px | `DsRadius.xl` (24) |
| Glass overlay (small) | top 24px | `DsRadius.xl` (24) |
| Tab indicator | full | `DsRadius.full` |

---

## 4. Data Source Classification

| Data Item | Source | Notes |
|-----------|--------|-------|
| Search placeholder "Tìm bài thiền..." | Static (l10n) | |
| "Xu hướng" title | Static (l10n) | |
| "XEM TẤT CẢ" button | Static (l10n) | |
| Trending card data (image, badge, title, duration, author) | Static (mock) | Will be API later |
| Tab labels "Chủ đề", "Cảm xúc" | Static (l10n) | |
| Topic sections (tab "Chủ đề": title + list of cards per topic) | Static (mock) | Will be API later. E.g. "Tiếng mưa & bão", "Nhạc thiền định" |
| Mood sections (tab "Cảm xúc": title + list of cards per mood) | Static (mock) | Will be API later. E.g. "Bình yên", "Tập trung" |

---

## 5. Localization Keys

### 5.1 New Keys

| Key | EN | VI |
|-----|----|----|
| `browser_searchHint` | `Search meditations...` | `Tìm bài thiền...` |
| `browser_trending` | `Trending` | `Xu hướng` |
| `browser_viewAll` | `VIEW ALL` | `XEM TẤT CẢ` |
| `browser_tabTopics` | `Topics` | `Chủ đề` |
| `browser_tabMoods` | `Moods` | `Cảm xúc` |

---

## 6. Architecture Plan

### 6.1 File Structure

```
lib/features/browse/
  ├── browse_screen.dart                        # ConsumerStatefulWidget
  ├── browse_view_model.dart                    # @riverpod Notifier<BrowseUiState>
  ├── models/
  │   ├── browse_ui_state.dart                  # @freezed UiState + Events
  │   └── browse_mock_data.dart                 # Mock data for all sections
  └── components/
      ├── browse_search_bar.dart                # Search input
      ├── browse_section_header.dart            # Reusable section title + "XEM TẤT CẢ"
      ├── browse_trending_card.dart             # Large card (70% width)
      ├── browse_trending_section.dart          # Horizontal scroll of trending cards
      ├── browse_tab_bar.dart                   # Chủ đề / Cảm xúc tabs
      ├── browse_content_card.dart              # Small card (40% width)
      └── browse_content_section.dart           # Horizontal scroll of content cards — reused for each topic
```

### 6.2 UiState Design

```dart
@freezed
class BrowseUiState with _$BrowseUiState {
  const factory BrowseUiState({
    @Default(0) int selectedTabIndex,
    @Default('') String searchQuery,
    BrowseEvent? event,
  }) = _BrowseUiState;
}

sealed class BrowseEvent {
  const BrowseEvent();
}
```

### 6.3 Mock Data Models

```dart
class BrowseMeditationItem {
  const BrowseMeditationItem({
    required this.title,
    required this.duration,
    required this.author,
    required this.badge,
    required this.imageAsset,
  });

  final String title;
  final String duration;
  final String author;
  final String badge;
  final String imageAsset;
}

/// A section containing a title and a list of meditation items.
/// Used for both topic sections (tab "Chủ đề") and mood sections (tab "Cảm xúc").
class BrowseSection {
  const BrowseSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<BrowseMeditationItem> items;
}
```

**Mock data file** (`browse_mock_data.dart`) should define:
- `mockTrendingItems` — `List<BrowseMeditationItem>` (2-3 items)
- `mockTopicSections` — `List<BrowseSection>` (2-3 topics, each with 3 items)
- `mockMoodSections` — `List<BrowseSection>` (2-3 moods, each with 3 items)

The ViewModel selects `mockTopicSections` or `mockMoodSections` based on `selectedTabIndex`.

### 6.4 ViewModel Methods

| Method | Trigger | Action |
|--------|---------|--------|
| `build()` | Init | Returns `BrowseUiState()` |
| `onTabChanged(int index)` | Tap tab | `copyWith(selectedTabIndex: index)` |
| `onSearchChanged(String query)` | Type in search | `copyWith(searchQuery: query)` |
| `consumeEvent()` | After event | `copyWith(event: null)` |

---

## 7. Widget Decomposition

### 7.1 Component Tree

```
BrowseScreen (ConsumerStatefulWidget)
  └── Scaffold
      └── SingleChildScrollView
          └── Column
              ├── SizedBox (top padding for safe area)
              ├── BrowseSearchBar (StatelessWidget)
              ├── BrowseSectionHeader ("Xu hướng" + "XEM TẤT CẢ")
              ├── BrowseTrendingSection (StatelessWidget)
              │   └── ListView.builder → BrowseTrendingCard × N
              ├── BrowseTabBar (ConsumerWidget — watches selectedTabIndex)
              └── for each section in currentSections (topics or moods based on tab):
                  ├── BrowseSectionHeader (section.title + "XEM TẤT CẢ")
                  └── BrowseContentSection (items: section.items)
                      └── ListView.builder → BrowseContentCard × N
```

### 7.2 Component Details

| Component | Type | File |
|-----------|------|------|
| `BrowseScreen` | `ConsumerStatefulWidget` | `browse_screen.dart` |
| `BrowseSearchBar` | `StatelessWidget` | `components/browse_search_bar.dart` |
| `BrowseSectionHeader` | `StatelessWidget` | `components/browse_section_header.dart` |
| `BrowseTrendingCard` | `StatelessWidget` | `components/browse_trending_card.dart` |
| `BrowseTrendingSection` | `StatelessWidget` | `components/browse_trending_section.dart` |
| `BrowseTabBar` | `ConsumerWidget` | `components/browse_tab_bar.dart` |
| `BrowseContentCard` | `StatelessWidget` | `components/browse_content_card.dart` |
| `BrowseContentSection` | `StatelessWidget` | `components/browse_content_section.dart` |

### 7.3 Key Component Specifications

#### BrowseSearchBar
- Full width, rounded pill (radius 24)
- White bg, border `primary/10`, shadow `primary/5` xl
- Left: search icon `Icons.search` in `primary/60`
- Placeholder: "Tìm bài thiền..." in `outlineVariant`
- Focus: ring-4 `primary/10`, border `primary/40`

#### BrowseSectionHeader
- Reusable: takes `title` (String) and optional `onViewAll` callback
- Row: title left (headlineSmall or titleLarge based on size param), "XEM TẤT CẢ" right (primary, semibold)
- If `onViewAll` is null, don't show the link

#### BrowseTrendingCard
- `min-width: 70%` of screen, aspect 4:5, radius 32
- Stack: full-bleed image + dark gradient overlay (bottom→top: black/90→transparent) + glass card at bottom
- Glass card: `white/40` bg, blur 12, border `white/20`, radius top-32
- Content: badge text (uppercase, 10px, primary-fixed color), title (24px/bold, white), duration + dot + author row

#### BrowseContentCard (shared for "Tiếng mưa & bão" and similar sections)
- `min-width: 40%` of screen, aspect 4:5, radius 24
- Same structure as trending but smaller: smaller glass card padding (20px), smaller text
- Badge 8px, title 16px/bold, duration 10px

#### BrowseTabBar
- Full width, 2 equal tabs with bottom border
- Active: primary color text, 2px bottom indicator
- Inactive: onSurfaceVariant/60 text
- Border bottom: outlineVariant/15

---

## 8. Design System Token Updates

### 8.1 No New Color Tokens Needed

All colors map to existing tokens or are computed with `withAlpha()`.

### 8.2 No New Components Needed

All UI built with feature-specific components in `features/browse/components/`.

---

## 9. Interactive Elements

| Element | Type | States | Behavior |
|---------|------|--------|----------|
| Search input | TextInput | default / focused | `onSearchChanged(query)` |
| "XEM TẤT CẢ" link | Button | default | No-op for now (TODO) |
| Tab (Chủ đề/Cảm xúc) | Tab | active / inactive | `onTabChanged(index)` |
| Trending card | Tappable | default | No-op for now (TODO) |
| Content card | Tappable | default | No-op for now (TODO) |

---

## 10. Layout Notes

- **Scroll:** Entire screen scrolls (SingleChildScrollView). No fixed header.
- **SafeArea:** Top padding via `context.viewPadding.top`
- **Horizontal scrolls:** Trending + content sections use horizontal `ListView.builder` with `clipBehavior: Clip.none` for shadow visibility
- **Card sizing:** Use `SizedBox(width: screenWidth * 0.7)` for trending, `SizedBox(width: screenWidth * 0.4)` for content
- **Topic sections:** Rendered via `for (final topic in mockTopicSections)` inside the Column — generates N sections vertically
- **Bottom nav:** Already exists via `AppScaffold` — this screen renders inside the shell

---

## 11. Implementation Checklist

```
1. [ ] Create UiState + Events (`features/browse/models/browse_ui_state.dart`)
2. [ ] Run build_runner
3. [ ] Create ViewModel (`features/browse/browse_view_model.dart`)
4. [ ] Run build_runner
5. [ ] Add l10n keys to `app_en.arb` and `app_vi.arb`
6. [ ] Run l10n generation: `flutter gen-l10n`
7. [ ] Create mock data file (`features/browse/models/browse_mock_data.dart`)
8. [ ] Create BrowseSearchBar component
9. [ ] Create BrowseSectionHeader component
10. [ ] Create BrowseTrendingCard component
11. [ ] Create BrowseTrendingSection component
12. [ ] Create BrowseTabBar component
13. [ ] Create BrowseContentCard component
14. [ ] Create BrowseContentSection component
15. [ ] Replace placeholder BrowseScreen with full implementation
17. [ ] Run analyzer: `flutter analyze`
18. [ ] Verify against design screenshot
```

---

## 12. Compliance Matrix

### UiState (§3)

| Rule | How Satisfied |
|------|---------------|
| §3.1 `@freezed`, synchronous | `BrowseUiState` is `@freezed`, ViewModel is `Notifier<BrowseUiState>` |
| §3.2 AsyncValue | No async fields needed (all static/mock) |
| §3.5 Event pattern | `sealed class BrowseEvent`, `consumeEvent()` |

### ViewModel (§2)

| Rule | How Satisfied |
|------|---------------|
| §2.1 Notifier, not AsyncNotifier | Extends `_$BrowseViewModel` |
| §13.1 No mutable fields | All state in `BrowseUiState` |

### Widgets (§12)

| Rule | How Satisfied |
|------|---------------|
| §12.3 Typography via textTheme | All text uses `context.textTheme.*` |
| §12.5 const, .select() | `BrowseTabBar` uses `.select((s) => s.selectedTabIndex)` |
| §12.6 components/ subfolder | All sub-widgets in `components/` |
| §5.3 Use context extensions | `context.textTheme`, `context.colorScheme` |
