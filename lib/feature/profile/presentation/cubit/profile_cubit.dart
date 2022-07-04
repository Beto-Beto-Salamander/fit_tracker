import 'package:equatable/equatable.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> get() async {
    emit(ProfileLoading());

    final response = await _profileRepository.get();

    response.fold(
      (failure) {
        emit(ProfileError(failure: failure));
      },
      (user) async {
        await sl<UserCubit>().delete(user?.email ?? "");
        await sl<UserCubit>().store(
          UserEntity(email: user?.email ?? ""),
        );
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(email: user?.email, user: user),
        );
        emit(ProfileLoaded(user: user));
      },
    );
  }

  Future<void> update(UserEntity params) async {
    emit(ProfileLoading());

    final response = await _profileRepository.store(params);

    response.fold(
      (failure) {
        emit(ProfileError(failure: failure));
      },
      (collectionId) async {
        await sl<UserCubit>().delete(params.email);
        await sl<UserCubit>().store(
          UserEntity(email: params.email),
        );
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(email: params.email, user: params),
        );
        emit(ProfileLoaded(collectionId: collectionId));
      },
    );
  }

  Future<void> store(UserEntity params) async {
    emit(ProfileLoading());

    final response = await _profileRepository.store(params);

    response.fold(
      (failure) {
        emit(ProfileError(failure: failure));
      },
      (collectionId) async {
        await sl<UserCubit>().delete(params.email);
        await sl<UserCubit>().store(
          UserEntity(email: params.email),
        );
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(email: params.email, user: params),
        );
        emit(ProfileLoaded(collectionId: collectionId));
      },
    );
  }
}
