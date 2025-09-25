import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/configs/functions/validate_initial_route.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'core/todyapp.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> initiazeInfoApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final prefs = sl<SharedPreferences>();
  prefs.setString('build_number', packageInfo.buildNumber);
  prefs.setString('version', packageInfo.version);
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await initializeFirebase();
  await initiazeInfoApp();
  validateInitialRoute();

  runApp(TodyApp());
}

main() => initializeApp();
