class FirebaseAuthExceptionsMessages {
  static String fromCode(String code) {
    switch (code) {
      case 'invalid-action-code':
        return 'O código de ação fornecido é inválido ou expirou.';
      case 'invalid-email':
        return 'O e-mail informado é inválido.';
      case 'user-disabled':
        return 'Esta conta foi desativada. Entre em contato com o suporte.';
      case 'user-not-found':
        return 'Nenhuma conta encontrada com este e-mail.';
      case 'wrong-password':
        return 'Senha incorreta. Tente novamente.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde um momento antes de tentar novamente.';
      case 'operation-not-allowed':
        return 'Operação não permitida. Verifique as configurações do Firebase.';
      case 'account-exists-with-different-credential':
        return 'Já existe uma conta com este e-mail. Tente fazer login com outro método.';
      default:
        return 'Ocorreu um erro ao entrar. Tente novamente.';
    }
  }
}
