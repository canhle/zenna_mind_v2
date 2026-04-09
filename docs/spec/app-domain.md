# App Domain Spec — Zenna Mind

> Single source of truth for shared entities, navigation contracts, and cross-screen state.
> All screen-level specs MUST reference this file — never redefine entities locally.

---

## Data Backend

**The app fetches all data directly from Cloud Firestore.** No REST API layer.
Firestore collection structure and document shapes are defined in [docs/db/zenna_mind_database_design.md](../db/zenna_mind_database_design.md) — that file is the authoritative source for all data contracts.

Implications:
- DataSources are Firestore data sources (using `cloud_firestore`), not Dio/HTTP. Name pattern: `{feature}_firestore_datasource.dart`.
- There are NO REST endpoints — `core/network/endpoints.dart` is reserved for future REST features and is not used by any current screen.
- Error handling: `FirebaseException` is translated to `Failure` at the DataSource boundary via a shared `mapFirestoreError(FirebaseException)` helper. Every DataSource public method wraps Firestore calls in a single `try/catch`.
- Read modes chosen per query:
  - `get()` for static/cacheable master data (sessions, categories, moods, user profile)
  - `snapshots()` only where the UX requires live updates (e.g., streak card that should reflect a just-completed session without navigation)
- Anonymous auth is used from first launch. Queries that read user-scoped data MUST pass `currentUser.uid`; Security Rules are the enforcement layer.
- In-progress playback state (the "Continue listening" card on Home) is stored **locally** in SharedPreferences per the database design — NOT in Firestore.

---

## Shared Domain Entities

### MeditationSession

**Firestore source:** `/sessions/{sessionId}` (master data — read-only)

The core entity representing a meditation audio session. Shown as cards on Browse, played on Player, referenced from Home (featured + continue listening) and Streak (suggestion + completion summary).

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `id` | `String` | no | Unique session ID |
| `title` | `String` | no | Session name |
| `description` | `String` | no | Short description shown on Player screen |
| `categoryId` | `String` | no | FK → `/categories/{categoryId}` |
| `moodIds` | `List<String>` | no | FK → `/moods/{moodId}` |
| `duration` | `Duration` | no | Total length (stored in Firestore as seconds) |
| `level` | `MeditationLevel` | no | enum: `beginner`, `intermediate`, `advanced` |
| `isGuided` | `bool` | no | Whether the session has a voice guide |
| `audioUrl` | `String` | no | Firebase Storage URL for the audio file |
| `thumbnailUrl` | `String` | no | Firebase Storage URL for the thumbnail image |
| `backgroundSound` | `BackgroundSoundKey` | no | enum: `none`, `rain`, `waves`, `forest`, `wind` (mapped to URL in code via `SoundMap`) |
| `tags` | `List<String>` | no | Search tags |
| `isFeatured` | `bool` | no | Show in "Featured" section on Browse and Home hero |
| `isActive` | `bool` | no | `false` = hidden from app (client MUST filter) |
| `order` | `int` | no | Display order within a category |

**Used by:** `browse`, `player`, `home`, `streak`, `meditation_complete`

---

### Category

**Firestore source:** `/categories/{categoryId}` (master data — read-only)

Topic groupings for sessions. Shown as the "Chủ đề" tab on the Browse screen.

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `id` | `String` | no | Unique key: `morning` \| `sleep` \| `focus` \| `relax` \| `stress` |
| `name` | `String` | no | Display name |
| `icon` | `String` | no | Icon name (mapped to `IconData` in code) |
| `color` | `String` | no | Hex string for category pill bg |
| `order` | `int` | no | Display order |
| `isActive` | `bool` | no | `false` = hidden from app |

**Used by:** `browse`

---

### Mood

**Firestore source:** `/moods/{moodId}` (master data — read-only)

Emotional tags for sessions. Shown as the "Cảm xúc" tab on Browse. Also referenced by `Home` mood selector, but the Home selector currently uses a local `MoodType` enum — it should be migrated to read from this collection for consistency with Firestore.

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `id` | `String` | no | Unique key: `calm` \| `stressed` \| `anxious` \| `sad` \| `tired` \| `happy` |
| `name` | `String` | no | Display name |
| `order` | `int` | no | Display order |
| `isActive` | `bool` | no | `false` = hidden |

**Note:** `emoji` and `color` per mood are NOT in Firestore — defined in a `MoodStyles` constant in code.

**Used by:** `browse`, `home` (mood selector — reconciliation needed with existing `MoodType` enum)

---

### UserProfile

**Firestore source:** `/users/{uid}` (user-scoped — read/write)

The signed-in user's profile. Populated on first launch via anonymous auth. Anonymous fields (`email`, `displayName`, `avatarUrl`) become populated after `linkWithCredential()`.

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `uid` | `String` | no | Firebase Auth UID |
| `isAnonymous` | `bool` | no | `true` until user links/creates an account |
| `provider` | `AuthProvider` | no | enum: `anonymous`, `google`, `apple`, `email` |
| `email` | `String?` | yes | `null` for anonymous |
| `displayName` | `String?` | yes | `null` for anonymous |
| `avatarUrl` | `String?` | yes | `null` for anonymous |
| `longestStreak` | `int` | no | All-time best streak (spans months, stored here not in streak doc) |
| `createdAt` | `DateTime` | no | |
| `lastActiveAt` | `DateTime` | no | Updated every app open |
| `settings` | `UserSettings` | no | Nested map — see below |

**Nested `UserSettings`:**

| Field | Type | Default |
|-------|------|---------|
| `notificationEnabled` | `bool` | `false` |
| `notificationTime` | `String` (HH:mm) | `"07:00"` |
| `defaultDuration` | `Duration` | `10 min` |
| `backgroundSound` | `BackgroundSoundKey` | `rain` |

**Used by:** `home` (greeting name, avatar), `streak` (longestStreak), potentially Settings later

---

### SessionHistory

**Firestore source:** `/users/{uid}/history/{historyId}` (user-scoped — read/write)

Log of each completed session. Written by `meditation_complete`. Read by `streak` (today's completion status, recent list).

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `id` | `String` | no | Auto-generated document ID |
| `sessionId` | `String` | no | FK → `/sessions/{sessionId}` |
| `sessionTitle` | `String` | no | Denormalized — avoids join when rendering history |
| `duration` | `Duration` | no | Actual time meditated (seconds in Firestore) |
| `mood` | `String` | no | Mood key selected after completion (references `/moods/{moodId}`) |
| `breathCycles` | `int` | no | Number of breath cycles during session |
| `completedAt` | `DateTime` | no | Completion timestamp |

**Used by:** `streak` (read — today's card + completion summary), `meditation_complete` (write — on completion)

---

### MonthlyStreak

**Firestore source:** `/users/{uid}/streak/{YYYY-MM}` (user-scoped — read/write)

Per-month streak aggregation. Document ID is `"2025-03"` format. Updated whenever a session is completed.

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `month` | `String` | no | Document ID, `YYYY-MM` |
| `currentStreak` | `int` | no | Consecutive days meditated up to today. Resets to 0 if a day is skipped |
| `totalMinutes` | `int` | no | Total minutes this month (shown as badge on Streak screen) |
| `totalSessions` | `int` | no | Total sessions completed this month |
| `completedDays` | `List<int>` | no | Day numbers (1–31) when user meditated — drives 7-day calendar dots |

**Derived from entity (computed, not stored):**
- `weekDots: List<bool>` — 7 booleans for T2..CN of the current week, derived by mapping today → ISO week → intersection with `completedDays`
- `isTodayCompleted: bool` — `completedDays.contains(today.day)`

**Used by:** `home` (streak card), `streak` (full screen), `meditation_complete` (streak badge)

**Note on cross-month streaks:** `currentStreak` can span months. When a new month document is created, the logic MUST check the last day of the previous month's `completedDays` to decide if the streak continues.

---

## Navigation Contracts

| From | To | Argument | Return | Trigger |
|------|----|----------|--------|---------|
| (app start, no signed-in user) | `welcome` | — | — | App launch when `FirebaseAuth.instance.currentUser == null` |
| (app start, signed-in user) | `home` | — | — | App launch when a user (anonymous or linked) is already signed in |
| `welcome` | `home` | — | — | Tap "Start" button — triggers `signInAnonymously()`, then replaces route (no back stack to welcome) |
| `home` | `player` | `PlayerArguments(sessionId: featuredSession.id)` | — | Tap "Bắt đầu" on hero card |
| `home` | `player` | `PlayerArguments(sessionId: inProgressSession.id, resumeFrom: position)` | — | Tap "Tiếp tục nghe" card |
| `home` | `streak` | — (none) | — | Tap streak card (if tappable) — TBD in Home spec |
| `home` | `browse` | — (none) | — | Bottom nav tab |
| `browse` | `player` | `PlayerArguments(sessionId: tappedItem.id)` | — | Tap any trending / content / category card |
| `player` | (pop) | — | — | Tap back button |
| `player` | `meditation_complete` | `MeditationCompleteArguments(sessionId, actualDurationSeconds, breathCycles)` | — | Session audio ends (emits `PlayerSessionComplete`) |
| `streak` | `player` | `PlayerArguments(sessionId: suggestedSession.id)` | — | Tap "Bắt đầu thiền hôm nay" (pending state) |
| `streak` | `player` | `PlayerArguments(sessionId: suggestedSession.id)` | — | Tap "Thiền thêm một bài nữa" (done state) |
| `streak` | `home` | — (none) | — | Tap "Quay lại trang chủ" (done state) |
| `streak` | (pop) | — | — | Tap back button |
| `meditation_complete` | `browse` | — (none) | — | Tap "Khám phá bài tiếp theo" |
| `meditation_complete` | `home` | — (none) | — | Tap "Quay lại trang chủ" |

**Routing rules:**
- Only pass IDs (`sessionId`) between screens. Destination screens fetch their own fresh data from Firestore.
- `PlayerArguments`, `MeditationCompleteArguments` MUST be `@freezed` classes.
- Home / Browse live inside `StatefulShellRoute`. Player, Streak, MeditationComplete are pushed as full-screen modal routes outside the shell.
- **Initial route** is chosen by a `GoRouter.redirect` callback that reads `FirebaseAuth.instance.currentUser`:
  - `null` → redirect to `/welcome`
  - non-null → redirect to `/home`
- Welcome is reachable ONLY on first launch (or after explicit sign-out, if ever added). After tapping "Start", Welcome must use `context.go('/home')` (replace, not push) so the back button from Home does not return to Welcome.

---

## Cross-screen Shared State

State that multiple screens read — MUST be exposed through `keepAlive` providers so screens don't refetch independently.

| Provider | Holds | Read by | Written by | keepAlive | Notes |
|----------|-------|---------|------------|-----------|-------|
| `currentUserProvider` | `AsyncValue<UserProfile?>` | `welcome` (to decide redirect), `home`, `streak`, router redirect | Auth layer (on `signInAnonymously` / `linkWithCredential`) | ✅ yes | Single source of truth for UID, name, avatar, longestStreak. Exposed as `Stream<UserProfile?>` — emits `null` before sign-in (Welcome state), then a populated `UserProfile` after. Downstream reads go through `userDocument.snapshots()` so profile updates propagate automatically. |
| `currentMonthStreakProvider` | `AsyncValue<MonthlyStreak>` | `home` (streak card), `streak` (full screen), `meditation_complete` (badge) | `meditation_complete` (increments on session completion) | ✅ yes | Scoped to `YYYY-MM` of today. Use `snapshots()` so `meditation_complete`'s write is reflected live on Home without refetch. When the calendar rolls over to a new month, the provider key changes and a new doc is fetched. |
| `masterSessionsProvider` | `AsyncValue<List<MeditationSession>>` | `browse`, `home` (featured), `player` (detail lookup), `streak` (suggested) | — (master data, read-only) | ✅ yes | Filter at query time by `isActive == true`. Cache aggressively — changes rarely. |
| `masterCategoriesProvider` | `AsyncValue<List<Category>>` | `browse` | — | ✅ yes | |
| `masterMoodsProvider` | `AsyncValue<List<Mood>>` | `browse`, `home` (mood selector — once migrated) | — | ✅ yes | |
| `inProgressSessionProvider` | `InProgressSession?` (local) | `home` ("Tiếp tục nghe" card), `player` (resume) | `player` (on pause/exit) | ✅ yes | **Not Firestore** — backed by `SharedPreferences`. Holds `{sessionId, position, updatedAt}`. |

---

## Notes

### Auth flow
- **First launch** (`currentUser == null`):
  1. Router redirect sends the user to `/welcome`.
  2. User taps "Start" on Welcome → `WelcomeViewModel.onStartTapped()` calls `signInAnonymously()`.
  3. On success, the auth `UserRepository` creates the `/users/{uid}` document with default `UserSettings` (this write only happens if the doc does not already exist — use `set(..., SetOptions(merge: true))` or check existence first).
  4. Welcome emits `WelcomeNavigateToHome` → screen calls `context.go('/home')` (replace, not push).
- **Subsequent launches** (`currentUser != null`):
  1. Router redirect sends the user straight to `/home`.
  2. `currentUserProvider` is already populated from `authStateChanges()` before the first frame.
  3. Welcome is never shown.
- `currentUserProvider` bootstraps from `authStateChanges()` and is the single source of truth for UID, profile, and settings.
- Every screen that reads user-scoped data depends transitively on `currentUserProvider` — no screen should read `FirebaseAuth.instance.currentUser` directly.
- The `/users/{uid}` document creation on first sign-in happens exactly once per UID, coordinated by the auth layer — Welcome MUST NOT write the user doc itself; it only calls `signInAnonymously()` and lets the repository handle doc creation.

### Error handling patterns
- All Firestore reads go through a DataSource method wrapped in `try/catch`. The `catch` delegates to `mapFirestoreError(FirebaseException)` which returns a typed `Failure` subtype (`NetworkFailure`, `PermissionFailure`, `NotFoundFailure`, `AuthFailure`, `UnknownFailure`).
- ViewModels translate `Failure` → user-facing message via `switch` + localized strings. Never show `e.toString()`.
- **Two UiState strategies** for Failure depending on data presence:
  - No existing data → set `AsyncError` on the field + emit a `ShowErrorSnackBarEvent`
  - Existing data already loaded → keep the data, emit a snackbar event only (do not flip to error state)

### Time & locale
- All `Timestamp` values from Firestore MUST be converted to `DateTime` at the Model→Entity boundary. Entities use `DateTime`, not `Timestamp`.
- Month keys (`YYYY-MM`) computed in the device's local timezone. Document this explicitly when month rollover matters.

### Mock data → Firestore migration
- Current mock files to be removed once logic is implemented:
  - `lib/features/browse/models/browse_mock_data.dart`
  - `lib/features/streak/models/streak_mock_data.dart`
  - `lib/features/meditation_complete/models/meditation_complete_mock_data.dart`
- Home has no mock file but hardcodes strings in the widget — will be replaced during the Home logic phase.
- Player's mock values live as defaults in `PlayerUiState` — will be replaced with values loaded from `PlayerArguments.sessionId`.

### Not yet in Firestore (MVP deferrals)
- Inspirational quotes: still hardcoded (`meditation_complete_mock_data.dart`, hardcoded strings on Home). No collection planned for MVP. Keep as local static list with a `quote_provider` that returns a random quote.
- Mood selection on Home (`selectedMood`) is transient UI state — not persisted anywhere in MVP.
- Localization: MVP is Vietnamese-only. Firestore `name` fields are plain strings, not `Map<locale, String>`. Do NOT over-engineer for i18n now.
