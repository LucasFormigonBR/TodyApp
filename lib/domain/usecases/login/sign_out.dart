import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todyapp/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository _authRepository;
  SignOut(this._authRepository);

  Future<Either<FirebaseException, Unit>> call() async =>
      await _authRepository.signOut();
}
