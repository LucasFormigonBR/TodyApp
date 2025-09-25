import '../../repositories/auth_repository.dart';

class SendLinkToEmail {
  final AuthRepository authRepository;

  SendLinkToEmail(this.authRepository);

  Future<void> call(String email) async {
    await authRepository.sendLinkEmail(email);
  }
}
