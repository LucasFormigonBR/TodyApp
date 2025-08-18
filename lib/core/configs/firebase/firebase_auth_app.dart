import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';
import '../error/firebase_auth_exceptions_messages.dart';

class FirebaseAuthApp {
  final firebaseAuth = sl<FirebaseAuth>();
  final prefs = sl<SharedPreferences>();

  bool isAuthenticationURI(Uri uri) {
    if (uri.host == 'todyapp-notes.firebaseapp.com' &&
        uri.path.startsWith('/__/auth/links')) {
      return true;
    }
    return false;
  }

  Future<bool> validateAuthenticationEmailLink(Uri uri) async {
    final emailLink = uri.toString();
    final link = uri.queryParameters['link'] ?? emailLink;
    final userEmail = prefs.getString('user_email') ?? "";

    try {
      if (firebaseAuth.isSignInWithEmailLink(link)) {
        final userCredential = await firebaseAuth.signInWithEmailLink(
          email: userEmail,
          emailLink: link,
        );
        final emailAddress = userCredential.user?.email ?? "";

        log(
          "Usuário autenticado com sucesso! E-mail do usuário: $emailAddress",
        );

        prefs.setBool('authenticated', true);

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      final message = FirebaseAuthExceptionsMessages.fromCode(e.code);
      log("Erro ao autenticar:", error: message);

      return false;
    } catch (e) {
      log("Erro desconhecido ao autenticar:", error: e);

      return false;
    }
  }
}
