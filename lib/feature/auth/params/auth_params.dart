import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'AuthParams { email: $email, password: $password }';

  AuthParams copyWith({
    String? email,
    String? password,
  }) {
    return AuthParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;
}
