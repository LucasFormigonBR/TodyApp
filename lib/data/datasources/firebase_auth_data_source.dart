import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<void> sendLinkEmail(String email) async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://todyapp-notes.firebaseapp.com',
        handleCodeInApp: true,
        iOSBundleId: 'com.example.todyapp',
        androidPackageName: 'com.example.todyapp',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}
