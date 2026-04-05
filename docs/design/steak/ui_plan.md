# Streak Screen — UI Implementation Plan

**Design source:** `docs/design/steak/screen1.png` (pending) + `docs/design/steak/screen2.png` (done) + `docs/design/steak/code.html`
**Data classification:** All data is **static (mock)**. Labels are **static (l10n)**.
**Note:** Full-screen modal (push route), same background style as player screen. Has 2 states: pending (chưa thiền) and done (đã thiền).

---

## 1. Screen Overview

Streak/habit tracking screen. Shows meditation streak stats, weekly calendar, today's status, a suggestion card (pending state) or completion summary (done state), an inspirational quote, and CTA buttons. Reuses `PlayerColors.background` for visual consistency with the player.

---

## 2. Visual Hierarchy (top → bottom)

### Shared (both states)

| # | Element | Type |
|---|---------|------|
| 1 | Top bar: back button + "Duy trì thói quen" centered title | Header |
| 2 | Stat badges: 🔥 7 ngày + ⏱ 84'/94' phút | Pill badges |
| 3 | Weekly calendar card: T2-CN dots (done=green checkmark, today=outlined or green) | Card |
| 4 | Today status card: icon + label + title + meta + badge | Card |

### State: Pending (chưa thiền hôm nay)

| # | Element | Type |
|---|---------|------|
| 5a | Suggestion card: dark green gradient bg + title + duration/type/sound meta | Card |
| 6a | Quote (italic, centered) | Text |
| 7a | CTA: "Bắt đầu thiền hôm nay" (primary button) | Button |

### State: Done (đã thiền hôm nay)

| # | Element | Type |
|---|---------|------|
| 5b | Completion card: session name + time + stats (duration, breath count, mood emoji) | Card |
| 6b | Quote (italic, centered) | Text |
| 7b | CTA: "Thiền thêm một bài nữa" (primary) + "Quay lại trang chủ" (outline) | Buttons |

---

## 3. Design Tokens Mapping

### 3.1 Typography

| Element | Design | textTheme | Override |
|---------|--------|-----------|----------|
| Page title "Duy trì thói quen" | 17px/w300/PlusJakartaSans | `titleMedium` | `fontWeight: w300` |
| Stat badge number | 14px/w500 | `bodyMedium` | `fontWeight: w500` |
| Stat badge label | 10px | `labelSmall` | `fontSize: 10` |
| Calendar "TUẦN NÀY" label | 10px, uppercase | `labelSmall` | `letterSpacing: 1.2` |
| Calendar day name (T2, T3...) | 9px | `labelSmall` | `fontSize: 9` |
| Today card "HÔM NAY" label | 10px, uppercase | `labelSmall` | `letterSpacing: 1.0` |
| Today card title | 14px/w400/PlusJakartaSans | `bodyMedium` | — |
| Today card meta | 11px | `labelSmall` | — |
| Today badge | 10px/w500 | `labelSmall` | `fontWeight: w500` |
| Suggestion "GỢI Ý HÔM NAY" | 10px, uppercase | `labelSmall` | `letterSpacing: 1.2, color: white/50%` |
| Suggestion title | 16px/w300/PlusJakartaSans | `titleMedium` | `fontWeight: w300, color: white` |
| Suggestion meta | 11px | `labelSmall` | `color: white/65%` |
| Done card title | 14px/w400/PlusJakartaSans | `bodyMedium` | — |
| Done card sub | 11px | `labelSmall` | — |
| Done stat value | 18px/PlusJakartaSans | `titleMedium` | `fontSize: 18` |
| Done stat label | 10px, uppercase | `labelSmall` | `fontSize: 10, letterSpacing: 0.8` |
| Quote text | 13px/w300/italic | `bodySmall` | `fontStyle: italic, fontWeight: w300` |
| Quote attribution | 11px | `labelSmall` | `color: textHint` |
| CTA primary text | 15px/w500 | `labelLarge` | — |
| CTA outline text | 15px/w400 | `labelLarge` | `fontWeight: w400` |

### 3.2 Colors

Reuse `PlayerColors` for background/text/blobs. Feature-specific colors:

| Usage | Design Value | Source |
|-------|-------------|--------|
| Background | `#BFE4D8` | `PlayerColors.background` |
| Blobs | white/16% | `PlayerColors.blobColor` |
| Text main | `#0A3D28` | `PlayerColors.textMain` → `DsColors.onSurface` |
| Text muted | `rgba(10,60,40,0.5)` | `DsColors.onSurfaceVariant` |
| Text hint | `rgba(10,60,40,0.45)` | `DsColors.outline` |
| Card bg | white/50% | `Colors.white.withAlpha(0.50)` |
| Card border | white/60% | `Colors.white.withAlpha(0.60)` |
| Calendar dot done | `#0D6E4A` | `DsColors.primaryDim` |
| Today pending dot border | `#0D6E4A` | `DsColors.primaryDim` |
| Today icon pending bg | `#0D6E4A` | `DsColors.primaryDim` |
| Today icon done bg | `rgba(13,110,74,0.15)` | `DsColors.primaryDim.withAlpha(0.15)` |
| Badge pending bg | `rgba(13,110,74,0.1)` | `DsColors.primaryDim.withAlpha(0.10)` |
| Badge pending text | `#0D6E4A` | `DsColors.primaryDim` |
| Suggestion gradient | `#1A5C42 → #0A3D28` | Custom gradient |
| Done card bg | `rgba(13,110,74,0.1)` | `DsColors.primaryDim.withAlpha(0.10)` |
| Done card border | `rgba(13,110,74,0.2)` | `DsColors.primaryDim.withAlpha(0.20)` |
| Done icon bg | `#0D6E4A` | `DsColors.primaryDim` |
| Pill bg | white/52% | `Colors.white.withAlpha(0.52)` |
| Pill border | `rgba(10,100,60,0.18)` | `DsColors.primary.withAlpha(0.18)` |
| CTA primary bg | `#0D6E4A` | `DsColors.primaryDim` |
| CTA outline border | `rgba(10,100,60,0.25)` | `DsColors.primary.withAlpha(0.25)` |

### 3.3 Spacing

| Usage | Design | Token/Value |
|-------|--------|-------------|
| Screen horizontal padding | 24px | `DsSpacing.lg` (24) |
| Section gap between cards | 12px | `DsSpacing.md` (16) — close |
| Badges row padding | 12px top, 16px bottom | 12, 16 |
| Calendar card padding | 16px h, 14px v | 16, 14 |
| Calendar day gap | 4px | `DsSpacing.xs` (4) |
| Today card padding | 14px | 14 |
| Suggestion card padding | 16px | `DsSpacing.md` (16) |
| Done card padding | 14px | 14 |
| Done stats gap | 10px | 10 |
| CTA outline margin top | 10px | 10 |
| Stat pill padding | 6px 14px | 6, 14 |
| Badge radius | 20px | `DsRadius.xl` (24) — close |

### 3.4 Radius

| Usage | Design | Token |
|-------|--------|-------|
| Calendar card | 18px | 18 |
| Today card | 16px | `DsRadius.lg` (16) |
| Suggestion card | 16px | `DsRadius.lg` (16) |
| Done card | 16px | `DsRadius.lg` (16) |
| Done stat box | 12px | `DsRadius.md` (12) |
| Stat pill | 20px | 20 |
| Calendar dot | full (circle) | `BoxShape.circle` |
| CTA buttons | 16px | `DsRadius.lg` (16) |
| Today icon | 13px | `DsRadius.md` (12) — close |
| Back button | full (circle) | `BoxShape.circle` |

---

## 4. Data Source Classification

| Data Item | Source | Notes |
|-----------|--------|-------|
| "Duy trì thói quen" title | Static (l10n) | |
| "ngày" / "phút" labels | Static (l10n) | |
| Streak count (7) | Static (mock) | Will be API later |
| Total minutes (84/94) | Static (mock) | Will be API later |
| "TUẦN NÀY" label | Static (l10n) | Reuse `home_streakWeek` |
| Weekly calendar data (done/pending per day) | Static (mock) | Will be API later |
| "HÔM NAY" label | Static (l10n) | |
| Today status (date, completion, session info) | Static (mock) | Will be API later |
| "GỢI Ý HÔM NAY" label | Static (l10n) | |
| Suggestion session data | Static (mock) | Will be API later |
| Done session stats | Static (mock) | Will be API later |
| Quote text + attribution | Static (mock) | Will be API later |
| CTA button texts | Static (l10n) | |

---

## 5. Localization Keys

### 5.1 New Keys

| Key | EN | VI |
|-----|----|----|
| `streak_title` | `Build your habit` | `Duy trì thói quen` |
| `streak_days` | `days` | `ngày` |
| `streak_minutes` | `min` | `phút` |
| `streak_today` | `TODAY` | `HÔM NAY` |
| `streak_suggestLabel` | `TODAY'S SUGGESTION` | `GỢI Ý HÔM NAY` |
| `streak_notDoneYet` | `Not meditated yet` | `Chưa thiền hôm nay` |
| `streak_completed` | `Completed ✓` | `Đã hoàn thành ✓` |
| `streak_dayCount` | `Day {count}` | `Ngày {count}` |
| `streak_startToday` | `Start meditating today` | `Bắt đầu thiền hôm nay` |
| `streak_doAnother` | `Meditate one more session` | `Thiền thêm một bài nữa` |
| `streak_goHome` | `Back to home` | `Quay lại trang chủ` |
| `streak_duration` | `DURATION` | `THỜI GIAN` |
| `streak_breathCycles` | `BREATH CYCLES` | `VÒNG THỞ` |
| `streak_mood` | `MOOD` | `CẢM XÚC` |

### 5.2 Reuse Existing Keys

| Key | From |
|-----|------|
| `home_streakWeek` | `THIS WEEK` / `TUẦN NÀY` — already exists |

---

## 6. Architecture Plan

### 6.1 File Structure

```
lib/features/streak/
  ├── streak_screen.dart                        # ConsumerStatefulWidget
  ├── streak_view_model.dart                    # @riverpod Notifier<StreakUiState>
  ├── models/
  │   ├── streak_ui_state.dart                  # @freezed UiState + Events
  │   └── streak_mock_data.dart                 # Mock data
  └── components/
      ├── streak_top_bar.dart                   # Back + title (reuse player_top_bar pattern)
      ├── streak_stat_badges.dart               # 🔥 days + ⏱ minutes pills
      ├── streak_calendar_card.dart             # Weekly calendar with dots
      ├── streak_today_card.dart                # Today status card
      ├── streak_suggest_card.dart              # Suggestion card (pending state)
      ├── streak_done_card.dart                 # Completion summary (done state)
      └── streak_quote_section.dart             # Quote text
```

### 6.2 UiState Design

```dart
@freezed
class StreakUiState with _$StreakUiState {
  const factory StreakUiState({
    @Default(false) bool isTodayCompleted,
    @Default(7) int streakDays,
    @Default(84) int totalMinutes,
    @Default([true, true, true, true, true, true, false]) List<bool> weekDays,
    StreakEvent? event,
  }) = _StreakUiState;
}

sealed class StreakEvent {
  const StreakEvent();
}

class StreakNavigateBack extends StreakEvent {
  const StreakNavigateBack();
}

class StreakNavigateToPlayer extends StreakEvent {
  const StreakNavigateToPlayer();
}

class StreakNavigateToHome extends StreakEvent {
  const StreakNavigateToHome();
}
```

### 6.3 ViewModel Methods

| Method | Trigger | Action |
|--------|---------|--------|
| `build()` | Init | Returns `StreakUiState()` with mock data |
| `onBackTapped()` | Tap back | Emit `StreakNavigateBack` |
| `onStartTapped()` | Tap CTA "Bắt đầu" | Emit `StreakNavigateToPlayer` |
| `onDoAnotherTapped()` | Tap "Thiền thêm" | Emit `StreakNavigateToPlayer` |
| `onGoHomeTapped()` | Tap "Quay lại trang chủ" | Emit `StreakNavigateToHome` |
| `consumeEvent()` | After event | `copyWith(event: null)` |

---

## 7. Widget Decomposition

### 7.1 Component Tree

```
StreakScreen (ConsumerStatefulWidget)
  └── Scaffold (PlayerColors.background)
      └── Stack
          ├── Background blobs (same as player)
          └── SafeArea → SingleChildScrollView
              └── Column
                  ├── StreakTopBar (StatelessWidget)
                  ├── StreakStatBadges (ConsumerWidget — watches streakDays, totalMinutes)
                  ├── StreakCalendarCard (ConsumerWidget — watches weekDays, isTodayCompleted)
                  ├── StreakTodayCard (ConsumerWidget — watches isTodayCompleted)
                  ├── if !isTodayCompleted: StreakSuggestCard (StatelessWidget)
                  ├── if isTodayCompleted: StreakDoneCard (StatelessWidget)
                  ├── StreakQuoteSection (StatelessWidget)
                  └── CTA buttons (conditional on isTodayCompleted)
```

### 7.2 Component Details

| Component | Type | Watches | File |
|-----------|------|---------|------|
| `StreakScreen` | `ConsumerStatefulWidget` | Events + `isTodayCompleted` | `streak_screen.dart` |
| `StreakTopBar` | `StatelessWidget` | Nothing | `components/streak_top_bar.dart` |
| `StreakStatBadges` | `ConsumerWidget` | `.select((s) => (s.streakDays, s.totalMinutes))` | `components/streak_stat_badges.dart` |
| `StreakCalendarCard` | `ConsumerWidget` | `.select((s) => (s.weekDays, s.isTodayCompleted))` | `components/streak_calendar_card.dart` |
| `StreakTodayCard` | `ConsumerWidget` | `.select((s) => s.isTodayCompleted)` | `components/streak_today_card.dart` |
| `StreakSuggestCard` | `StatelessWidget` | Nothing (mock data) | `components/streak_suggest_card.dart` |
| `StreakDoneCard` | `StatelessWidget` | Nothing (mock data) | `components/streak_done_card.dart` |
| `StreakQuoteSection` | `StatelessWidget` | Nothing (mock data) | `components/streak_quote_section.dart` |

### 7.3 Key Component Specifications

#### StreakTopBar
- Same layout as PlayerTopBar: back button (36px circle, white/45% bg) + centered title + spacer (no more button)
- Title: "Duy trì thói quen" (`titleMedium`, w300)

#### StreakStatBadges
- Row of 2 pills: 🔥 {count} ngày + ⏱ {minutes}' phút
- Pill: white/52% bg, `primary/18%` border, radius 20, padding 6×14
- Each pill: emoji + number (w500) + label (10px, muted)

#### StreakCalendarCard
- Card: white/50% bg, white/60% border, radius 18
- Header: "TUẦN NÀY" label (10px, uppercase, `letterSpacing: 1.2`)
- 7 day columns: day name (T2-CN, 9px) + dot (32px circle)
- Dot states:
  - Done: `primaryDim` bg + white checkmark icon
  - Today pending: white bg + `primaryDim` border 2px + glow ring + day number
  - Today done: `primaryDim` bg + glow ring 4px + white checkmark

#### StreakTodayCard
- Card: white/38% bg, white/50% border, radius 16
- Row: icon (44px rounded square) + info column + badge pill
- Pending: icon green bg with clock, title "Chủ nhật · 29/03", meta "Chưa thiền hôm nay", badge "Ngày 7"
- Done: icon light green bg with checkmark, title "Đã hoàn thành ✓", meta "Buổi sáng bình yên · 10 phút", badge "Ngày 7 ✓"

#### StreakSuggestCard (pending only)
- Dark green gradient bg (`#1A5C42 → #0A3D28`, 135°), radius 16
- Decorative white/6% circles (absolute positioned)
- Content: "GỢI Ý HÔM NAY" label + session title + meta row (duration + type + sound)

#### StreakDoneCard (done only)
- `primaryDim/10%` bg, `primaryDim/20%` border, radius 16
- Top: green circle icon with checkmark + session title + "Vừa hoàn thành · 9:51 sáng"
- Bottom: 3 stat boxes (white/50% bg, radius 12): THỜI GIAN (10') + VÒNG THỞ (7) + CẢM XÚC (😌)

#### CTA Buttons
- Primary: `primaryDim` bg, white text, radius 16, full width, padding 15px
- Outline: transparent bg, `primary/25%` border, `onSurface` text, radius 16, margin-top 10px
- Use `DsButton` variants: `DsButtonVariant.primary` and `DsButtonVariant.secondary`

---

## 8. Design System Token Updates

### 8.1 No New Global Tokens

All colors map to existing `DsColors` + `PlayerColors` + inline `withAlpha()`.

### 8.2 Suggestion Card Gradient

Define as a feature-scoped constant:
```dart
static const _suggestGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1A5C42), Color(0xFF0A3D28)],
);
```

---

## 9. Interactive Elements

| Element | Type | States | Behavior |
|---------|------|--------|----------|
| Back button | IconButton | default | `onBackTapped()` → pop |
| "Bắt đầu thiền hôm nay" | DsButton primary | pending only | `onStartTapped()` → navigate to player |
| "Thiền thêm một bài nữa" | DsButton primary | done only | `onDoAnotherTapped()` → navigate to player |
| "Quay lại trang chủ" | DsButton secondary | done only | `onGoHomeTapped()` → navigate home |

---

## 10. Layout Notes

- **Full screen modal** — push route `/streak`, no bottom nav
- **Scrollable** — entire content scrolls (SingleChildScrollView)
- **SafeArea** — wrap content in SafeArea
- **Background** — same as player: `PlayerColors.background` + 2 blobs
- **Conditional rendering** — `isTodayCompleted` toggles between suggest/done cards and CTA buttons
- **Quote** — flex: 1 area, centered vertically (fills remaining space)

---

## 11. Implementation Checklist

```
1. [ ] Create UiState + Events (`features/streak/models/streak_ui_state.dart`)
2. [ ] Run build_runner
3. [ ] Create ViewModel (`features/streak/streak_view_model.dart`)
4. [ ] Run build_runner
5. [ ] Add l10n keys to `app_en.arb` and `app_vi.arb`
6. [ ] Run l10n generation: `flutter gen-l10n`
7. [ ] Create mock data file (`features/streak/models/streak_mock_data.dart`)
8. [ ] Create StreakTopBar component
9. [ ] Create StreakStatBadges component
10. [ ] Create StreakCalendarCard component
11. [ ] Create StreakTodayCard component
12. [ ] Create StreakSuggestCard component
13. [ ] Create StreakDoneCard component
14. [ ] Create StreakQuoteSection component
15. [ ] Create StreakScreen (assemble all components)
16. [ ] Add route to `app_router.dart` (push route, outside shell)
17. [ ] Run analyzer: `flutter analyze`
18. [ ] Verify against design screenshots
```

---

## 12. Compliance Matrix

### UiState (§3)

| Rule | How Satisfied |
|------|---------------|
| §3.1 `@freezed`, synchronous | `StreakUiState` is `@freezed`, ViewModel is `Notifier<StreakUiState>` |
| §3.2 AsyncValue | No async fields (all mock/local) |
| §3.5 Event pattern | `sealed class StreakEvent`, `consumeEvent()` |

### ViewModel (§2)

| Rule | How Satisfied |
|------|---------------|
| §2.1 Notifier, not AsyncNotifier | Extends `_$StreakViewModel` |
| §13.1 No mutable fields | All state in `StreakUiState` |

### Widgets (§12)

| Rule | How Satisfied |
|------|---------------|
| §12.3 Typography via textTheme | All text via `context.textTheme.*` |
| §12.5 const, .select() | Each ConsumerWidget uses `.select()` |
| §12.6 components/ subfolder | All sub-widgets in `components/` |
| §5.3 Use context extensions | `context.textTheme`, `context.viewPadding` |
