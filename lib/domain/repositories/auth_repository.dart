import 'package:flutter_clean_template/domain/entities/user_profile.dart';

/// Auth + user profile repository contract.
///
/// Implementations MUST translate Firebase exceptions to [Failure] subtypes
/// at the data source boundary; this interface lets [Failure] bubble up
/// naturally — no try/catch at this layer or at the call site.
abstract interface class AuthRepository {
  /// Streams the current user profile, or `null` when signed out.
  ///
  /// Composes Firebase Auth's `authStateChanges()` with the `/users/{uid}`
  /// document snapshots so downstream consumers see live profile updates
  /// without refetching.
  Stream<UserProfile?> watchCurrentUser();

  /// Signs in anonymously and ensures `/users/{uid}` exists.
  ///
  /// Idempotent: if the user is already signed in or the profile document
  /// already exists, this is a no-op for the affected resource.
  Future<UserProfile> signInAnonymouslyAndBootstrap();
}
