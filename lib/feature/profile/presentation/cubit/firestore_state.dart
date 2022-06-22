part of 'firestore_cubit.dart';

abstract class FirestoreState extends Equatable {
  const FirestoreState();

  @override
  List<Object?> get props => [];
}

class FirestoreInitial extends FirestoreState {}

class FirestoreLoading extends FirestoreState {}

class FirestoreLoaded extends FirestoreState {
  final UserEntity? user;

  const FirestoreLoaded({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class FirestoreError extends FirestoreState {
  final String message;

  const FirestoreError(this.message);

  @override
  List<Object> get props => [message];
}
