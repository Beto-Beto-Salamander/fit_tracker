part of 'user_cubit.dart';

class UserState extends Equatable {
  final String? email;
  final UserEntity? user;
  final String? collectionId;
  final bool? isLoading;
  final Failure? failure;

  const UserState({
    this.user,
    this.email,
    this.collectionId,
    this.isLoading = false,
    this.failure,
  });

  @override
  List<Object?> get props => [email, user, collectionId, isLoading, failure];

  UserState copyWith({
    String? email,
    UserEntity? user,
    String? collectionId,
    bool? isLoading,
    Failure? failure,
  }) {
    return UserState(
      email: email ?? this.email,
      user: user ?? this.user,
      collectionId: collectionId ?? this.collectionId,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      user: map['user'] != null
          ? UserEntity.fromMap(map['user'] as Map<String, Object?>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toJson(),
    };
  }

  @override
  bool get stringify => true;
}
