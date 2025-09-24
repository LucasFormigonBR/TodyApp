import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<void> sendLinkEmail(String email);
  Future<void> authenticateWithGoogle();
  Future<void> authenticateWithGithub();
  Future<Either<FirebaseException, Unit>> signOut();
}
