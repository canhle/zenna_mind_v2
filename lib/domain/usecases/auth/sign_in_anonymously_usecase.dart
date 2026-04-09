import 'package:flutter_clean_template/domain/entities/user_profile.dart';
import 'package:flutter_clean_template/domain/repositories/auth_repository.dart';

class SignInAnonymouslyUseCase {
  const SignInAnonymouslyUseCase(this._repo);

  final AuthRepository _repo;

  Future<UserProfile> call() => _repo.signInAnonymouslyAndBootstrap();
}
