import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_clean_template/data/datasources/user_firestore_datasource.dart';
import 'package:flutter_clean_template/domain/entities/user_profile.dart';
import 'package:flutter_clean_template/domain/repositories/auth_repository.dart';

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
    // No try/catch — Failure bubbles from the data source per
    // docs/coding-conventions.md §3.7.
    final uid = await _ds.signInAnonymously();
    await _ds.createUserIfAbsent(uid);
    final model = await _ds.getUser(uid);
    if (model == null) {
      // Should never happen — createUserIfAbsent just wrote it.
      throw const ServerFailure(
        message: 'User profile missing after bootstrap',
      );
    }
    return model.toEntity();
  }
}
