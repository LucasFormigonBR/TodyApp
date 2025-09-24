import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_locator.dart';

class AppConfig {
  SharedPreferences get _prefs => sl<SharedPreferences>();

  /// Informações do usuário logado
  String get uid => _prefs.getString('uid') ?? "";
  String get name => _prefs.getString('name') ?? "";
  String get photo => _prefs.getString('photo') ?? "";

  /// Informações do App
  String get buildNumber => _prefs.get('build_number').toString();
  String get version => _prefs.get('version').toString();

  /// Data: Limites entre datas
  final firstDate = DateTime(2000, 1, 1);
  final lastDate = DateTime(2100);

  Future<void> userSaveData(UserCredential userCredential) async {
    await _prefs.setString('uid', userCredential.user?.uid ?? "");
    await _prefs.setString('name', userCredential.user?.displayName ?? "");
    await _prefs.setString('photo', userCredential.user?.photoURL ?? "");
  }

  Future<void> signOut() async {
    await _prefs.remove('uid');
    await _prefs.remove('name');
    await _prefs.remove('photo');
  }
}
