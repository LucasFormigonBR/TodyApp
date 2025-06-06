import '../../domain/entities/user.dart';

class UserModel {
  final String email;
  final String name;

  UserModel({required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  factory UserModel.toJson(User user) {
    return UserModel(email: user.email, name: user.name);
  }

  User toEntity() {
    return User(email: email, name: name);
  }
}
