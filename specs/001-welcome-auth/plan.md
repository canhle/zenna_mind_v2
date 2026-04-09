# Implementation Plan: Welcome Screen — Anonymous Auth & User Bootstrap

**Branch**: `001-welcome-auth` | **Date**: 2026-04-09 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from [spec.md](./spec.md)

---

## Summary

Replace the Welcome screen's mock navigation shortcut with a real Firebase Anonymous Auth flow. On tap "Start", the ViewModel signs in anonymously, bootstraps a `/users/{uid}` profile document if missing, then navigates to Home. A router-level redirect decides the initial screen on every launch based on auth state + profile presence, so returning users skip Welcome entirely.

This is the **auth bootstrap step** for the entire app — every subsequent screen's Firestore queries depend on the auth and user providers introduced here.

---

## Technical Context

**Language/Version**: Flutter 3.x / Dart 3.x
**Primary Dependencies**:
- `cloud_firestore` (to be added) — Firestore SDK
- `firebase_auth` (to be added) — Firebase Auth SDK
- `firebase_core` ✅ already in pubspec
- `flutter_riverpod` + `riverpod_annotation` ✅
- `freezed_annotation` + `freezed` ✅
- `go_router` ✅
**Storage**: Cloud Firestore (primary — `/users/{uid}` collection); no local storage for this feature
**Testing**: `flutter_test` + `mocktail` for ViewModel unit tests; `fake_cloud_firestore` and `firebase_auth_mocks` for Repository tests
**Target Platform**: iOS + Android (Flutter mobile)
**Project Type**: Mobile app (single Flutter project, Clean Architecture)
**Performance Goals**: SC-001 ≤ 3s cold-start to Home on first launch; SC-002 ≤ 1s returning-user launch post first-paint
**Constraints**: Must not double-write profile doc (idempotent); must not overwrite existing profile; must translate `FirebaseAuthException` / `FirebaseException` → `Failure` at DataSource boundary
**Scale/Scope**: Single screen (welcome) + shared infrastructure consumed by all other screens

---

## Constitution Check

All constitution principles apply. Compliance notes:

| Principle | Applies? | How satisfied |
|-----------|---|---|
| I. Clean Architecture | ✅ | New domain/, data/, core/firebase/ folders. ViewModel imports only domain/providers. |
| II. Riverpod State Management | ✅ | `WelcomeViewModel` is `Notifier<WelcomeUiState>` (already). Adds `currentUserProvider` (keepAlive, app-wide). Uses `ref.read` for one-shot sign-in action. |
| III. Freezed Immutable State | ✅ | `WelcomeUiState` extended with `AsyncValue<Unit> signInStatus`. New `UserProfile` + `UserSettings` entities as `@freezed`. |
| IV. Sealed Error Handling | ✅ | `FirebaseAuthException` + `FirebaseException` mapped to `Failure` via new helper `mapFirebaseError()`. New `AuthFailure` subtype added. |
| V. Design System Separation | ✅ | No design system changes. |

No violations, no Complexity Tracking needed.

---

## Project Structure

### Documentation (this feature)

```
specs/001-welcome-auth/
├── plan.md                          # This file
├── spec.md                          # /logic-spec output
├── tasks.md                         # /logic-impl Phase 2 output
└── checklists/
    └── requirements.md              # /logic-spec output
```

### Source Code — files to create or modify

**UI already implemented** — no new Screen or component files. Only `domain/`, `data/`, `core/`, and ViewModel/UiState updates.

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart                    # MODIFY — add AuthFailure, PermissionFailure
│   └── firebase/                            # NEW directory
│       ├── firebase_providers.dart          # NEW — firebaseAuthProvider, firestoreProvider
│       └── firebase_error_mapper.dart       # NEW — mapFirebaseError() helper
│
├── domain/
│   ├── entities/
│   │   ├── user_profile.dart                # NEW — @freezed UserProfile + UserSettings + AuthProvider enum
│   │   └── user_profile.freezed.dart        # CODEGEN
│   ├── repositories/
│   │   └── auth_repository.dart             # NEW — abstract interface
│   ├── usecases/
│   │   └── auth/
│   │       ├── sign_in_anonymously_usecase.dart     # NEW — signs in + bootstraps profile
│   │       └── watch_current_user_usecase.dart      # NEW — Stream<UserProfile?>
│   └── providers/
│       ├── auth_domain_providers.dart       # NEW — currentUserProvider, usecase providers
│       └── auth_domain_providers.g.dart     # CODEGEN
│
├── data/
│   ├── models/
│   │   ├── user_profile_model.dart          # NEW — fromFirestore/toFirestore, toEntity
│   │   └── user_profile_model.g.dart        # CODEGEN (json_serializable)
│   ├── datasources/
│   │   └── user_firestore_datasource.dart   # NEW — signInAnonymously, getUser, createUserIfAbsent, watchUser
│   ├── repositories/
│   │   └── auth_repository_impl.dart        # NEW — implements AuthRepository
│   └── providers/
│       ├── auth_data_providers.dart         # NEW — datasource + repo providers
│       └── auth_data_providers.g.dart       # CODEGEN
│
├── features/
│   └── welcome/
│       ├── models/
│       │   └── welcome_ui_state.dart        # MODIFY — add AsyncValue<void> signInStatus + WelcomeShowErrorEvent
│       └── welcome_view_model.dart          # MODIFY — call SignInAnonymouslyUseCase, emit loading/error/nav events
│
├── core/router/
│   └── app_router.dart                      # MODIFY — add redirect() based on currentUserProvider
│
└── main_common.dart                         # MODIFY — ensure Firebase.initializeApp is called (already done); no auth preload needed (router redirect handles it)
```

### Structure Decision

Follows the existing Clean Architecture layout. `domain/` and `data/` are layer-first (no `auth/` sub-folder needed — single feature per layer). `core/firebase/` is new but mirrors the existing `core/network/` pattern. Welcome feature files stay in `features/welcome/`.

---

## Technical Approach

### A. Dependency changes (pubspec.yaml)

Add to `dependencies`:
```yaml
firebase_auth: ^5.3.4        # latest compatible with firebase_core ^4.6.0
cloud_firestore: ^5.5.1      # latest compatible with firebase_core ^4.6.0
```

Add to `dev_dependencies` (for tests in Phase 4):
```yaml
mocktail: ^1.0.4
fake_cloud_firestore: ^3.1.0
firebase_auth_mocks: ^0.14.1
```

> Exact versions will be resolved via `flutter pub add` in task T001; these numbers are illustrative.

### B. Firebase infrastructure (`core/firebase/`)

**`firebase_providers.dart`** — two `@Riverpod(keepAlive: true)` providers:

```dart
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;
```

**`firebase_error_mapper.dart`** — one pure function:

```dart
Failure mapFirebaseError(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'network-request-failed' => const NetworkFailure(),
      'operation-not-allowed' => const AuthFailure('Anonymous auth is disabled'),
      'user-disabled'         => const AuthFailure('Account disabled'),
      _                       => AuthFailure(error.message ?? 'Auth error'),
    };
  }
  if (error is FirebaseException) {
    return switch (error.code) {
      'unavailable'        => const NetworkFailure(),
      'permission-denied'  => const PermissionFailure(),
      'not-found'          => const NotFoundFailure(),
      'unauthenticated'    => const UnauthorizedFailure(),
      _                    => ServerFailure(message: error.message ?? 'Firestore error', errorCode: error.code),
    };
  }
  if (error is Failure) return error;
  return const ServerFailure(message: 'Unknown error');
}
```

**`core/error/failures.dart`** additions:

```dart
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class PermissionFailure extends Failure {
  const PermissionFailure() : super('Permission denied');
}
```

### C. Domain layer

**`domain/entities/user_profile.dart`**:

```dart
enum AuthProvider { anonymous, google, apple, email }

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(false) bool notificationEnabled,
    @Default('07:00') String notificationTime,
    @Default(Duration(minutes: 10)) Duration defaultDuration,
    @Default('rain') String backgroundSound,
  }) = _UserSettings;
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required bool isAnonymous,
    required AuthProvider provider,
    String? email,
    String? displayName,
    String? avatarUrl,
    @Default(0) int longestStreak,
    required DateTime createdAt,
    required DateTime lastActiveAt,
    required UserSettings settings,
  }) = _UserProfile;
}
```

**`domain/repositories/auth_repository.dart`**:

```dart
abstract interface class AuthRepository {
  /// Emits the current user profile, or null when signed out.
  /// Backed by `authStateChanges()` composed with `/users/{uid}` snapshots.
  Stream<UserProfile?> watchCurrentUser();

  /// Signs in anonymously and ensures /users/{uid} exists.
  /// Throws a [Failure] on error.
  Future<UserProfile> signInAnonymouslyAndBootstrap();
}
```

**`domain/usecases/auth/sign_in_anonymously_usecase.dart`**:

```dart
class SignInAnonymouslyUseCase {
  const SignInAnonymouslyUseCase(this._repo);
  final AuthRepository _repo;
  Future<UserProfile> call() => _repo.signInAnonymouslyAndBootstrap();
}
```

**`domain/usecases/auth/watch_current_user_usecase.dart`**:

```dart
class WatchCurrentUserUseCase {
  const WatchCurrentUserUseCase(this._repo);
  final AuthRepository _repo;
  Stream<UserProfile?> call() => _repo.watchCurrentUser();
}
```

**`domain/providers/auth_domain_providers.dart`**:

```dart
@Riverpod(keepAlive: true)
SignInAnonymouslyUseCase signInAnonymouslyUseCase(Ref ref) =>
    SignInAnonymouslyUseCase(ref.watch(authRepositoryProvider));

@Riverpod(keepAlive: true)
WatchCurrentUserUseCase watchCurrentUserUseCase(Ref ref) =>
    WatchCurrentUserUseCase(ref.watch(authRepositoryProvider));

/// Shared, app-wide source of truth for the current user profile.
/// Null during Welcome (pre-login), populated after sign-in.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentUser(Ref ref) =>
    ref.watch(watchCurrentUserUseCaseProvider).call();
```

### D. Data layer

**`data/models/user_profile_model.dart`** — manual `fromFirestore`/`toFirestore` (mirrors Firestore map exactly):

```dart
class UserProfileModel {
  // ... fields mirror the /users/{uid} doc shape

  factory UserProfileModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserProfileModel(
      uid:            doc.id,
      isAnonymous:    data['isAnonymous'] as bool? ?? true,
      provider:       data['provider'] as String? ?? 'anonymous',
      email:          data['email'] as String?,
      displayName:    data['displayName'] as String?,
      avatarUrl:      data['avatarUrl'] as String?,
      longestStreak:  data['longestStreak'] as int? ?? 0,
      createdAt:      (data['createdAt'] as Timestamp).toDate(),
      lastActiveAt:   (data['lastActiveAt'] as Timestamp).toDate(),
      settings:       UserSettingsModel.fromMap(data['settings'] as Map<String, dynamic>? ?? const {}),
    );
  }

  Map<String, Object?> toFirestoreForCreate() => {
    'uid':           uid,
    'isAnonymous':   isAnonymous,
    'provider':      provider,
    'email':         email,
    'displayName':   displayName,
    'avatarUrl':     avatarUrl,
    'longestStreak': longestStreak,
    'createdAt':     FieldValue.serverTimestamp(),
    'lastActiveAt':  FieldValue.serverTimestamp(),
    'settings':      settings.toMap(),
  };

  UserProfile toEntity() => UserProfile(/* ... */);
}
```

> `@JsonSerializable` is NOT used here because `Timestamp` ↔ `DateTime` and `FieldValue.serverTimestamp()` need manual handling. Manual mappers are simpler and the constitution allows it (§3 of coding-conventions.md).

**`data/datasources/user_firestore_datasource.dart`**:

```dart
abstract interface class UserFirestoreDataSource {
  Future<String> signInAnonymously();  // returns uid
  Future<UserProfileModel?> getUser(String uid);
  Future<void> createUserIfAbsent(String uid);
  Stream<UserProfileModel?> watchUser(String uid);
  Stream<User?> authStateChanges();
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  const UserFirestoreDataSourceImpl(this._auth, this._firestore);
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');  // path: /users/{uid}

  @override
  Future<String> signInAnonymously() async {
    try {
      final cred = await _auth.signInAnonymously();
      return cred.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseError(e);
    } catch (e) {
      throw mapFirebaseError(e);
    }
  }

  @override
  Future<UserProfileModel?> getUser(String uid) async {
    try {
      final snap = await _users.doc(uid).get();
      if (!snap.exists) return null;
      return UserProfileModel.fromFirestore(snap);
    } on FirebaseException catch (e) {
      throw mapFirebaseError(e);
    }
  }

  @override
  Future<void> createUserIfAbsent(String uid) async {
    try {
      final ref = _users.doc(uid);
      final snap = await ref.get();
      if (snap.exists) return;  // idempotent
      final defaultModel = UserProfileModel.newAnonymous(uid);
      await ref.set(defaultModel.toFirestoreForCreate());
    } on FirebaseException catch (e) {
      throw mapFirebaseError(e);
    }
  }

  @override
  Stream<UserProfileModel?> watchUser(String uid) {
    return _users.doc(uid).snapshots().map((snap) {
      if (!snap.exists) return null;
      return UserProfileModel.fromFirestore(snap);
    }).handleError((Object e) => throw mapFirebaseError(e));
  }

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
```

**Read modes:**
| Query | Mode | Why |
|-------|------|-----|
| `getUser(uid)` | `get()` one-shot | Used inside `createUserIfAbsent` to check existence — no realtime needed |
| `watchUser(uid)` | `snapshots()` stream | Backs `currentUserProvider` — profile updates from other features (future: link account, longestStreak update) must propagate live |
| `authStateChanges()` | Stream from `FirebaseAuth` | Standard — the auth SDK owns this stream |

**`data/repositories/auth_repository_impl.dart`**:

```dart
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._ds);
  final UserFirestoreDataSource _ds;

  @override
  Stream<UserProfile?> watchCurrentUser() async* {
    await for (final authUser in _ds.authStateChanges()) {
      if (authUser == null) {
        yield null;
        continue;
      }
      yield* _ds.watchUser(authUser.uid).map((m) => m?.toEntity());
    }
  }

  @override
  Future<UserProfile> signInAnonymouslyAndBootstrap() async {
    final uid = await _ds.signInAnonymously();
    await _ds.createUserIfAbsent(uid);
    final model = await _ds.getUser(uid);
    if (model == null) {
      // Should never happen — createUserIfAbsent just wrote it.
      throw const ServerFailure(message: 'User profile missing after bootstrap');
    }
    return model.toEntity();
  }
}
```

**Note:** No `try/catch` in RepositoryImpl — `Failure` bubbles from DataSource naturally (per coding-conventions §3.7).

### E. Presentation layer

**`features/welcome/models/welcome_ui_state.dart`** — extended:

```dart
sealed class WelcomeEvent { const WelcomeEvent(); }

class WelcomeNavigateToHome extends WelcomeEvent {
  const WelcomeNavigateToHome();
}

class WelcomeShowErrorSnackbar extends WelcomeEvent {
  const WelcomeShowErrorSnackbar(this.message);
  final String message;
}

@freezed
class WelcomeUiState with _$WelcomeUiState {
  const factory WelcomeUiState({
    @Default(AsyncValue.data(null)) AsyncValue<void> signInStatus,
    WelcomeEvent? event,
  }) = _WelcomeUiState;
}
```

- `signInStatus` is `AsyncValue<void>` because the ViewModel doesn't need to hold the `UserProfile` in local state — `currentUserProvider` is the source of truth. Welcome only tracks whether a sign-in call is in flight or errored.
- `AsyncData(null)` = idle. `AsyncLoading()` = in flight. `AsyncError(f)` = failed (drives the snackbar event + unblocks retry).

**`features/welcome/welcome_view_model.dart`** — extended:

```dart
@riverpod
class WelcomeViewModel extends _$WelcomeViewModel {
  @override
  WelcomeUiState build() => const WelcomeUiState();

  Future<void> onStartTapped() async {
    if (state.signInStatus.isLoading) return;  // FR-008 idempotency
    state = state.copyWith(signInStatus: const AsyncValue.loading());

    try {
      final useCase = ref.read(signInAnonymouslyUseCaseProvider);
      await useCase();
      state = state.copyWith(
        signInStatus: const AsyncValue.data(null),
        event: const WelcomeNavigateToHome(),
      );
    } on Failure catch (f, st) {
      state = state.copyWith(
        signInStatus: AsyncValue.error(f, st),
        event: WelcomeShowErrorSnackbar(_messageForFailure(f)),
      );
    }
  }

  void consumeEvent() => state = state.copyWith(event: null);

  String _messageForFailure(Failure f) => switch (f) {
    NetworkFailure()    => S.current.welcome_errorNoNetwork,
    AuthFailure()       => S.current.welcome_errorAuth,
    PermissionFailure() => S.current.welcome_errorPermission,
    _                   => S.current.welcome_errorUnknown,
  };
}
```

**Localization keys to add** (`core/l10n/app_en.arb` + `app_vi.arb`):
- `welcome_errorNoNetwork` — "Kiểm tra kết nối mạng và thử lại" / "Check your connection and try again"
- `welcome_errorAuth` — "Không thể đăng nhập. Vui lòng thử lại sau." / "Sign-in failed. Please try again later."
- `welcome_errorPermission` — "Quyền truy cập bị từ chối" / "Permission denied"
- `welcome_errorUnknown` — "Đã có lỗi xảy ra. Vui lòng thử lại." / "Something went wrong. Please try again."

**`features/welcome/welcome_screen.dart`** — tiny modification (UI owned, but we need to:
- Pass `signInStatus.isLoading` to the DsButton `isLoading` prop (if it has one) OR disable the button
- Handle `WelcomeShowErrorSnackbar` in the `ref.listen` switch by showing a `ScaffoldMessenger` SnackBar.

**`core/router/app_router.dart`** — add `redirect`:

```dart
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.welcome,
    debugLogDiagnostics: true,
    refreshListenable: ValueNotifier(ref.watch(currentUserProvider)),
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);

      // Still bootstrapping — stay where we are (splash-like)
      if (user.isLoading) return null;

      final loggedIn = user.valueOrNull != null;
      final onWelcome = state.matchedLocation == AppRoutes.welcome;

      if (!loggedIn && !onWelcome) return AppRoutes.welcome;
      if (loggedIn && onWelcome)   return AppRoutes.home;
      return null;
    },
    routes: [ /* unchanged */ ],
  );
}
```

> The `refreshListenable` pattern uses a `ValueNotifier` that notifies on `currentUserProvider` changes, so the router re-evaluates `redirect` when auth state flips.

### F. Main entry (no change required)

`main_common.dart` already calls `Firebase.initializeApp`. The router redirect handles auth-state bootstrap — no preload needed in `main`.

---

## Data Mapping

Firestore path: **`/users/{uid}`** (per [docs/db/zenna_mind_database_design.md](../../docs/db/zenna_mind_database_design.md) §5)

| Firestore field | Type | Model field (`UserProfileModel`) | Entity field (`UserProfile`) | Welcome UiState field |
|---|---|---|---|---|
| *(doc id)* | — | `uid: String` | `uid: String` | — (not displayed on Welcome) |
| `isAnonymous` | bool | `isAnonymous: bool` | `isAnonymous: bool` | — |
| `provider` | String | `provider: String` | `provider: AuthProvider` (enum) | — |
| `email` | String? | `email: String?` | `email: String?` | — |
| `displayName` | String? | `displayName: String?` | `displayName: String?` | — |
| `avatarUrl` | String? | `avatarUrl: String?` | `avatarUrl: String?` | — |
| `longestStreak` | int | `longestStreak: int` | `longestStreak: int` | — |
| `createdAt` | Timestamp | `createdAt: DateTime` | `createdAt: DateTime` | — |
| `lastActiveAt` | Timestamp | `lastActiveAt: DateTime` | `lastActiveAt: DateTime` | — |
| `settings.notificationEnabled` | bool | `settings.notificationEnabled` | `settings.notificationEnabled` | — |
| `settings.notificationTime` | String | `settings.notificationTime` | `settings.notificationTime` | — |
| `settings.defaultDuration` | int (seconds) | `settings.defaultDuration: Duration` | `settings.defaultDuration: Duration` | — |
| `settings.backgroundSound` | String | `settings.backgroundSound: String` | `settings.backgroundSound: String` | — |

**Welcome UiState does NOT surface any UserProfile field.** Welcome only cares about *whether sign-in succeeded* (`signInStatus`) and *where to navigate* (`event`). The UserProfile itself is consumed by downstream screens (Home, Streak) via `currentUserProvider`.

**Welcome mock fields audit** — current `WelcomeUiState` only has `event: WelcomeEvent?`. No mock fields to account for. The feature has no `welcome_mock_data.dart` file. ✅ All accounted for.

---

## Complexity Tracking

No constitution violations. Section intentionally empty.
