part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String? email;
  final UserEntity? user;
  final String? collectionId;
  final Failure? failure;

  const ProfileLoaded({
    this.user,
    this.email,
    this.collectionId,
    this.failure,
  });

  @override
  List<Object?> get props => [email, user, collectionId, failure];
}

class ProfileError extends ProfileState {
  final Failure? failure;

  const ProfileError({
    this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
