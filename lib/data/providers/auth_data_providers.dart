import 'package:flutter_clean_template/core/firebase/firebase_providers.dart';
import 'package:flutter_clean_template/data/datasources/user_firestore_datasource.dart';
import 'package:flutter_clean_template/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_template/domain/repositories/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_providers.g.dart';

@Riverpod(keepAlive: true)
UserFirestoreDataSource userFirestoreDataSource(Ref ref) =>
    UserFirestoreDataSourceImpl(
      ref.watch(firebaseAuthProvider),
      ref.watch(firestoreProvider),
    );

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(userFirestoreDataSourceProvider));
