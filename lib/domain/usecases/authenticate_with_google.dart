import 'package:todyapp/domain/repositories/auth_repository.dart';

class AuthenticateWithGoogle {
  final AuthRepository _authRepository;
  AuthenticateWithGoogle(this._authRepository);

  Future<void> call() async => _authRepository.authenticateWithGoogle();
}
