import 'package:flutter_clean_template/data/providers/auth_data_providers.dart';
import 'package:flutter_clean_template/domain/entities/user_profile.dart';
import 'package:flutter_clean_template/domain/usecases/auth/sign_in_anonymously_usecase.dart';
import 'package:flutter_clean_template/domain/usecases/auth/watch_current_user_usecase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_domain_providers.g.dart';

@Riverpod(keepAlive: true)
SignInAnonymouslyUseCase signInAnonymouslyUseCase(Ref ref) =>
    SignInAnonymouslyUseCase(ref.watch(authRepositoryProvider));

@Riverpod(keepAlive: true)
WatchCurrentUserUseCase watchCurrentUserUseCase(Ref ref) =>
    WatchCurrentUserUseCase(ref.watch(authRepositoryProvider));

/// App-wide source of truth for the current user profile.
///
/// Emits `null` before sign-in (Welcome state), then a populated [UserProfile]
/// after `signInAnonymouslyAndBootstrap` succeeds. Backed by Firebase Auth's
/// `authStateChanges()` composed with `/users/{uid}` snapshots, so profile
/// updates from any feature propagate to all consumers automatically.
///
/// All screens that need user data (Home, Streak, …) MUST read from this
/// provider — never from `FirebaseAuth.instance.currentUser` directly.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentUser(Ref ref) =>
    ref.watch(watchCurrentUserUseCaseProvider).call();
