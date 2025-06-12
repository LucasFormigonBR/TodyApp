import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todyapp/firebase_options.dart';

import 'core/todyapp.dart';

void initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() {
  initializeFirebase();
  runApp(TodyApp());
}
