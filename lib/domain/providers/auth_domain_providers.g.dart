// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_domain_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInAnonymouslyUseCaseHash() =>
    r'8f22194beaaed28d6b12f39d68556bca18e35a62';

/// See also [signInAnonymouslyUseCase].
@ProviderFor(signInAnonymouslyUseCase)
final signInAnonymouslyUseCaseProvider =
    Provider<SignInAnonymouslyUseCase>.internal(
      signInAnonymouslyUseCase,
      name: r'signInAnonymouslyUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$signInAnonymouslyUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignInAnonymouslyUseCaseRef = ProviderRef<SignInAnonymouslyUseCase>;
String _$watchCurrentUserUseCaseHash() =>
    r'acec18f6c95e5eb94d415fed8e2fc6e6221b59da';

/// See also [watchCurrentUserUseCase].
@ProviderFor(watchCurrentUserUseCase)
final watchCurrentUserUseCaseProvider =
    Provider<WatchCurrentUserUseCase>.internal(
      watchCurrentUserUseCase,
      name: r'watchCurrentUserUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$watchCurrentUserUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchCurrentUserUseCaseRef = ProviderRef<WatchCurrentUserUseCase>;
String _$currentUserHash() => r'620e7bdfc2dd57effe130fe2c7642f78a096e57f';

/// App-wide source of truth for the current user profile.
///
/// Emits `null` before sign-in (Welcome state), then a populated [UserProfile]
/// after `signInAnonymouslyAndBootstrap` succeeds. Backed by Firebase Auth's
/// `authStateChanges()` composed with `/users/{uid}` snapshots, so profile
/// updates from any feature propagate to all consumers automatically.
///
/// All screens that need user data (Home, Streak, …) MUST read from this
/// provider — never from `FirebaseAuth.instance.currentUser` directly.
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = StreamProvider<UserProfile?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = StreamProviderRef<UserProfile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
