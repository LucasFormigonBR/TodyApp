import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/domain/repositories/auth_repository.dart';

import '../../core/service_locator.dart';
import '../datasources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  final _prefs = sl<SharedPreferences>();

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> sendLinkEmail(String email) async {
    try {
      await dataSource.sendLinkEmail(email);
      _prefs.setString("user_email", email);
    } catch (e) {
      throw Exception('Falha ao enviar o link de e-mail: $e');
    }
  }

  @override
  Future<void> authenticateWithGoogle() async {
    try {
      final googleUser = await dataSource.authenticateWithGoogle();
      if (googleUser.user?.emailVerified ?? false) {
        final uidUser = googleUser.user?.uid ?? "";
        final emailUser = googleUser.user?.email ?? "";

        _prefs.setString("uid", uidUser);
        _prefs.setString("user_email", emailUser);
        _prefs.setBool('authenticated', true);
        return;
      }
      await googleUser.user?.delete();
      Exception("Email não verificado");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> authenticateWithGithub() async {
    try {
      final githubUser = await dataSource.authenticateWithGithub();
      final emailUser = githubUser.user?.email ?? "";
      final uidUser = githubUser.user?.uid ?? "";

      _prefs.setString("uid", uidUser);
      _prefs.setString('user_email', emailUser);
      _prefs.setBool('authenticated', true);
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw "Houve um erro ao autenticar com o Github: $e";
    }
  }
}
