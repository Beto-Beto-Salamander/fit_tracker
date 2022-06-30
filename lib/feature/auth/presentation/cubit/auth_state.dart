part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String? email;
  final UserEntity? user;
  final String? collectionId;
  final Failure? failure;

  const AuthLoaded({
    this.user,
    this.email,
    this.collectionId,
    this.failure,
  });

  @override
  List<Object?> get props => [email, user, collectionId, failure];
}

class AuthError extends AuthState {
  final Failure? failure;

  const AuthError({
    this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
