import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/domain/repositories/auth_repository.dart';

import '../../core/service_locator.dart';
import '../datasources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> sendLinkEmail(String email) async {
    try {
      await dataSource.sendLinkEmail(email);
      final prefs = sl<SharedPreferences>();
      prefs.setString("user_email", email);
    } catch (e) {
      throw Exception('Falha ao enviar o link de e-mail: $e');
    }
  }
}
