part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {
  final User user;

  const SignInLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class SignInError extends SignInState {
  final String message;

  const SignInError(this.message);

  @override
  List<Object> get props => [message];
}
