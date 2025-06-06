import '../models/user.dart';

abstract class AuthService {
  Future<UserModel> login(String email, String password);
}
