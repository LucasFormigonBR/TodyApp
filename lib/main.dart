import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'core/todyapp.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> initializeApp() async {
  await initializeFirebase();
  await initializeDependencies();

  runApp(TodyApp());
}

main() => initializeApp();
