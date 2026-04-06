# UI Plan — Meditation Complete Screen

---

## STEP 1 — Design Extraction

### 1.1 Design Files

- **Screenshot:** `docs/design/meditation_complete/screen.png`
- **HTML/CSS:** `docs/design/meditation_complete/code.html`

### 1.2 Screen Overview

- **Screen name:** Meditation Complete (Hoàn thành bài thiền)
- **Purpose:** Shown after a user completes a meditation session. Celebrates the achievement, displays streak count, shows an inspirational quote, collects post-session mood, and provides navigation to the next meditation or home.
- **User flow:** Player screen → (session ends) → **Meditation Complete** → Browse / Home

### 1.3 Visual Hierarchy (top-to-bottom)

| # | Element | Type | Position |
|---|---------|------|----------|
| 1 | Soft background (`#bfe4d8`) with two decorative blobs | Background | Fixed, full-screen |
| 2 | Animated ring with checkmark icon | Animated graphic | Scrollable center |
| 3 | Floating dots around ring (5 dots) | Animated decorations | Absolute within ring |
| 4 | Title "Bạn đã hoàn thành bài thiền!" | Text (Lora serif) | Center |
| 5 | Streak badge "🔥 7 ngày liên tiếp" | Badge/Chip | Center |
| 6 | Inspirational quote + author | Text (Lora italic) | Center |
| 7 | "Bạn cảm thấy thế nào?" label | Text | Center |
| 8 | Mood selector row (4 mood buttons) | Interactive buttons | Center |
| 9 | Primary CTA "Khám phá bài tiếp theo" | Button | Bottom |
| 10 | Secondary CTA "Quay lại trang chủ" | Button | Bottom |

### 1.4 Design Tokens Mapping

#### Typography

| Element | Design Font/Size/Weight | Project TextStyle | Notes |
|---------|------------------------|-------------------|-------|
| Title | Lora / 24px / w400 | `context.textTheme.headlineSmall` (24px) | Need `copyWith(fontFamily: 'Lora', fontWeight: FontWeight.w400)` — see §1.4 note below |
| Streak text | DM Sans / 14px / w500 | `context.textTheme.titleSmall` (14px) | Manrope in project |
| Quote text | Lora / 15px / w300 / italic | `context.textTheme.bodyMedium` (14px) | Need `copyWith(fontFamily: 'Lora', fontStyle: FontStyle.italic, fontSize: 15)` |
| Quote author | DM Sans / 12px / w400 | `context.textTheme.labelSmall` (11px) | `copyWith(fontSize: 12)` |
| Mood label | DM Sans / 13px / w400 | `context.textTheme.bodySmall` (12px) | `copyWith(fontSize: 13)` |
| Mood button text | DM Sans / 11px / w400 | `context.textTheme.labelSmall` (11px) | |
| Mood emoji | 20px | Raw `TextStyle(fontSize: 20)` | Emoji, no font needed |
| CTA primary | DM Sans / 15px / w500 | `context.textTheme.titleSmall` (14px) | Use `DsButton` instead |
| CTA secondary | DM Sans / 15px / w400 | `context.textTheme.titleSmall` (14px) | Use `DsButton` secondary |

**Typography note:** The design uses **Lora** as the serif/heading font, while the project uses **Plus Jakarta Sans** for headlines and **Manrope** for body. Since this is a special celebration screen, we will use `GoogleFonts.lora()` for the title and quote text to match the design. Body font (DM Sans in design) maps to Manrope in the project.

#### Colors

| Usage | Design Color | Project Token | Match? | Notes |
|-------|-------------|---------------|--------|-------|
| Background | `#bfe4d8` | **NEW: `DsColors.completionBg`** | No | App-specific celebration bg |
| Blob overlay | `rgba(255,255,255,0.17)` | Inline `Colors.white.withOpacity(0.17)` | — | Decorative only |
| Main text | `#0a3d28` | **NEW: `DsColors.completionText`** | No | Deep green text for completion |
| Muted text | `rgba(10,60,40,0.58)` | Derived from `completionText` | — | `.withOpacity(0.58)` |
| Hint text | `rgba(10,60,40,0.40)` | Derived from `completionText` | — | `.withOpacity(0.40)` |
| Ring outer | `rgba(10,100,70,0.18)` | Inline | — | Animation ring |
| Ring mid | `rgba(10,100,70,0.12)` | Inline | — | Animation ring |
| Ring core | `rgba(255,255,255,0.55)` | Inline | — | Ring fill |
| Check icon bg | `#0d6e4a` | **NEW: `DsColors.completionAccent`** | No | Darker green accent |
| Badge bg | `rgba(255,255,255,0.55)` | Inline | — | Semi-transparent |
| Badge border | `rgba(10,100,60,0.20)` | Inline | — | Semi-transparent |
| Mood bg | `rgba(255,255,255,0.35)` | Inline | — | |
| Mood selected bg | `rgba(255,255,255,0.65)` | Inline | — | |
| Mood selected border | `rgba(10,100,60,0.35)` | Inline | — | |
| Primary CTA bg | `#0d6e4a` | `DsColors.completionAccent` | — | Reuse |
| Secondary CTA border | `rgba(10,100,60,0.25)` | Inline | — | |
| CTA text white | `#FFFFFF` | `DsColors.onPrimary` | Yes | |
| Secondary CTA text | `#0a3d28` | `DsColors.completionText` | — | |

### 1.5 Spacing & Layout

| Usage | Design Value | Project Token | Notes |
|-------|-------------|---------------|-------|
| Content horizontal padding | 30px | `DsSpacing.xl` (32) | Closest match |
| Content bottom padding | 32px | `DsSpacing.xl` (32) | |
| Ring bottom margin | 28px | `DsSpacing.lg` (24) + 4 = 28 | Use `const SizedBox(height: 28)` |
| Title bottom margin | 14px | ~`DsSpacing.md` (16) | Use 14 raw |
| Streak badge bottom margin | 18px | ~`DsSpacing.md` (16) | Use 18 raw |
| Quote author top margin | 8px | `DsSpacing.sm` (8) | |
| Mood section bottom margin | 22px | ~`DsSpacing.lg` (24) | Use 22 raw |
| Mood label bottom margin | 12px | `DsSpacing.md` (16) - 4 | Use `DsSpacing.md - DsSpacing.xs` = 12 |
| Mood row gap | 10px | ~`DsSpacing.sm` (8) | Use 10 raw |
| Mood button padding | 10px 12px | Custom | |
| Mood button internal gap | 5px | ~`DsSpacing.xs` (4) | Use 5 raw |
| Mood button min width | 60px | Custom constant | |
| Primary CTA bottom margin | 11px | ~`DsSpacing.sm` (8) | Use 11 raw |
| Badge padding | 7px 16px | Custom | |
| Badge gap | 7px | Custom | |
| Streak badge border-radius | 24px | `DsRadius.xl` (24) | |
| Mood button border-radius | 13px | ~`DsRadius.md` (12) | Use 13 raw |
| CTA border-radius | 16px | `DsRadius.lg` (16) | |
| Ring wrap size | 148x148 | Custom constant | |

**Scroll behavior:**
- Full screen is a single `Column` within a `Scaffold`
- The celebration section (`ring + title + badge + quote`) is centered using `Expanded` / flex
- Mood section and CTAs are pinned at the bottom (no scroll needed for standard screen heights)
- SafeArea: yes, at least bottom padding

**Overflow:** If screen is very small, the celebration section should be wrapped in a `SingleChildScrollView` to prevent overflow.

### 1.6 Interactive Elements

| Element | Type | States | Behavior | DS Component |
|---------|------|--------|----------|-------------|
| Mood buttons (4) | Toggle button group | default / selected | Single-select: tap selects one, deselects others | Custom (no existing DS match) |
| Primary CTA | Button | enabled | Navigate to browse/next meditation | `DsButton` primary |
| Secondary CTA | Button | enabled | Navigate to home | `DsButton` secondary |

**Note on DsButton:** The design CTA uses `#0d6e4a` (completionAccent) instead of the standard `DsColors.primary` (`#0D9488`). The DsButton uses a gradient from `primaryDim` to `primary`. For this screen, we should use custom-styled buttons to match the design's darker green. Alternatively, we can use DsButton if the slight color difference is acceptable. **NEEDS CONFIRMATION** from user on whether to use standard DsButton or custom-styled buttons.

### 1.7 Data Source Classification

| Data Item | Source | Notes |
|-----------|--------|-------|
| Title text ("Bạn đã hoàn thành bài thiền!") | Static (l10n) | |
| Streak count ("7 ngày liên tiếp") | Dynamic (API/local) | **NEEDS CONFIRMATION** — streak count from backend or local storage? |
| Inspirational quote text | Dynamic (mock) | Random from local list, could be API later |
| Quote author | Dynamic (mock) | Paired with quote |
| Mood label ("Bạn cảm thấy thế nào?") | Static (l10n) | |
| Mood options (emoji + label) | Static (l10n) | 4 fixed moods |
| Primary CTA text | Static (l10n) | |
| Secondary CTA text | Static (l10n) | |

---

## STEP 2 — Localization Keys

### 2.1 Existing Keys Check

- `home_streakCount`: `"{count} days in a row"` / `"{count} ngày liên tiếp"` — can reuse for streak badge

### 2.2 New Keys

| Key | EN | VI | Reuse? |
|-----|----|----|--------|
| `meditationComplete_title` | "You've completed\nthe meditation!" | "Bạn đã hoàn thành\nbài thiền!" | No |
| `meditationComplete_moodLabel` | "How are you feeling?" | "Bạn cảm thấy thế nào?" | No |
| `meditationComplete_moodPeaceful` | "Peaceful" | "Bình yên" | No (different from `home_moodPeaceful` — same EN but context-specific) |
| `meditationComplete_moodRefreshed` | "Refreshed" | "Sảng khoái" | No |
| `meditationComplete_moodRelaxed` | "Relaxed" | "Thư giãn" | No |
| `meditationComplete_moodHappier` | "Happier" | "Vui hơn" | No |
| `meditationComplete_nextCta` | "Explore the next session" | "Khám phá bài tiếp theo" | No |
| `meditationComplete_homeCta` | "Back to home" | "Quay lại trang chủ" | No |
| `meditationComplete_streakCount` | "🔥 {count} days in a row" | "🔥 {count} ngày liên tiếp" | No (includes fire emoji in badge) |

**Note:** Reuse `home_streakCount` is possible but the completion screen badge includes the 🔥 emoji. Better to create a dedicated key with the emoji baked in, or handle the emoji separately in code (preferred — keep emoji out of l10n).

**Decision:** Keep emoji in code, reuse `home_streakCount` for the text portion. Create `meditationComplete_streakCount` only if the format differs.

Revised approach: Use `home_streakCount` for streak text. Handle 🔥 emoji in widget code.

---

## STEP 3 — Architecture Plan

### 3.1 File Structure

```
lib/features/meditation_complete/
  ├── meditation_complete_screen.dart            # ConsumerStatefulWidget
  ├── meditation_complete_view_model.dart        # @riverpod Notifier<UiState>
  ├── models/
  │   ├── meditation_complete_ui_state.dart      # @freezed UiState + sealed Events
  │   ├── meditation_complete_arguments.dart     # @freezed Arguments (streakCount)
  │   └── meditation_complete_mock_data.dart     # Quotes list
  └── components/
      ├── completion_ring.dart                   # Animated ring with checkmark
      ├── completion_background.dart             # Background with blobs
      ├── streak_badge.dart                      # Streak badge chip
      ├── inspirational_quote.dart               # Quote + author
      └── mood_selector.dart                     # Mood button row
```

No domain/data layer needed — this is a UI-only screen with local mock data. Streak count will be passed as an argument.

### 3.2 UiState Design

```dart
@freezed
class MeditationCompleteUiState with _$MeditationCompleteUiState {
  const factory MeditationCompleteUiState({
    @Default(0) int streakCount,
    @Default('') String quoteText,
    @Default('') String quoteAuthor,
    String? selectedMoodId,
    MeditationCompleteEvent? event,
  }) = _MeditationCompleteUiState;
}
```

### 3.3 Events

```dart
sealed class MeditationCompleteEvent {
  const MeditationCompleteEvent();
}

class MeditationCompleteNavigateToBrowse extends MeditationCompleteEvent {
  const MeditationCompleteNavigateToBrowse();
}

class MeditationCompleteNavigateToHome extends MeditationCompleteEvent {
  const MeditationCompleteNavigateToHome();
}
```

### 3.4 Arguments

```dart
@freezed
class MeditationCompleteArguments with _$MeditationCompleteArguments {
  const factory MeditationCompleteArguments({
    @Default(0) int streakCount,
  }) = _MeditationCompleteArguments;
}
```

### 3.5 ViewModel Methods

| Method | Trigger | Action | State Update |
|--------|---------|--------|--------------|
| `build(args)` | Init | Returns initial UiState with random quote, streak from args | Sets `streakCount`, `quoteText`, `quoteAuthor` |
| `onMoodSelected(String moodId)` | Mood tap | Update selected mood | `copyWith(selectedMoodId: moodId)` |
| `onNextTapped()` | Primary CTA | Emit navigate event | `copyWith(event: NavigateToBrowse())` |
| `onHomeTapped()` | Secondary CTA | Emit navigate event | `copyWith(event: NavigateToHome())` |
| `consumeEvent()` | After event | Clears event | `copyWith(event: null)` |

No `ListenWithAutoClose` mixin needed — no data loading from providers.

### 3.6 Mock Data — Quotes

```dart
// meditation_complete_mock_data.dart
class MeditationQuote {
  const MeditationQuote({required this.text, required this.author});
  final String text;
  final String author;
}

const meditationQuotes = [
  MeditationQuote(text: 'Mỗi hơi thở là một khởi đầu mới.', author: 'Thích Nhất Hạnh'),
  MeditationQuote(text: 'Bình yên đến từ bên trong, đừng tìm kiếm nó bên ngoài.', author: 'Phật Thích Ca'),
  MeditationQuote(text: 'Hãy để tâm trí nghỉ ngơi, cơ thể sẽ tự chữa lành.', author: 'Lão Tử'),
  MeditationQuote(text: 'Khoảnh khắc hiện tại luôn là nơi bạn cần ở.', author: 'Eckhart Tolle'),
  MeditationQuote(text: 'Thiền không phải là thoát khỏi cuộc sống — mà là học cách sống trọn vẹn.', author: 'Jon Kabat-Zinn'),
];
```

**Note:** Quotes are currently hardcoded in Vietnamese. For l10n, these should eventually be moved to ARB files or fetched from API. **NEEDS CONFIRMATION** — should quotes be localized now or kept as Vietnamese-only mock data?

### 3.7 Mood Data

Mood options are defined as a static list in the screen/component:

| ID | Emoji | Label Key (l10n) |
|----|-------|-----------------|
| `peaceful` | 😌 | `meditationComplete_moodPeaceful` |
| `refreshed` | ✨ | `meditationComplete_moodRefreshed` |
| `relaxed` | 😴 | `meditationComplete_moodRelaxed` |
| `happier` | 🙂 | `meditationComplete_moodHappier` |

---

## STEP 4 — Widget Decomposition

### 4.1 Component Tree

```
MeditationCompleteScreen (ConsumerStatefulWidget)
  └── Scaffold (no AppBar)
      └── CompletionBackground (StatelessWidget)
          └── SafeArea
              └── Column
                  ├── Expanded
                  │   └── Center
                  │       └── Column (celebration)
                  │           ├── CompletionRing (StatelessWidget)
                  │           ├── Title text
                  │           ├── StreakBadge (StatelessWidget)
                  │           └── InspirationalQuote (StatelessWidget)
                  ├── MoodSelector (ConsumerWidget)
                  ├── DsButton (primary) — "Khám phá bài tiếp theo"
                  └── DsButton (secondary) — "Quay lại trang chủ"
```

### 4.2 Component Details

| Component | Type | Watches (via .select) | File |
|-----------|------|----------------------|------|
| `MeditationCompleteScreen` | `ConsumerStatefulWidget` | Full state (events) | `meditation_complete_screen.dart` |
| `CompletionBackground` | `StatelessWidget` | Nothing | `components/completion_background.dart` |
| `CompletionRing` | `StatelessWidget` | Nothing | `components/completion_ring.dart` |
| `StreakBadge` | `StatelessWidget` | Nothing (data passed via constructor) | `components/streak_badge.dart` |
| `InspirationalQuote` | `StatelessWidget` | Nothing (data passed via constructor) | `components/inspirational_quote.dart` |
| `MoodSelector` | `ConsumerWidget` | `s.selectedMoodId` | `components/mood_selector.dart` |

### 4.3 Reusable Components Check

| Need | Existing DS Component | Decision |
|------|----------------------|----------|
| Primary CTA | `DsButton` (primary, large, isExpanded) | **Use DsButton** — accept slight color difference, or customize |
| Secondary CTA | `DsButton` (secondary, large, isExpanded) | **Use DsButton** secondary variant |
| Badge/chip | `DsBadge` | Check if it supports custom bg/border — if not, custom widget |
| Animated ring | None | Custom widget |
| Mood selector | None | Custom widget |
| Background blobs | Similar to `WelcomeBackground` | Adapt pattern from welcome screen |

### 4.4 Animation Details

**CompletionRing animations:**
- **Ring outer:** pulsing scale (1.0 → 1.05), 3s infinite, ease-in-out
- **Ring mid:** same as outer, 0.4s delay
- **Checkmark icon:** pop-in scale (0 → 1), 0.6s, cubic-bezier spring, 0.1s delay
- **Floating dots (5):** vertical float (0 → -7px), 4s infinite, varying delays

Flutter implementation:
- Use `AnimationController` + `CurvedAnimation` for ring pulse
- Use a second controller for the pop-in (single-fire)
- Use `TweenAnimationBuilder` or additional controllers for floating dots
- Dispose all controllers in `dispose()`

---

## STEP 5 — Design System Token Updates

### 5.1 New Colors

| Color | Hex | Proposed Token Name | Reason |
|-------|-----|-------------------|--------|
| Completion background | `#bfe4d8` | `DsColors.completionBg` | Celebration screen bg, distinct from `surface` |
| Completion text | `#0a3d28` | `DsColors.completionText` | Deep green text, not in current palette |
| Completion accent | `#0d6e4a` | `DsColors.completionAccent` | Darker green for CTA and checkmark icon |

### 5.2 New Spacing / Radius / Shadows

No new tokens needed — design values are close enough to existing tokens or are screen-specific constants.

### 5.3 New Components

No new DS components proposed. The mood selector and ring are screen-specific and belong in `features/meditation_complete/components/`.

---

## STEP 6 — Implementation Checklist

```
1.  [ ] Add new color tokens to `lib/design_system/tokens/ds_colors.dart` (completionBg, completionText, completionAccent)
2.  [ ] Create UiState + Events (`features/meditation_complete/models/meditation_complete_ui_state.dart`)
3.  [ ] Create Arguments (`features/meditation_complete/models/meditation_complete_arguments.dart`)
4.  [ ] Create mock data file (`features/meditation_complete/models/meditation_complete_mock_data.dart`)
5.  [ ] Run build_runner: `dart run build_runner build --delete-conflicting-outputs`
6.  [ ] Create ViewModel (`features/meditation_complete/meditation_complete_view_model.dart`)
7.  [ ] Run build_runner again
8.  [ ] Add l10n keys to `app_en.arb` and `app_vi.arb`
9.  [ ] Run l10n generation: `flutter gen-l10n`
10. [ ] Create CompletionBackground (`features/meditation_complete/components/completion_background.dart`)
11. [ ] Create CompletionRing (`features/meditation_complete/components/completion_ring.dart`)
12. [ ] Create StreakBadge (`features/meditation_complete/components/streak_badge.dart`)
13. [ ] Create InspirationalQuote (`features/meditation_complete/components/inspirational_quote.dart`)
14. [ ] Create MoodSelector (`features/meditation_complete/components/mood_selector.dart`)
15. [ ] Create screen widget (`features/meditation_complete/meditation_complete_screen.dart`)
16. [ ] Add route to `app_router.dart` (path: `/meditation-complete`)
17. [ ] Run analyzer: `flutter analyze`
18. [ ] Verify against design screenshot (Step 7)
```

---

## STEP 7 — Post-Implementation Design Verification

### 7.1 Verification Checklist

| # | Check | Design Value | Code Value |
|---|-------|-------------|------------|
| 1 | Background color | `#bfe4d8` | `DsColors.completionBg` |
| 2 | Blob circles | `rgba(255,255,255,0.17)`, 320px & 200px | Positioned `Container` with `BoxDecoration` circle |
| 3 | Ring outer size | 148x148 | `SizedBox(width: 148, height: 148)` |
| 4 | Ring outer border | 1.5px, `rgba(10,100,70,0.18)` | `Border.all(width: 1.5, color: ...)` |
| 5 | Ring mid inset | 17px from outer | `Positioned.fill` with 17px margin |
| 6 | Ring core inset | 34px from outer | `Positioned.fill` with 34px margin |
| 7 | Checkmark icon bg | `#0d6e4a`, 46x46 circle | `Container` with `DsColors.completionAccent` |
| 8 | Checkmark SVG | White, 22x22, stroke-width 2.2 | `Icon(Icons.check, size: 22, color: white)` or custom painter |
| 9 | Title font | Lora / 24px / w400 / `#0a3d28` | `GoogleFonts.lora(fontSize: 24, fontWeight: w400, color: completionText)` |
| 10 | Title line-height | 1.35 | `height: 1.35` in TextStyle |
| 11 | Title bottom margin | 14px | `SizedBox(height: 14)` |
| 12 | Streak badge bg | `rgba(255,255,255,0.55)` | `Color(0x8CFFFFFF)` |
| 13 | Streak badge border | 1.5px, `rgba(10,100,60,0.20)` | `Border.all(width: 1.5, ...)` |
| 14 | Streak badge radius | 24px | `DsRadius.xl` (24) |
| 15 | Streak badge padding | 7px 16px | `EdgeInsets.symmetric(horizontal: 16, vertical: 7)` |
| 16 | Fire emoji | 18px | `TextStyle(fontSize: 18)` |
| 17 | Streak text | 14px / w500 | `context.textTheme.titleSmall` |
| 18 | Quote font | Lora / italic / 15px / w300 | `GoogleFonts.lora(...)` |
| 19 | Quote color | `rgba(10,60,40,0.58)` | `DsColors.completionText.withOpacity(0.58)` |
| 20 | Quote line-height | 1.7 | `height: 1.7` |
| 21 | Quote max-width | 260px | `ConstrainedBox(maxWidth: 260)` |
| 22 | Author font | 12px / w400 | `context.textTheme.labelSmall.copyWith(fontSize: 12)` |
| 23 | Author color | `rgba(10,60,40,0.40)` | `DsColors.completionText.withOpacity(0.40)` |
| 24 | Mood label | 13px / `rgba(10,60,40,0.40)` | `context.textTheme.bodySmall.copyWith(fontSize: 13)` |
| 25 | Mood button bg | `rgba(255,255,255,0.35)` | `Color(0x59FFFFFF)` |
| 26 | Mood button selected bg | `rgba(255,255,255,0.65)` | `Color(0xA6FFFFFF)` |
| 27 | Mood button selected border | `rgba(10,100,60,0.35)` | `Border.all(...)` |
| 28 | Mood button radius | 13px | `BorderRadius.circular(13)` |
| 29 | Mood button padding | 10px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 10)` |
| 30 | Mood button min-width | 60px | `ConstrainedBox(minWidth: 60)` |
| 31 | Mood emoji size | 20px | `TextStyle(fontSize: 20)` |
| 32 | Mood text size | 11px | `context.textTheme.labelSmall` |
| 33 | Content padding | 0 30px 32px | `EdgeInsets.only(left: 30, right: 30, bottom: 32)` → use 32 (`DsSpacing.xl`) |
| 34 | Primary CTA | full-width, 15px padding, 16px radius, `#0d6e4a` bg | `DsButton` primary or custom |
| 35 | Secondary CTA | full-width, 14px padding, 16px radius, 1.5px border | `DsButton` secondary or custom |
| 36 | CTA gap | 11px | `SizedBox(height: 11)` |

### 7.2 Scroll & Layout Verification

- No scrolling needed for standard screen sizes (700px+ height)
- SafeArea applied for bottom system insets
- Celebration section uses `Expanded` + `Center` for vertical centering
- Mood + CTAs anchored at bottom via column alignment

### 7.3 Interactive State Verification

- **Mood buttons:** Default state (semi-transparent bg, no border) / Selected state (brighter bg, green border)
- **CTAs:** Standard DsButton states (enabled/pressed)

---

## STEP 8 — Coding Convention Compliance Matrix

### UiState

| # | Rule | How Satisfied |
|---|------|---------------|
| §3.1 | `@freezed`, synchronous | `MeditationCompleteUiState` is `@freezed`, ViewModel is `Notifier` not `AsyncNotifier` |
| §3.5 | Event pattern | `sealed class MeditationCompleteEvent`, `consumeEvent()` in ViewModel |

### ViewModel

| # | Rule | How Satisfied |
|---|------|---------------|
| §2.1 | `Notifier<UiState>`, not `AsyncNotifier` | `extends _$MeditationCompleteViewModel` with `@riverpod` |
| §13.1 | No mutable instance fields | All state in `@freezed` UiState |

### Widgets

| # | Rule | How Satisfied |
|---|------|---------------|
| §1 | UI reads only from UiState | All components receive data from UiState via screen or `.select()` |
| §12.5 | `const`, `.select()`, `StatelessWidget` | Sub-widgets are `StatelessWidget` except `MoodSelector` which is `ConsumerWidget` with `.select()` |
| §12.6 | Extract to `components/` | All sub-widgets in `components/` subfolder |
| §12.1 | Resource disposal | `AnimationController` disposed in `dispose()` on `CompletionRing` |

### Design System

| # | Rule | How Satisfied |
|---|------|---------------|
| — | All colors via DsColors tokens | New tokens added for completion-specific colors; inline only for semi-transparent decorative values |
| — | All text via `context.textTheme` | Used as base, with `copyWith` for design overrides; `GoogleFonts.lora()` for serif text |
| — | All spacing via DsSpacing | Used where matching; raw values only for design-specific measurements |

### Extensions

| # | Rule | How Satisfied |
|---|------|---------------|
| §5.3 | Use `context.textTheme` not `Theme.of(context).textTheme` | All text styles via `context.textTheme` extension |

---

## NEEDS CONFIRMATION Items

1. **Streak count source** — Is the streak count passed as an argument from the player screen, or fetched from a provider/API?
2. **CTA button style** — Use standard `DsButton` (teal gradient) or custom buttons matching the design's darker green (`#0d6e4a`)?
3. **Quote localization** — Keep quotes as Vietnamese-only mock data, or localize them in ARB files now?
