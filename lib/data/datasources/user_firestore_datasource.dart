import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_clean_template/core/firebase/firebase_error_mapper.dart';
import 'package:flutter_clean_template/data/models/user_profile_model.dart';

/// Firestore + Firebase Auth data source for the `/users/{uid}` collection.
///
/// All public methods MUST wrap Firebase calls in a single try/catch that
/// delegates to [mapFirebaseError]. No business logic in the catch block.
abstract interface class UserFirestoreDataSource {
  /// Signs in anonymously and returns the resulting `uid`.
  Future<String> signInAnonymously();

  /// One-shot read of `/users/{uid}`. Returns `null` if the document does
  /// not exist.
  Future<UserProfileModel?> getUser(String uid);

  /// Idempotent: writes a default anonymous profile to `/users/{uid}` only
  /// if the document does not already exist.
  Future<void> createUserIfAbsent(String uid);

  /// Realtime stream of `/users/{uid}`. Emits `null` while the document is
  /// missing, then a populated model once it appears.
  Stream<UserProfileModel?> watchUser(String uid);

  /// Forwards Firebase Auth's `authStateChanges()` stream.
  Stream<User?> authStateChanges();
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  const UserFirestoreDataSourceImpl(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Firestore path: `/users/{uid}` per docs/db/zenna_mind_database_design.md §5.
  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Future<String> signInAnonymously() async {
    try {
      final cred = await _auth.signInAnonymously();
      final user = cred.user;
      if (user == null) {
        throw const AuthFailure('Sign-in returned a null user');
      }
      return user.uid;
    } on FirebaseAuthException catch (e) {
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
      if (snap.exists) return;
      final fresh = UserProfileModel.newAnonymous(uid);
      await ref.set(fresh.toFirestoreForCreate());
    } on FirebaseException catch (e) {
      throw mapFirebaseError(e);
    }
  }

  @override
  Stream<UserProfileModel?> watchUser(String uid) {
    return _users.doc(uid).snapshots().handleError((Object e) {
      throw mapFirebaseError(e);
    }).map((snap) {
      if (!snap.exists) return null;
      return UserProfileModel.fromFirestore(snap);
    });
  }

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
