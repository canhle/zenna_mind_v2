import 'package:flutter_clean_template/domain/entities/user_profile.dart';
import 'package:flutter_clean_template/domain/repositories/auth_repository.dart';

class WatchCurrentUserUseCase {
  const WatchCurrentUserUseCase(this._repo);

  final AuthRepository _repo;

  Stream<UserProfile?> call() => _repo.watchCurrentUser();
}
