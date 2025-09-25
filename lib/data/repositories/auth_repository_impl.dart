import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/domain/repositories/auth_repository.dart';

import '../../core/service_locator.dart';
import '../datasources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  final _prefs = sl<SharedPreferences>();
  final appConfig = sl<AppConfig>();

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> sendLinkEmail(String email) async {
    try {
      await dataSource.sendLinkEmail(email);
      await _prefs.setString("user_email", email);
    } catch (e) {
      throw Exception('Falha ao enviar o link de e-mail: $e');
    }
  }

  @override
  Future<void> authenticateWithGoogle() async {
    try {
      final googleUser = await dataSource.authenticateWithGoogle();

      await appConfig.userSaveData(googleUser);
      await _prefs.setBool('authenticated', true);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> authenticateWithGithub() async {
    try {
      final githubUser = await dataSource.authenticateWithGithub();

      await appConfig.userSaveData(githubUser);
      await _prefs.setBool('authenticated', true);
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw "Houve um erro ao autenticar com o Github: $e";
    }
  }

  @override
  Future<Either<FirebaseAuthException, Unit>> signOut() async {
    try {
      await dataSource.signOut();
      return Right(unit);
    } catch (e) {
      throw Left(e);
    }
  }
}
