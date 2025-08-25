import 'package:todyapp/domain/repositories/auth_repository.dart';

class AuthenticateWithGithub {
  final AuthRepository _authRepository;

  AuthenticateWithGithub(this._authRepository);
  Future<void> call() async {
    await _authRepository.authenticateWithGithub();
  }
}
