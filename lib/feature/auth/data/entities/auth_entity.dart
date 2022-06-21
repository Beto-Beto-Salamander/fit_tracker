import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String email;
  final String password;

  const AuthEntity({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'AuthEntity { email: $email, password: $password }';

  AuthEntity copyWith({
    String? email,
    String? password,
  }) {
    return AuthEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;
}
