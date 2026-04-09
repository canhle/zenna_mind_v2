---
description: "Task list for Welcome screen — Anonymous Auth & User Bootstrap"
---

# Tasks: Welcome Screen — Anonymous Auth & User Bootstrap

**Input**: Design documents from `/specs/001-welcome-auth/`
**Prerequisites**: [spec.md](./spec.md), [plan.md](./plan.md)
**Tests**: Not requested by the spec — skipped.

**Organization**: Tasks are grouped by **Clean Architecture layer** (domain → data → presentation → polish) as mandated by `/logic-impl` for logic screens. Each task cites the exact Firestore path (from [docs/db/zenna_mind_database_design.md](../../docs/db/zenna_mind_database_design.md)) and maps to user stories US1/US2/US3 from [spec.md](./spec.md).

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel with other [P] tasks in the same sub-phase (different files, no dependencies)
- **[Story]**: US1 = first-time launch, US2 = returning user, US3 = profile preservation, ALL = supports every story

---

## Phase 1: Setup (dependencies & project wiring)

- [X] **T001** [ALL] Add `firebase_auth` and `cloud_firestore` to `pubspec.yaml` dependencies. Add `mocktail`, `fake_cloud_firestore`, `firebase_auth_mocks` to `dev_dependencies`. Run `flutter pub get`. Verify no version conflicts with existing `firebase_core ^4.6.0`.

- [X] **T002** [P] [ALL] Extend `lib/core/error/failures.dart` — add `AuthFailure` and `PermissionFailure` sealed subclasses of `Failure`, matching the existing style (const constructors, default messages).

---

## Phase 2: Foundational — Firebase infrastructure (blocks all user stories)

**⚠️ CRITICAL**: No domain/data/presentation work can start until these files exist.

- [X] **T003** [P] [ALL] Create `lib/core/firebase/firebase_providers.dart`. Define `@Riverpod(keepAlive: true) FirebaseAuth firebaseAuth(Ref)` returning `FirebaseAuth.instance` and `@Riverpod(keepAlive: true) FirebaseFirestore firestore(Ref)` returning `FirebaseFirestore.instance`.

- [X] **T004** [P] [ALL] Create `lib/core/firebase/firebase_error_mapper.dart`. Implement pure function `Failure mapFirebaseError(Object error)` that switches on `FirebaseAuthException.code` and `FirebaseException.code` per the mapping table in [plan.md §B](./plan.md). Handles `network-request-failed`, `operation-not-allowed`, `user-disabled`, `unavailable`, `permission-denied`, `not-found`, `unauthenticated`, + a default fallback.

- [X] **T005** [ALL] Run `dart run build_runner build --delete-conflicting-outputs` to generate `firebase_providers.g.dart`.

**Checkpoint**: Firebase providers compile and `mapFirebaseError` is callable from both data and domain layers.

---

## Phase 3: Domain layer (entities, repository contract, UseCases, providers)

Delivers the shared vocabulary every downstream screen will consume. Depends on Phase 2.

- [X] **T006** [P] [US3] Create `lib/domain/entities/user_profile.dart`. Define:
  - `enum AuthProvider { anonymous, google, apple, email }`
  - `@freezed class UserSettings` with fields per [plan.md §C](./plan.md): `notificationEnabled`, `notificationTime`, `defaultDuration`, `backgroundSound`, all with defaults matching the example doc in [docs/db/zenna_mind_database_design.md §5](../../docs/db/zenna_mind_database_design.md).
  - `@freezed class UserProfile` with all fields from `/users/{uid}` per [docs/db/zenna_mind_database_design.md §5](../../docs/db/zenna_mind_database_design.md): `uid`, `isAnonymous`, `provider`, `email?`, `displayName?`, `avatarUrl?`, `longestStreak`, `createdAt`, `lastActiveAt`, `settings`.

- [X] **T007** [ALL] Run `dart run build_runner build --delete-conflicting-outputs` to generate `user_profile.freezed.dart`.

- [X] **T008** [P] [ALL] Create `lib/domain/repositories/auth_repository.dart` — `abstract interface class AuthRepository` with two methods: `Stream<UserProfile?> watchCurrentUser()` and `Future<UserProfile> signInAnonymouslyAndBootstrap()`. Document that `Failure` bubbles up (no `try/catch` at this layer).

- [X] **T009** [P] [US1] Create `lib/domain/usecases/auth/sign_in_anonymously_usecase.dart`. `class SignInAnonymouslyUseCase` holds an `AuthRepository` and exposes `Future<UserProfile> call()` that delegates to `repo.signInAnonymouslyAndBootstrap()`.

- [X] **T010** [P] [US2] Create `lib/domain/usecases/auth/watch_current_user_usecase.dart`. `class WatchCurrentUserUseCase` holds an `AuthRepository` and exposes `Stream<UserProfile?> call()` delegating to `repo.watchCurrentUser()`.

- [X] **T011** [ALL] Create `lib/domain/providers/auth_domain_providers.dart`. Define (all `@Riverpod(keepAlive: true)`):
  - `SignInAnonymouslyUseCase signInAnonymouslyUseCase(Ref)` reading `authRepositoryProvider`
  - `WatchCurrentUserUseCase watchCurrentUserUseCase(Ref)` reading `authRepositoryProvider`
  - `Stream<UserProfile?> currentUser(Ref)` reading `watchCurrentUserUseCaseProvider.call()` — **this is the app-wide shared profile provider per [docs/spec/app-domain.md](../../docs/spec/app-domain.md)**

- [X] **T012** [ALL] Run `dart run build_runner build --delete-conflicting-outputs` to generate `auth_domain_providers.g.dart`.

**Checkpoint**: Domain layer compiles. No data-layer dependencies yet (will be wired in Phase 4).

---

## Phase 4: Data layer (Firestore model, DataSource, Repository impl, providers)

Implements the domain contract against Cloud Firestore. Depends on Phase 3.

**Firestore path used by every task in this phase: `/users/{uid}` (per [docs/db/zenna_mind_database_design.md §5](../../docs/db/zenna_mind_database_design.md)).**

- [X] **T013** [P] [US3] Create `lib/data/models/user_profile_model.dart`. Manual mapping (NOT `@JsonSerializable` — needs `Timestamp` ↔ `DateTime` and `FieldValue.serverTimestamp()` handling):
  - `UserProfileModel` + nested `UserSettingsModel` classes
  - `UserProfileModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>>)` reads every field of `/users/{uid}`, converts `Timestamp` → `DateTime`, parses `settings` sub-map
  - `UserProfileModel.newAnonymous(String uid)` factory returning a model with default values for a brand-new anonymous user (used by `createUserIfAbsent`)
  - `Map<String, Object?> toFirestoreForCreate()` — uses `FieldValue.serverTimestamp()` for `createdAt` and `lastActiveAt`
  - `UserProfile toEntity()` mapping every field including enum parsing for `provider`

- [X] **T014** [ALL] Create `lib/data/datasources/user_firestore_datasource.dart`. Defines `abstract interface class UserFirestoreDataSource` + `class UserFirestoreDataSourceImpl` with fields `FirebaseAuth _auth`, `FirebaseFirestore _firestore`. Implements five methods — every public method MUST wrap Firestore/Auth calls in a single `try/catch` that delegates to `mapFirebaseError`:
  1. `Future<String> signInAnonymously()` — calls `_auth.signInAnonymously()`, returns `uid`. **Firestore path:** none (auth only). Supports **US1**.
  2. `Future<UserProfileModel?> getUser(String uid)` — one-shot `get()` on `_firestore.collection('users').doc(uid)`. Returns `null` if `!snap.exists`. **Firestore path: `/users/{uid}`.** Supports **US3**.
  3. `Future<void> createUserIfAbsent(String uid)` — get-then-set-if-missing: fetches the doc, returns early if it exists (idempotent per FR-005 + FR-008), otherwise writes `UserProfileModel.newAnonymous(uid).toFirestoreForCreate()`. **Firestore path: `/users/{uid}`.** Supports **US1 + US3**.
  4. `Stream<UserProfileModel?> watchUser(String uid)` — `.doc(uid).snapshots().map(...)`, returns `null` if doc missing, errors mapped via `mapFirebaseError`. **Firestore path: `/users/{uid}`.** Supports **US2**.
  5. `Stream<User?> authStateChanges()` — returns `_auth.authStateChanges()` unchanged.

- [X] **T015** [P] [ALL] Create `lib/data/repositories/auth_repository_impl.dart`. `class AuthRepositoryImpl implements AuthRepository` with constructor taking `UserFirestoreDataSource`. Implements:
  - `watchCurrentUser()`: `async*` generator that listens to `authStateChanges()` and for each non-null auth user yields from `watchUser(uid).map((m) => m?.toEntity())`. Yields `null` when auth user is `null`. Supports **US2**.
  - `signInAnonymouslyAndBootstrap()`: sequence `signInAnonymously` → `createUserIfAbsent(uid)` → `getUser(uid)` → `.toEntity()`. If `getUser` returns `null` after creation, throw `ServerFailure('User profile missing after bootstrap')`. **No try/catch** — `Failure` bubbles from DataSource per [docs/coding-conventions.md §3.7](../../docs/coding-conventions.md). Supports **US1 + US3**.

- [X] **T016** [ALL] Create `lib/data/providers/auth_data_providers.dart`. Define (all `@Riverpod(keepAlive: true)`):
  - `UserFirestoreDataSource userFirestoreDataSource(Ref)` — constructs `UserFirestoreDataSourceImpl(ref.watch(firebaseAuthProvider), ref.watch(firestoreProvider))`
  - `AuthRepository authRepository(Ref)` — constructs `AuthRepositoryImpl(ref.watch(userFirestoreDataSourceProvider))`

- [X] **T017** [ALL] Run `dart run build_runner build --delete-conflicting-outputs` to generate `auth_data_providers.g.dart`.

**Checkpoint**: Data layer compiles. `authRepositoryProvider` is resolvable. `currentUserProvider` (from T011) can now be read without a `ProviderException`.

---

## Phase 5: Presentation layer (Welcome UiState + ViewModel + Screen binding)

Depends on Phase 4.

- [X] **T018** [P] [US1] Add 4 new l10n keys to `lib/core/l10n/intl_en.arb` and `lib/core/l10n/intl_vi.arb`:
  - `welcome_errorNoNetwork` — "Check your connection and try again" / "Kiểm tra kết nối mạng và thử lại"
  - `welcome_errorAuth` — "Sign-in failed. Please try again later." / "Không thể đăng nhập. Vui lòng thử lại sau."
  - `welcome_errorPermission` — "Permission denied" / "Quyền truy cập bị từ chối"
  - `welcome_errorUnknown` — "Something went wrong. Please try again." / "Đã có lỗi xảy ra. Vui lòng thử lại."
  - Then run `flutter gen-l10n`.

- [X] **T019** [US1] Modify `lib/features/welcome/models/welcome_ui_state.dart`:
  - Add `AsyncValue<void> signInStatus` field with `@Default(AsyncValue.data(null))`. Supports **FR-009**.
  - Add new event class `class WelcomeShowErrorSnackbar extends WelcomeEvent { final String message; const WelcomeShowErrorSnackbar(this.message); }`. Supports **FR-007**.
  - Keep existing `WelcomeNavigateToHome` event unchanged.

- [X] **T020** [US1] Modify `lib/features/welcome/welcome_view_model.dart`:
  - Replace the current mock `onStartTapped()` body with the real flow: early-return if `state.signInStatus.isLoading` (FR-008), set loading, call `ref.read(signInAnonymouslyUseCaseProvider).call()` inside a `try/on Failure catch`, on success emit `WelcomeNavigateToHome` + reset `signInStatus` to `AsyncData(null)`, on failure set `AsyncError(f, st)` + emit `WelcomeShowErrorSnackbar(_messageForFailure(f))`.
  - Add private `String _messageForFailure(Failure f)` with `switch` over `NetworkFailure`, `AuthFailure`, `PermissionFailure`, default (FR-007). Uses `S.current` for localization.
  - Keep `consumeEvent()` unchanged.
  - **NO** `ref.watch` inside the ViewModel (per [docs/coding-conventions.md §2](../../docs/coding-conventions.md)) — only `ref.read` for the one-shot usecase call.

- [X] **T021** [US1] Modify `lib/features/welcome/welcome_screen.dart` minimally:
  - In the `ref.listen` event switch, add a case for `WelcomeShowErrorSnackbar` that calls `ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(event.message)))`.
  - Bind the Start button's disabled/loading state to `signInStatus.isLoading` (if `DsButton` does not have an `isLoading` prop, wrap with `AbsorbPointer(absorbing: isLoading, ...)` or add the prop — document whichever approach is used).
  - Use `.select((s) => s.signInStatus.isLoading)` for efficient rebuilds.

**Checkpoint**: Tapping Start on Welcome calls real `signInAnonymously`, writes `/users/{uid}`, navigates to Home on success, shows snackbar on failure. The existing Welcome UI is unchanged except for the loading/disabled state and error snackbar.

---

## Phase 6: Router integration (initial route logic — the "returning user" path)

- [X] **T022** [US2] Modify `lib/core/router/app_router.dart`:
  - Add a `refreshListenable` field that rebuilds when `currentUserProvider` changes. Use the pattern from [plan.md §E](./plan.md): wrap `ref.watch(currentUserProvider)` in a `ValueNotifier` or use a small `GoRouterRefreshStream` helper.
  - Add a `redirect: (context, state) { ... }` callback that reads `currentUserProvider`:
    - If `user.isLoading` → return `null` (stay put; no redirect until auth state resolves, prevents flicker per FR-010)
    - If `user.valueOrNull == null` and `!onWelcome` → return `AppRoutes.welcome`
    - If `user.valueOrNull != null` and `onWelcome` → return `AppRoutes.home`
    - else → return `null`
  - Verify that `initialLocation` remains `AppRoutes.welcome` (the redirect will bounce returning users to Home automatically).
  - Run `dart run build_runner build --delete-conflicting-outputs` if the file has `part` directives.

**Checkpoint**: Returning users see Home on cold start without a Welcome flicker. First-time users see Welcome until they tap Start and sign-in completes.

---

## Phase 7: Codegen, analyze, cleanup

- [X] **T023** [ALL] Run `dart run build_runner build --delete-conflicting-outputs` one final time to cover any file created or modified above (UiState freezed, new providers, etc.).
- [X] **T024** [ALL] Run `flutter analyze` across the entire project. Fix any warnings introduced by this feature. Expected zero warnings.
- [X] **T025** [ALL] Manual smoke test with `flutter run --flavor dev -t lib/main_dev.dart`:
  1. Clear app data — verify Welcome shows on launch.
  2. Tap Start with network on — verify Home appears, verify `/users/{uid}` doc created in Firestore console (check `createdAt` = server timestamp, `longestStreak = 0`, `settings.backgroundSound = "rain"`).
  3. Force-close app, relaunch — verify Home appears directly, Welcome is skipped (**US2 acceptance**).
  4. In Firestore console, manually edit the user doc to set `longestStreak: 42`. Force-close + relaunch. Verify app still works and doc is unchanged after relaunch (**US3 acceptance**).
  5. Turn off network, clear app data, launch, tap Start — verify snackbar shows localized "no network" message and user stays on Welcome.
- [X] **T026** [ALL] Verify no mock data file needs deletion (Welcome has no `*_mock_data.dart`). Document in the commit message that this is expected.

**Checkpoint**: All acceptance scenarios from [spec.md](./spec.md) (US1, US2, US3) pass manual validation.

---

## Dependencies & Execution Order

### Phase dependencies

- **Phase 1 (Setup)**: No deps. T001 first, T002 parallel.
- **Phase 2 (Foundational)**: Depends on Phase 1. T003+T004 parallel, then T005.
- **Phase 3 (Domain)**: Depends on Phase 2. T006 → T007 → T008+T009+T010 parallel → T011 → T012.
- **Phase 4 (Data)**: Depends on Phase 3. T013 parallel with T014; T015 after T013+T014; T016 after T015; T017 last.
- **Phase 5 (Presentation)**: Depends on Phase 4. T018 parallel; T019 → T020 → T021 sequential.
- **Phase 6 (Router)**: Depends on Phases 3+5 (needs `currentUserProvider`).
- **Phase 7 (Polish)**: Depends on everything above.

### Parallel opportunities

- **Phase 1**: T002 can run in parallel with T001.
- **Phase 2**: T003 ∥ T004.
- **Phase 3**: T008 ∥ T009 ∥ T010 (all depend only on T006/T007, no file overlap).
- **Phase 4**: T013 ∥ T014 (different files; T015 depends on both).
- **Phase 5**: T018 ∥ T019 (l10n file is separate from UiState file).

### Critical path

T001 → T003+T004 → T005 → T006 → T007 → T008 → T011 → T012 → T013+T014 → T015 → T016 → T017 → T019 → T020 → T021 → T022 → T023 → T024 → T025.

Roughly 18 sequential steps on the critical path.

---

## User Story Coverage

| Story | Priority | Covered by tasks |
|-------|----------|------------------|
| **US1** — First-time launch creates anonymous account | P1 | T009, T014(1-3), T015(signIn path), T018, T019, T020, T021 |
| **US2** — Returning user bypasses Welcome | P1 | T010, T014(4,5), T015(watchCurrentUser), T022 |
| **US3** — Existing user profile not overwritten | P2 | T006, T013, T014(2,3) — `createUserIfAbsent` idempotency |

All 14 functional requirements from spec.md trace to at least one task:

| FR | Task |
|----|------|
| FR-001 | T022 (redirect: not-logged-in → welcome) |
| FR-002 | T022 (redirect: logged-in → home) |
| FR-003 | T014 (signInAnonymously), T020 |
| FR-004 | T013 (newAnonymous factory), T014 (createUserIfAbsent), T015 |
| FR-005 | T014 (createUserIfAbsent — early return if exists) |
| FR-006 | T020 (WelcomeNavigateToHome → `context.go`), T021 |
| FR-007 | T019 (WelcomeShowErrorSnackbar), T020 (`_messageForFailure`), T021 (snackbar), T018 (l10n) |
| FR-008 | T020 (isLoading guard) |
| FR-009 | T019 (`signInStatus: AsyncValue<void>`), T021 (bind button to isLoading) |
| FR-010 | T022 (`user.isLoading → return null`) |
| FR-011 | T011 (`currentUserProvider` as shared app-wide source) |
| FR-012 | Implicit — Welcome DataSource only touches `/users/{uid}`, no other collections |
| FR-013 | T015 (bootstrap always calls `createUserIfAbsent` after `signInAnonymously`, so a signed-in-but-missing-profile state is self-healed on next Welcome visit) |
| FR-014 | T022 (redirect reads persisted FirebaseAuth state automatically) |

---

## Notes

- **No test tasks** — spec did not request tests. This is a deliberate skip per the tasks template. Tests can be added later as a follow-up feature if desired.
- **No UI file creation** — all UI is pre-existing. Only `welcome_screen.dart` is modified minimally in T021.
- **No mock data cleanup** — Welcome has no `*_mock_data.dart` file.
- Commit strategy: one commit per layer checkpoint (end of Phase 2, 3, 4, 5, 6, 7) so regressions can be bisected cleanly.
