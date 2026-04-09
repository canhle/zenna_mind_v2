# Screen Implementation Order

> Recommended order for implementing logic, from simplest/least-dependent to most complex.
> This order minimizes rework: each step builds reusable infrastructure the next step consumes.

---

## Recommended Order

| # | Screen | Feature Folder | Rationale |
|---|--------|----------------|-----------|
| 1 | `welcome` | [lib/features/welcome/](../../lib/features/welcome/) | **Auth bootstrap — must come first.** Calls `FirebaseAuth.instance.signInAnonymously()` on Start tap and creates the `/users/{uid}` document with default `UserSettings` via a new `UserRepository.bootstrapAnonymousUser()`. Establishes the `currentUserProvider` + `UserProfile` entity + `UserFirestoreDataSource` — all reused by Home and Streak. Also wires the initial `GoRouter.redirect` logic that chooses `/welcome` vs `/home` based on current auth state. After this screen is done, every subsequent Firestore query can safely assume an authenticated UID. |
| 2 | `browse` | [lib/features/browse/](../../lib/features/browse/) | Pure reads of master data (`/sessions`, `/categories`, `/moods`). No writes. Establishes `MeditationSession`, `Category`, `Mood` entities + their DataSources + `masterSessionsProvider` / `masterCategoriesProvider` / `masterMoodsProvider` — all reused by every later screen. First real Firestore read path; proves `FirebaseException → Failure` mapping end-to-end. |
| 3 | `player` | [lib/features/player/](../../lib/features/player/) | Reads a single `MeditationSession` by ID (reuses `masterSessionsProvider` from step 2) via `PlayerArguments.sessionId`. Playback progress stays local. Introduces `inProgressSessionProvider` (SharedPreferences-backed) for writing/resuming playback position. No new Firestore collections. Must emit `PlayerSessionComplete` with `MeditationCompleteArguments` so step 6 has a valid entry point. |
| 4 | `home` | [lib/features/home/](../../lib/features/home/) | Consumes providers established in steps 1–3 but adds no new Firestore writes. New infrastructure introduced: `currentMonthStreakProvider` (reads `/users/{uid}/streak/{YYYY-MM}`) + time-of-day greeting logic. The greeting name/avatar come from `currentUserProvider` (step 1). Depends on Player (step 3) for navigation. Also resolves the `MoodType` enum ↔ Firestore `/moods` reconciliation for the mood selector. |
| 5 | `streak` | [lib/features/streak/](../../lib/features/streak/) | Reads `currentMonthStreakProvider` (from step 4) + adds `/users/{uid}/history` queries for the "today's completion" card. Derives `weekDots` and `isTodayCompleted` from `MonthlyStreak.completedDays`. Pending vs done branching. Deep-links into Player (reuses step 3). No writes. |
| 6 | `meditation_complete` | [lib/features/meditation_complete/](../../lib/features/meditation_complete/) | **Only screen that writes user-scoped data.** Writes a new `SessionHistory` doc and atomically updates `MonthlyStreak` (increment `totalMinutes`, `totalSessions`, append `completedDays`, recompute `currentStreak`). Reads `MeditationSession` for the streak badge and quote. Because its writes must propagate through the live `currentMonthStreakProvider` snapshot on Home and Streak, it comes last — the downstream screens must exist first to verify the reactive flow. |

---

## Dependencies Map

```
                   ┌─────────────┐
                   │   welcome   │  (1) ← auth bootstrap: signInAnonymously + create /users/{uid}
                   └──────┬──────┘
                          │ currentUserProvider + UserProfile entity
                          ▼
                   ┌─────────────┐
                   │   browse    │  (2) ← master data reads (Session/Category/Mood)
                   └──────┬──────┘
                          │ MeditationSession + masterSessionsProvider
                          ▼
                   ┌─────────────┐
                   │   player    │  (3) ← reuses Session, adds InProgressSession (local)
                   └──────┬──────┘
                          │ MeditationCompleteArguments + inProgressSessionProvider
                          ▼
                   ┌─────────────┐
                   │    home     │  (4) ← adds currentMonthStreakProvider
                   └──────┬──────┘
                          │ MonthlyStreak reactive reads
                          ▼
                   ┌─────────────┐
                   │   streak    │  (5) ← adds SessionHistory reads
                   └──────┬──────┘
                          │
                          ▼
                   ┌───────────────────┐
                   │meditation_complete│  (6) ← writes history + updates streak
                   └───────────────────┘
```

**Shared infrastructure introduced per step** (each row = new providers/entities/DataSources, reused by everything below):

| Step | New entities | New providers | New DataSources / Repositories |
|------|--------------|---------------|--------------------------------|
| 1. welcome | `UserProfile`, `UserSettings`, `AuthProvider` (enum) | `currentUserProvider`, `authStateProvider`, `firebaseAuthProvider` | `UserFirestoreDataSource` (create + read), `AuthRepository.bootstrapAnonymousUser()`, GoRouter redirect logic |
| 2. browse | `MeditationSession`, `Category`, `Mood`, `MeditationLevel`, `BackgroundSoundKey` | `masterSessionsProvider`, `masterCategoriesProvider`, `masterMoodsProvider` | `SessionFirestoreDataSource`, `CategoryFirestoreDataSource`, `MoodFirestoreDataSource` |
| 3. player | `InProgressSession` (local) | `inProgressSessionProvider` (SharedPreferences) | `InProgressSessionLocalDataSource` |
| 4. home | — | `currentMonthStreakProvider`, `featuredSessionProvider` (derived) | `StreakFirestoreDataSource` (read only) |
| 5. streak | `SessionHistory` | `todayHistoryProvider` (derived) | `HistoryFirestoreDataSource` (read only) |
| 6. meditation_complete | — | — (reuses all above, adds write methods to existing DataSources) | Extends `HistoryFirestoreDataSource.addHistory()` + `StreakFirestoreDataSource.incrementMonthlyStreak()` |

---

## Notes

### Why Welcome first?
Welcome is the auth bootstrap. Every other screen's Firestore query — even master-data reads like `/sessions` — will fail under the project's Security Rules if there is no authenticated user (`allow read: if request.auth != null`). Implementing Welcome first guarantees:
1. `currentUserProvider` exists and is populated before any later screen runs.
2. The `/users/{uid}` doc exists, so Home/Streak can read it without special-casing "no user doc yet".
3. The router redirect logic is in place so the app opens the correct screen on each launch.

Welcome's own logic is small (one button → one `signInAnonymously()` call + doc creation + navigate), but the infrastructure it introduces is foundational.

### Why `browse` before `home`?
Home has more data dependencies (greeting name, featured session, in-progress session, monthly streak, quote) than Browse, making it a bad debugging starting point. Browse establishes the Session entity and proves the master-data read path with pure read-only queries.

### Why `meditation_complete` last?
It's the only writer. Its writes must flow through `currentMonthStreakProvider` and update the live UI on Home and Streak. Those screens must already exist to observe the writes and verify the reactive flow — otherwise the write is untestable end-to-end.

### Router redirect logic (established in step 1)
```dart
// pseudo-code; final form lives in app_router.dart after step 1
redirect: (context, state) {
  final user = ref.read(currentUserProvider);
  final loggedIn = user.valueOrNull != null;
  final onWelcome = state.matchedLocation == '/welcome';

  if (!loggedIn && !onWelcome) return '/welcome';
  if (loggedIn && onWelcome) return '/home';
  return null;
}
```
This redirect runs on every navigation, so the app naturally opens Home on subsequent launches and Welcome on the first launch.

### Parallelizable work
- Steps 2 and 3 can be done in parallel once step 1 is done — Player only needs the `MeditationSession` entity interface, not the full Browse UI.
- Steps 4 and 5 share `currentMonthStreakProvider` but are otherwise independent.

### Coordination points
- **Welcome → all screens:** `UserFirestoreDataSource` created in step 1 is extended in later steps (step 4 adds `watchCurrentUser`, step 6 adds `updateLongestStreak`). The entity shape must be stable from step 1 onward.
- **Home ↔ Streak:** Both read `currentMonthStreakProvider`. Agree on the `weekDots` derivation (UTC vs local time) during step 4 so step 5 doesn't have to reinvent it.
- **Player → MeditationComplete:** The shape of `MeditationCompleteArguments` (sessionId, actualDuration, breathCycles) must be fixed in step 3 so step 6 reads what step 3 writes.
- **Mood reconciliation:** Home's current `MoodType` enum should be removed in step 4 in favor of reading `/moods`. Confirm this during Home's `/logic-spec` — user may want to keep the enum as a local UI choice separate from the Firestore collection.

---

**Next step:** Run `/logic-spec welcome` to begin the first screen.
