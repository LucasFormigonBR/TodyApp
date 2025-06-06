import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_services.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService api;

  AuthRepositoryImpl(this.api);

  @override
  Future<User> login(String email, String password) async {
    final data = await api.login(email, password);
    //final user = UserModel.fromJson(data);
    return User(email: data.email, name: data.name);
  }
}
