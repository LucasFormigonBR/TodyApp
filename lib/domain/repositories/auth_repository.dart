abstract class AuthRepository {
  Future<void> sendLinkEmail(String email);
  Future<void> authenticateWithGoogle();
  Future<void> authenticateWithGithub();
}
