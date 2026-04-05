# Player Screen — UI Implementation Plan

**Design source:** `docs/design/player/screen.png` + `docs/design/player/code.html`
**Data classification:** Session data is **static (mock)**. Labels are **static (l10n)**. Playback state is **dynamic (local)**.
**Note:** This is a full-screen modal — no bottom nav bar, no tab shell.

---

## 1. Screen Overview

Meditation playback screen. Shows a breathing animation ring, session title, description, progress slider, and playback controls (previous, play/pause, next). Opened when user taps "Bắt đầu" from home or a card from browse.

---

## 2. Visual Hierarchy (top → bottom)

| # | Element | Type | Position |
|---|---------|------|----------|
| 1 | Top bar: back button (left) + "ĐANG PHÁT" label (center) + more button (right) | Header | Fixed |
| 2 | Breathing animation ring: 3 concentric circles + center dot, pulsing animation | Animation | Centered |
| 3 | Session title: "10 phút xoa dịu căng thẳng" | Text | Centered |
| 4 | Session description: "Lắng nghe hơi thở, giải phóng áp lực" | Text | Centered |
| 5 | Progress bar: elapsed time (left) + slider track + remaining time (right) | Slider | Fixed bottom area |
| 6 | Controls: skip previous + play/pause + skip next | Buttons | Fixed bottom |

---

## 3. Design Tokens Mapping

### 3.1 Typography

| Element | Design | textTheme | Override |
|---------|--------|-----------|----------|
| "ĐANG PHÁT" label | 11px/DM Sans, uppercase, tracking 0.1em | `labelSmall` | `letterSpacing: 1.5, color: playerTextHint` |
| Session title | 22px/w300 | `titleLarge` | `fontWeight: w300` — use Plus Jakarta Sans from textTheme, not Lora |
| Session description | 13px/DM Sans | `bodySmall` | `color: playerTextMuted` |
| Progress time | 11px/DM Sans | `labelSmall` | `color: playerTextHint` |

**Note:** The design uses Lora (serif) but the app uses Plus Jakarta Sans + Manrope consistently. Use `titleLarge` with `fontWeight: w300` to keep font consistency.

### 3.2 Colors — NEW Player-Specific Palette

The player screen has a completely different color palette from the rest of the app. These should be defined as **player-scoped constants**, not added to `DsColors` (since they're screen-specific, not design-system-wide).

| Usage | Design Value | Constant Name | Notes |
|-------|-------------|---------------|-------|
| Background | `#BFE4D8` | `_playerBg` | Soft green |
| Background circle blobs | `rgba(255,255,255,0.18)` | `_blobColor` | White 18% |
| Main text | `#0A3D28` | `_textMain` | Dark green |
| Muted text | `rgba(10,60,45,0.48)` | `_textMuted` | |
| Hint text | `rgba(10,60,45,0.38)` | `_textHint` | |
| Icon button bg | `rgba(255,255,255,0.42)` | `_iconBtnBg` | |
| Skip button border | `rgba(10,100,70,0.28)` | `_skipBorder` | |
| Skip button icon | `rgba(10,80,55,0.52)` | `_skipIcon` | |
| Play button bg | `#0D6E4A` | `_playBg` | Dark green |
| Play button shadow | `rgba(13,110,74,0.3)` | `_playShadow` | |
| Progress track | `rgba(10,100,70,0.15)` | `_progTrack` | |
| Progress fill | `rgba(10,120,80,0.62)` | `_progFill` | |
| Progress dot | `#0D8A5E` | `_progDot` | |
| Ring outer border | `rgba(10,100,70,0.2)` | `_ringOuter` | |
| Ring mid border | `rgba(10,100,70,0.12)` | `_ringMid` | |
| Ring core bg | `rgba(255,255,255,0.46)` | `_ringCore` | |
| Ring center dot | `rgba(10,120,80,0.36)` | `_ringDot` | |

### 3.3 Spacing

| Usage | Design | Token/Value |
|-------|--------|-------------|
| Screen horizontal padding | 30px | `DsSpacing.xl` (32) — close |
| Top bar top padding | 14px | 14 |
| Breathing ring size | 136px | 136 |
| Ring to title gap | 28px | 28 |
| Title to description gap | 10px | 10 |
| Progress times margin bottom | 10px | 10 |
| Progress track height | 3px | 3 |
| Progress dot size | 11px | 11 |
| Controls gap | 22px | 22 |
| Controls bottom padding | 30px | 30 |
| Skip button size | 46px | 46 |
| Play button size | 68px | 68 |
| Icon button size (top bar) | 34px | 34 |

### 3.4 Radius

| Usage | Design | Token |
|-------|--------|-------|
| Icon buttons | full (circle) | `DsRadius.full` |
| Skip buttons | full (circle) | `DsRadius.full` |
| Play button | full (circle) | `DsRadius.full` |
| Progress track | 2px | 2 |

---

## 4. Data Source Classification

| Data Item | Source | Notes |
|-----------|--------|-------|
| "ĐANG PHÁT" label | Static (l10n) | |
| Session title "10 phút xoa dịu căng thẳng" | Static (mock) | Will come from navigation arguments |
| Session description | Static (mock) | Will come from navigation arguments |
| Current time "3:48" | Dynamic (local) | Computed from playback position |
| Remaining time "-6:12" | Dynamic (local) | Computed from total - current |
| Progress percentage | Dynamic (local) | Current / total |
| Play/pause state | Dynamic (local) | Toggle on button tap |

---

## 5. Localization Keys

### 5.1 New Keys

| Key | EN | VI |
|-----|----|----|
| `player_nowPlaying` | `NOW PLAYING` | `ĐANG PHÁT` |

Only 1 key needed — all other text is mock data or computed.

---

## 6. Architecture Plan

### 6.1 File Structure

```
lib/features/player/
  ├── player_screen.dart                        # ConsumerStatefulWidget
  ├── player_view_model.dart                    # @riverpod Notifier<PlayerUiState>
  ├── models/
  │   └── player_ui_state.dart                  # @freezed UiState + Events
  └── components/
      ├── player_top_bar.dart                   # Back + "ĐANG PHÁT" + more
      ├── player_breathing_ring.dart            # Animated concentric circles
      ├── player_session_info.dart              # Title + description
      ├── player_progress_bar.dart              # Time labels + slider track
      └── player_controls.dart                  # Skip prev + play/pause + skip next
```

### 6.2 UiState Design

```dart
@freezed
class PlayerUiState with _$PlayerUiState {
  const factory PlayerUiState({
    @Default('10 phút xoa dịu căng thẳng') String sessionTitle,
    @Default('Lắng nghe hơi thở, giải phóng áp lực') String sessionDescription,
    @Default(Duration(minutes: 10)) Duration totalDuration,
    @Default(Duration(minutes: 3, seconds: 48)) Duration currentPosition,
    @Default(true) bool isPlaying,
    PlayerEvent? event,
  }) = _PlayerUiState;
}

sealed class PlayerEvent {
  const PlayerEvent();
}

class PlayerNavigateBack extends PlayerEvent {
  const PlayerNavigateBack();
}
```

### 6.3 ViewModel Methods

| Method | Trigger | Action |
|--------|---------|--------|
| `build()` | Init | Returns `PlayerUiState()` with mock data |
| `onPlayPauseTapped()` | Tap play/pause | `copyWith(isPlaying: !isPlaying)` |
| `onSkipPrevious()` | Tap skip prev | Reset position or go to previous track |
| `onSkipNext()` | Tap skip next | Go to next track |
| `onSeek(double)` | Drag slider | Update `currentPosition` |
| `onBackTapped()` | Tap back | Emit `PlayerNavigateBack` |
| `consumeEvent()` | After event | `copyWith(event: null)` |

---

## 7. Widget Decomposition

### 7.1 Component Tree

```
PlayerScreen (ConsumerStatefulWidget)
  └── Scaffold (no app bar, custom bg)
      └── Stack
          ├── Background blobs (2 positioned circles)
          └── Column
              ├── SizedBox (safe area top)
              ├── PlayerTopBar (StatelessWidget)
              ├── Expanded → Center
              │   └── Column (mainAxisSize: min)
              │       ├── PlayerBreathingRing (StatelessWidget — animated)
              │       └── PlayerSessionInfo (ConsumerWidget — watches title, description)
              ├── PlayerProgressBar (ConsumerWidget — watches currentPosition, totalDuration)
              └── PlayerControls (ConsumerWidget — watches isPlaying)
```

### 7.2 Component Details

| Component | Type | Watches | File |
|-----------|------|---------|------|
| `PlayerScreen` | `ConsumerStatefulWidget` | Events only | `player_screen.dart` |
| `PlayerTopBar` | `StatelessWidget` | Nothing | `components/player_top_bar.dart` |
| `PlayerBreathingRing` | `StatelessWidget` | Nothing (pure animation) | `components/player_breathing_ring.dart` |
| `PlayerSessionInfo` | `ConsumerWidget` | `.select((s) => (s.sessionTitle, s.sessionDescription))` | `components/player_session_info.dart` |
| `PlayerProgressBar` | `ConsumerWidget` | `.select((s) => (s.currentPosition, s.totalDuration))` | `components/player_progress_bar.dart` |
| `PlayerControls` | `ConsumerWidget` | `.select((s) => s.isPlaying)` | `components/player_controls.dart` |

### 7.3 Key Component Specifications

#### PlayerTopBar
- Row: back icon button (34px circle, `white/42` bg) + "ĐANG PHÁT" label (centered) + more icon button (34px circle)
- Back: chevron_left icon, tap → `onBackTapped()`
- More: more_vert icon, tap → no-op (TODO)

#### PlayerBreathingRing
- 136×136 container with 3 concentric animated circles
- Outer ring: 136px, 1.5px border `ringOuter`, pulse animation 4s
- Mid ring: 104px (inset 16), 1px border `ringMid`, pulse animation 4s delay 0.5s
- Core circle: 72px (inset 32), solid `ringCore` bg, pulse animation 4s delay 1s
- Center dot: 30px, solid `ringDot` bg, breathe animation 4s (scale 1 → 1.15)
- Use `AnimationController` with repeat

#### PlayerProgressBar
- Top row: elapsed "3:48" (left) + remaining "-6:12" (right)
- Slider track: 3px height, `progTrack` bg
- Fill: 3px height, `progFill` bg, width = progress %
- Dot: 11px circle, `progDot`, positioned at fill end
- Can use `Slider` widget with custom theme, or manual `GestureDetector` + `CustomPaint`

#### PlayerControls
- Row centered: skip prev (46px) + play/pause (68px) + skip next (46px)
- Skip buttons: circle, transparent bg, 1px `skipBorder`, icon `skipIcon`
- Play/pause: circle, `playBg`, shadow `playShadow`, white pause/play icon
- Icons: `Icons.skip_previous` / `Icons.skip_next` / `Icons.pause` / `Icons.play_arrow`

---

## 8. Design System Token Updates

### 8.1 No Global Token Changes

Player colors are screen-specific — defined as private constants in `player_screen.dart` or a `_player_colors.dart` file within the feature folder. Do NOT add to `DsColors`.

### 8.2 No New DS Components

All components are player-specific.

---

## 9. Interactive Elements

| Element | Type | States | Behavior |
|---------|------|--------|----------|
| Back button | IconButton | default | `onBackTapped()` → pop screen |
| More button | IconButton | default | No-op (TODO) |
| Play/Pause | Button | playing / paused | `onPlayPauseTapped()` → toggle icon |
| Skip Previous | Button | default | `onSkipPrevious()` |
| Skip Next | Button | default | `onSkipNext()` |
| Progress bar | Slider | default / dragging | `onSeek(position)` |

---

## 10. Layout Notes

- **Full screen modal** — no bottom nav, no tab shell
- **Stack** for background blobs behind content
- **Breathing ring** centered in the expanded middle area
- **Progress + Controls** anchored to bottom
- **SafeArea:** Top padding via `context.viewPadding.top`, bottom via `context.viewPadding.bottom`
- **Route:** Push as a new route (not inside `StatefulShellRoute`), e.g. `/player`
- **Background blobs:** 2 large semi-transparent white circles, positioned absolute — blob1 top-left (-100, -80), blob2 bottom-right (-60, -55)

---

## 11. Implementation Checklist

```
1. [ ] Create UiState + Events (`features/player/models/player_ui_state.dart`)
2. [ ] Run build_runner
3. [ ] Create ViewModel (`features/player/player_view_model.dart`)
4. [ ] Run build_runner
5. [ ] Add l10n key to `app_en.arb` and `app_vi.arb`
6. [ ] Run l10n generation: `flutter gen-l10n`
7. [ ] Create PlayerTopBar component
8. [ ] Create PlayerBreathingRing component (with animation)
9. [ ] Create PlayerSessionInfo component
10. [ ] Create PlayerProgressBar component
11. [ ] Create PlayerControls component
12. [ ] Create PlayerScreen (assemble all components)
13. [ ] Add route to `app_router.dart` (push route, outside shell)
14. [ ] Run analyzer: `flutter analyze`
15. [ ] Verify against design screenshot
```

---

## 12. Compliance Matrix

### UiState (§3)

| Rule | How Satisfied |
|------|---------------|
| §3.1 `@freezed`, synchronous | `PlayerUiState` is `@freezed`, ViewModel is `Notifier<PlayerUiState>` |
| §3.2 AsyncValue | No async fields (all local state) |
| §3.5 Event pattern | `sealed class PlayerEvent`, `consumeEvent()` |

### ViewModel (§2)

| Rule | How Satisfied |
|------|---------------|
| §2.1 Notifier, not AsyncNotifier | Extends `_$PlayerViewModel` |
| §13.1 No mutable fields | All state in `PlayerUiState` |

### Widgets (§12)

| Rule | How Satisfied |
|------|---------------|
| §12.3 Typography via textTheme | All text via `context.textTheme.*` — session title uses `titleLarge` with w300 |
| §12.5 const, .select() | Each ConsumerWidget uses `.select()` |
| §12.6 components/ subfolder | All sub-widgets in `components/` |
| §12.1 Resource disposal | `AnimationController` disposed in `PlayerBreathingRing` |
| §5.3 Use context extensions | `context.textTheme`, `context.viewPadding` |
