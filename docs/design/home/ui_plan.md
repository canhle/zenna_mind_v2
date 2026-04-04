# Home Screen — UI Implementation Plan

**Design source:** `docs/design/home/screen.png` + `docs/design/home/code.html`
**Data classification:** All UI text is **static (l10n)**. No API calls for this screen.

---

## 1. Screen Overview

Home screen of the meditation app. Shows a greeting, mood selector, daily meditation hero card, continue listening card, daily streak card, and an inspirational quote. Bottom navigation bar is shared across tabs.

---

## 2. Visual Hierarchy (top → bottom)

| # | Element | Type | Position |
|---|---------|------|----------|
| 1 | App bar: spa icon + "DIGITAL SANCTUARY" + notification + avatar | Header | Fixed top |
| 2 | Greeting: "Chào buổi sáng, Canh 🌤️" | Text | Scrollable |
| 3 | Subtitle: "Hít một hơi thật sâu..." | Text | Scrollable |
| 4 | Mood label: "BẠN CẢM THẤY THẾ NÀO?" | Label | Scrollable |
| 5 | Mood selector: 5 emoji circles (Vui, Lo lắng, Mệt mỏi, Căng thẳng, Bình yên) | Horizontal list | Scrollable |
| 6 | Hero card: teal gradient bg + image overlay + "Bài tập hôm nay" + title + "Bắt đầu" button + duration | Card | Scrollable |
| 7 | "Tiếp tục nghe" card: icon + title + progress bar + time | Card | Scrollable |
| 8 | "Chuỗi hằng ngày" card: streak count + fire icon + week dots | Card | Scrollable |
| 9 | Quote: italic text, centered, 60% opacity | Text | Scrollable |
| 10 | Bottom nav: Home, Browse, Favorites, Settings | Nav bar | Fixed bottom |

---

## 3. Design Tokens Mapping

### 3.1 Typography

| Element | Design | textTheme | Override |
|---------|--------|-----------|----------|
| App bar title | 14px/bold/PlusJakartaSans, uppercase, tracking-widest | `labelLarge` | `letterSpacing: 3.0`, uppercase |
| Greeting | 36px/bold/PlusJakartaSans | `headlineLarge` | — |
| Greeting subtitle | 18px/light/Manrope | `bodyLarge` | `fontWeight: w300` |
| Mood section label | 12px/semibold/Manrope, uppercase | `labelSmall` | `fontWeight: w600, letterSpacing: 3.0`, uppercase |
| Mood emoji label | 12px/medium/Manrope | `labelSmall` | `fontWeight: w500` |
| Hero card label | 12px/Manrope, uppercase | `labelSmall` | `letterSpacing: 4.0`, `color: onPrimary.withAlpha(0.80)` |
| Hero card title | 30px/bold/PlusJakartaSans | `headlineMedium` | `color: DsColors.onPrimary` |
| Hero button text | 18px/bold | `labelLarge` | `fontSize: 18` |
| Hero duration | 12px/Manrope | `labelSmall` | `color: onPrimary.withAlpha(0.60)` |
| Continue title | 16px/semibold/PlusJakartaSans | `titleMedium` | `fontWeight: w600` |
| Continue track name | 14px/semibold/Manrope | `bodyMedium` | `fontWeight: w600` |
| Continue time | 10px/Manrope, uppercase | `labelSmall` | `fontSize: 10` |
| Streak title | 16px/semibold/PlusJakartaSans | `titleMedium` | `fontWeight: w600` |
| Streak subtitle | 12px/Manrope | `labelSmall` | — |
| Streak "Tuần này" | 10px/bold/Manrope, uppercase | `labelSmall` | `fontSize: 10, fontWeight: w700` |
| Quote | 14px/Manrope, italic | `bodyMedium` | `fontStyle: italic, opacity: 0.60` |
| Bottom nav label | 10px/light/Manrope | `labelSmall` | `fontSize: 10, fontWeight: w300` |

### 3.2 Colors

| Usage | Design Hex | Token | Notes |
|-------|-----------|-------|-------|
| Background | #F5FAF8 | `DsColors.surface` | ⚠️ Design uses #F5FAF8, current `surface` is #F0FDFA — minor diff, use as-is |
| Primary | #27A08E | — | ⚠️ Design uses #27A08E, current `primary` is #0D9488 — different hue. **Keep existing #0D9488** |
| On surface | #171D1C | `DsColors.onSurface` | Current #0F172A is close enough |
| On surface variant | #3F4947 | `DsColors.onSurfaceVariant` | Current #475569 — close enough |
| Primary container | #CEF7F0 | `DsColors.primaryContainer` | Current #CCFBF1 — matches |
| Surface container lowest | #FFFFFF | `DsColors.surfaceContainerLowest` | Matches |
| Surface container high | #E4EAE8 | `DsColors.surfaceContainerHigh` | Current #E2E8F0 — close enough |
| Surface container low | #EFF5F3 | `DsColors.surfaceContainerLow` | Current #F8FAFC — close enough |
| Surface container | #E9EFED | `DsColors.surfaceContainer` | Current #F1F5F9 — close enough |
| Outline variant | #BFC9C6 | `DsColors.outlineVariant` | Current #CBD5E1 — close enough |
| Error container | #FFDAD6 | `DsColors.errorContainer` | Matches |
| Teal gradient | #27A08E → #62D0BD | — | **NEW:** Add `tealGradient` |
| Secondary container | #D6EBE8 | `DsColors.secondaryContainer` | Current #CCFBF1 — reuse |

### 3.3 Spacing

| Usage | Design | Token |
|-------|--------|-------|
| Screen horizontal padding | 24px | `DsSpacing.lg` (24) |
| Section vertical gap | 48px | `DsSpacing.xxl` (48) |
| App bar horizontal padding | 32px | `DsSpacing.xl` (32) |
| App bar vertical padding | 16px | `DsSpacing.md` (16) |
| Mood items gap | 16px | `DsSpacing.md` (16) |
| Card internal padding | 24px | `DsSpacing.lg` (24) |
| Greeting to subtitle | 8px | `DsSpacing.sm` (8) |
| Mood label to items | 24px | `DsSpacing.lg` (24) |
| Bento grid gap | 24px | `DsSpacing.lg` (24) |

### 3.4 Radius

| Usage | Design | Token |
|-------|--------|-------|
| Hero card | 16px | `DsRadius.lg` (16) |
| Continue/streak cards | 16px | `DsRadius.lg` (16) |
| Mood circle | full | `DsRadius.full` (999) |
| Hero button | full | `DsRadius.full` (999) |
| Bottom nav top corners | 32px | — (hardcoded or new token) |
| Streak dots | full | `DsRadius.full` |

---

## 4. Data Source Classification

| Data Item | Source | Notes |
|-----------|--------|-------|
| App name "DIGITAL SANCTUARY" | Static (l10n) | |
| Greeting "Chào buổi sáng/chiều/tối" | Static (l10n) | Computed from time of day |
| User name "Canh" | Static (l10n) placeholder | Will be dynamic later |
| Greeting emoji 🌤️ | Static (constant) | Computed from time of day |
| Subtitle "Hít một hơi thật sâu..." | Static (l10n) | |
| Mood label "BẠN CẢM THẤY THẾ NÀO?" | Static (l10n) | |
| Mood items (emoji + label) | Static (constant) | 5 fixed items |
| "Bài tập hôm nay" | Static (l10n) | |
| Hero title "10 phút xoa dịu căng thẳng" | Static (mock) | Will be API later |
| "Bắt đầu" button | Static (l10n) | |
| Duration "10 Phút • Sơ cấp" | Static (mock) | Will be API later |
| "Tiếp tục nghe" title | Static (l10n) | |
| Track name "Thư giãn 5 phút" | Static (mock) | Will be API later |
| Progress 3:00/5:00 | Static (mock) | Will be API later |
| "Chuỗi hằng ngày" title | Static (l10n) | |
| Streak "4 ngày liên tiếp" | Static (mock) | Will be API later |
| "Tuần này" label | Static (l10n) | |
| Week dots (7 dots) | Static (mock) | Will be API later |
| Quote text | Static (mock) | Will be API later |
| Bottom nav labels | Static (l10n) | |

---

## 5. Localization Keys

### 5.1 New Keys

| Key | EN | VI |
|-----|----|----|
| `home_appName` | `DIGITAL SANCTUARY` | `DIGITAL SANCTUARY` |
| `home_greetingMorning` | `Good morning, {name}` | `Chào buổi sáng, {name}` |
| `home_greetingAfternoon` | `Good afternoon, {name}` | `Chào buổi chiều, {name}` |
| `home_greetingEvening` | `Good evening, {name}` | `Chào buổi tối, {name}` |
| `home_greetingSubtitle` | `Take a deep breath...` | `Hít một hơi thật sâu...` |
| `home_moodLabel` | `HOW ARE YOU FEELING?` | `BẠN CẢM THẤY THẾ NÀO?` |
| `home_moodHappy` | `Happy` | `Vui` |
| `home_moodAnxious` | `Anxious` | `Lo lắng` |
| `home_moodTired` | `Tired` | `Mệt mỏi` |
| `home_moodStressed` | `Stressed` | `Căng thẳng` |
| `home_moodPeaceful` | `Peaceful` | `Bình yên` |
| `home_dailyLabel` | `TODAY'S EXERCISE` | `BÀI TẬP HÔM NAY` |
| `home_startButton` | `Start` | `Bắt đầu` |
| `home_continueTitle` | `Continue listening` | `Tiếp tục nghe` |
| `home_streakTitle` | `Daily streak` | `Chuỗi hằng ngày` |
| `home_streakWeek` | `THIS WEEK` | `TUẦN NÀY` |
| `home_navHome` | `Home` | `Home` |
| `home_navBrowse` | `Browse` | `Browse` |
| `home_navFavorites` | `Favorites` | `Favorites` |
| `home_navSettings` | `Settings` | `Settings` |

---

## 6. Architecture Plan

### 6.1 File Structure

```
lib/features/home/
  ├── home_screen.dart                          # ConsumerStatefulWidget
  ├── home_view_model.dart                      # @riverpod Notifier<HomeUiState>
  ├── models/
  │   └── home_ui_state.dart                    # @freezed UiState + Events
  └── components/
      ├── home_app_bar.dart                     # Custom app bar with logo + avatar
      ├── home_greeting_section.dart            # Greeting text + subtitle
      ├── home_mood_selector.dart               # Mood emoji row
      ├── home_mood_item.dart                   # Single mood circle + label
      ├── home_daily_card.dart                  # Hero meditation card
      ├── home_continue_card.dart               # Continue listening card
      ├── home_streak_card.dart                 # Daily streak card
      └── home_quote_section.dart               # Quote text
```

**Note:** Bottom navigation bar will be a shared component at the app shell level, not inside this feature.

### 6.2 UiState Design

```dart
@freezed
class HomeUiState with _$HomeUiState {
  const factory HomeUiState({
    @Default(null) MoodType? selectedMood,
    HomeEvent? event,
  }) = _HomeUiState;
}

enum MoodType { happy, anxious, tired, stressed, peaceful }

// Events
sealed class HomeEvent {
  const HomeEvent();
}

class HomeNavigateToMeditation extends HomeEvent {
  const HomeNavigateToMeditation();
}
```

### 6.3 ViewModel Methods

| Method | Trigger | Action |
|--------|---------|--------|
| `build()` | Init | Returns `HomeUiState()` |
| `onMoodSelected(MoodType)` | Tap mood | `copyWith(selectedMood: mood)` |
| `onStartTapped()` | Tap "Bắt đầu" | Emit `HomeNavigateToMeditation` |
| `consumeEvent()` | After event | `copyWith(event: null)` |

### 6.4 Greeting Logic

Time-of-day greeting computed in the widget (not ViewModel — it's a display concern):

```dart
String _getGreetingKey(int hour) {
  if (hour < 12) return l10n.home_greetingMorning('Canh');
  if (hour < 18) return l10n.home_greetingAfternoon('Canh');
  return l10n.home_greetingEvening('Canh');
}

String _getGreetingEmoji(int hour) {
  if (hour < 12) return '🌤️';
  if (hour < 18) return '☀️';
  return '🌙';
}
```

---

## 7. Widget Decomposition

### 7.1 Component Tree

```
AppScaffold (StatelessWidget — core/widgets/)
  └── Scaffold
      ├── body: StatefulNavigationShell (go_router)
      │   └── HomeScreen (ConsumerStatefulWidget) ← active tab
      │       └── Column
      │           ├── HomeAppBar (StatelessWidget)
      │           └── Expanded → SingleChildScrollView
      │               └── Column
      │                   ├── HomeGreetingSection (StatelessWidget)
      │                   ├── HomeMoodSelector (ConsumerWidget — watches selectedMood)
      │                   │   └── HomeMoodItem × 5 (StatelessWidget)
      │                   ├── HomeDailyCard (StatelessWidget)
      │                   ├── Row
      │                   │   ├── Expanded → HomeContinueCard (StatelessWidget)
      │                   │   └── Expanded → HomeStreakCard (StatelessWidget)
      │                   └── HomeQuoteSection (StatelessWidget)
      └── bottomNavigationBar: AppBottomNavBar (StatelessWidget — core/widgets/)
```

### 7.2 Component Details

| Component | Type | File |
|-----------|------|------|
| `HomeScreen` | `ConsumerStatefulWidget` | `home_screen.dart` |
| `HomeAppBar` | `StatelessWidget` | `components/home_app_bar.dart` |
| `HomeGreetingSection` | `StatelessWidget` | `components/home_greeting_section.dart` |
| `HomeMoodSelector` | `ConsumerWidget` | `components/home_mood_selector.dart` |
| `HomeMoodItem` | `StatelessWidget` | `components/home_mood_item.dart` |
| `HomeDailyCard` | `StatelessWidget` | `components/home_daily_card.dart` |
| `HomeContinueCard` | `StatelessWidget` | `components/home_continue_card.dart` |
| `HomeStreakCard` | `StatelessWidget` | `components/home_streak_card.dart` |
| `HomeQuoteSection` | `StatelessWidget` | `components/home_quote_section.dart` |

### 7.3 Key Component Specifications

#### HomeAppBar
- Glassmorphism: `white.withAlpha(0.80)` + `BackdropFilter(blur: 10)`
- Left: spa icon (Material `Icons.spa`) + app name uppercase with letter-spacing
- Right: notification icon (outlined) + circular avatar (32×32)
- Height: ~56px, horizontal padding 32px

#### HomeMoodSelector
- Horizontal row with 5 items, evenly spaced
- Each item: 64×64 circle + emoji (24px) + label below
- Selected item: `scale(1.1)` + `ring-4 ring-white shadow-sm` + bold primary text
- Unselected: various bg colors per mood (see §3.2)

#### HomeDailyCard
- Aspect ratio 4:5 on mobile
- Stack: teal gradient background + image with `BlendMode.overlay` + content overlay
- Content: top label + title centered, bottom "Bắt đầu" pill button + duration
- Button: white bg, primary text, rounded full, with play_arrow icon
- Shadow on button: `shadow-xl`

#### HomeContinueCard + HomeStreakCard
- Side by side in a Row (equal width)
- Continue: white bg, border `outlineVariant/10`, shadow-sm
  - Left: 56×56 teal gradient square with `graphic_eq` icon
  - Right: track name + linear progress bar (60%) + time label
- Streak: `surfaceContainerLow` bg, border `outlineVariant/5`
  - Top: title + subtitle | fire icon with `primary/10` circle bg
  - Bottom: 7 dots (teal or grey) + "TUẦN NÀY" label

#### Bottom Navigation Bar (shared — `core/widgets/app_bottom_nav_bar.dart`)

Shared widget across all main tabs. NOT part of the home feature — lives in `core/widgets/`.

**Visual specs (from design):**
- Fixed at bottom, full width
- Glassmorphism: `white.withAlpha(0.80)` + `BackdropFilter(blur: 20)`
- Top rounded corners: `BorderRadius.only(topLeft: 32, topRight: 32)`
- Shadow: `BoxShadow(color: DsColors.primary.withAlpha(0.06), blurRadius: 30, offset: Offset(0, -10))`
- Horizontal padding: 24px, top padding: 16px, bottom padding: `viewPadding.bottom + 8`

**4 tabs:**

| Index | Icon (Material Symbols) | Label | Route |
|-------|------------------------|-------|-------|
| 0 | `Icons.home_outlined` / `Icons.home` | Home | `/home` |
| 1 | `Icons.explore_outlined` / `Icons.explore` | Browse | `/browse` |
| 2 | `Icons.favorite_outline` / `Icons.favorite` | Favorites | `/favorites` |
| 3 | `Icons.settings_outlined` / `Icons.settings` | Settings | `/settings` |

**Active tab style:**
- `primaryContainer.withAlpha(0.40)` background pill (`BorderRadius.circular(20)`)
- Icon + label color: `DsColors.primary`
- Icon weight: 300, no fill

**Inactive tab style:**
- No background
- Icon + label color: `DsColors.outline`

**Label style:** `context.textTheme.labelSmall` with `fontSize: 10, fontWeight: w300`

**Router integration — `StatefulShellRoute`:**

```dart
// app_router.dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => AppScaffold(
    navigationShell: navigationShell,
  ),
  branches: [
    StatefulShellBranch(routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(path: '/browse', builder: (_, __) => const BrowseScreen()),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(path: '/favorites', builder: (_, __) => const FavoritesScreen()),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ]),
  ],
)
```

**AppScaffold (`core/widgets/app_scaffold.dart`):**

```dart
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
```

**File structure:**

```
lib/core/widgets/
  ├── app_scaffold.dart          # Scaffold + bottom nav wrapper
  └── app_bottom_nav_bar.dart    # Custom glassmorphism bottom nav
```

---

## 8. Design System Token Updates

### 8.1 New Colors Needed

| Color | Value | Proposed Token |
|-------|-------|----------------|
| Teal gradient end | #62D0BD | `DsColors.primaryLight` |

### 8.2 New Gradients

The `teal-gradient` (`#27A08E → #62D0BD` at 45°) is used in:
- Hero card background
- Continue card icon
- Streak active dots
- Progress bar fill

Propose: Use `DsColors.primary` → new `DsColors.primaryLight` for this gradient. Define as a reusable `LinearGradient` constant if needed.

### 8.3 No New Components Needed

All UI can be built with existing tokens + custom components in `features/home/components/`.

---

## 9. Interactive Elements

| Element | Type | States | Behavior |
|---------|------|--------|----------|
| Mood circle | Selectable | default / selected | `onMoodSelected(mood)` → highlight + scale |
| "Bắt đầu" button | Button | enabled | `onStartTapped()` → navigate to meditation |
| Notification icon | Button | enabled | No-op for now (TODO) |
| Avatar | Button | enabled | No-op for now (TODO) |
| Continue card | Tappable | enabled | No-op for now (TODO) |
| Bottom nav items | Tab | active / inactive | Navigate between tabs |

---

## 10. Layout Notes

- **Scroll:** Everything below the app bar scrolls (`SingleChildScrollView`)
- **App bar:** NOT a standard `AppBar` — it's a custom glassmorphism header
- **SafeArea:** Apply `top` padding to app bar. Bottom handled by bottom nav bar
- **Bottom nav:** Fixed at bottom with rounded top corners and glassmorphism. Shared across tabs — should be implemented as a `ShellRoute` in `app_router.dart`
- **Continue + Streak cards:** Side by side in a `Row` with `Expanded` children

---

## 11. Implementation Checklist

```
1. [ ] Add `DsColors.primaryLight` (#62D0BD) to `ds_colors.dart`
2. [ ] Create UiState + Events (`features/home/models/home_ui_state.dart`)
3. [ ] Run build_runner
4. [ ] Create ViewModel (`features/home/home_view_model.dart`)
5. [ ] Run build_runner
6. [ ] Add l10n keys to `app_en.arb` and `app_vi.arb`
7. [ ] Run l10n generation: `flutter gen-l10n`
8. [ ] Create AppBottomNavBar (`core/widgets/app_bottom_nav_bar.dart`)
9. [ ] Create AppScaffold (`core/widgets/app_scaffold.dart`)
10. [ ] Refactor `app_router.dart` to use `StatefulShellRoute` + `AppScaffold`
11. [ ] Create HomeAppBar component
12. [ ] Create HomeGreetingSection component
13. [ ] Create HomeMoodItem component
14. [ ] Create HomeMoodSelector component
15. [ ] Create HomeDailyCard component
16. [ ] Create HomeContinueCard component
17. [ ] Create HomeStreakCard component
18. [ ] Create HomeQuoteSection component
19. [ ] Create HomeScreen (assemble all components)
20. [ ] Create placeholder screens (Browse, Favorites, Settings)
21. [ ] Run analyzer: `flutter analyze`
22. [ ] Verify against design screenshot
```

---

## 12. Compliance Matrix

### UiState (§3)

| Rule | How Satisfied |
|------|---------------|
| §3.1 `@freezed`, synchronous | `HomeUiState` is `@freezed`, ViewModel is `Notifier<HomeUiState>` |
| §3.2 AsyncValue | No async fields needed (all static/mock) |
| §3.5 Event pattern | `sealed class HomeEvent`, `consumeEvent()` |

### ViewModel (§2)

| Rule | How Satisfied |
|------|---------------|
| §2.1 Notifier, not AsyncNotifier | Extends `_$HomeViewModel` |
| §13.1 No mutable fields | All state in `HomeUiState` |

### Widgets (§12)

| Rule | How Satisfied |
|------|---------------|
| §12.3 Typography via textTheme | All text uses `context.textTheme.*` |
| §12.5 const, .select() | `HomeMoodSelector` uses `.select((s) => s.selectedMood)` |
| §12.6 components/ subfolder | All sub-widgets in `components/` |
| §5.3 Use context extensions | `context.textTheme`, `context.colorScheme` |
