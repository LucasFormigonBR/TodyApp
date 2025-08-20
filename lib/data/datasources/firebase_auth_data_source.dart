import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todyapp/core/configs/constants/firebase_tokens.dart';

import '../../core/service_locator.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = sl<GoogleSignIn>();

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

  Future<UserCredential> authenticateWithGoogle() async {
    _googleSignIn.initialize(serverClientId: FirebaseTokens.serverClientId);

    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
}
