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
      (user) {
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(user: user),
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
      (collectionId) {
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(user: params),
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
      (collectionId) {
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(user: params),
        );
        emit(ProfileLoaded(collectionId: collectionId));
      },
    );
  }
}
