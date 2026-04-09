import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_template/core/error/failures.dart';

/// Translates Firebase exceptions to the app's [Failure] hierarchy.
///
/// This is the single boundary at which raw Firebase errors are converted into
/// the app's error language. Every Firestore DataSource method MUST wrap its
/// Firebase calls in a try/catch that delegates to this function.
Failure mapFirebaseError(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'network-request-failed':
        return const NetworkFailure();
      case 'operation-not-allowed':
        return const AuthFailure('Anonymous auth is disabled');
      case 'user-disabled':
        return const AuthFailure('Account disabled');
      case 'too-many-requests':
        return const AuthFailure('Too many attempts. Please try again later.');
      default:
        return AuthFailure(error.message ?? 'Auth error');
    }
  }
  if (error is FirebaseException) {
    switch (error.code) {
      case 'unavailable':
      case 'deadline-exceeded':
        return const NetworkFailure();
      case 'permission-denied':
        return const PermissionFailure();
      case 'not-found':
        return const NotFoundFailure();
      case 'unauthenticated':
        return const UnauthorizedFailure();
      default:
        return ServerFailure(
          message: error.message ?? 'Firestore error',
          errorCode: error.code,
        );
    }
  }
  if (error is Failure) return error;
  return const ServerFailure(message: 'Unknown error');
}
