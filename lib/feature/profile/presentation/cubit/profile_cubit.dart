import 'package:equatable/equatable.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> get(String params) async {
    emit(ProfileLoading());

    final currentState = sl<UserCubit>().state;

    sl<UserCubit>().emit(
      currentState.copyWith(email: params),
    );

    final response = await _profileRepository.get();

    response.fold(
      (failure) {
        emit(ProfileError(failure: failure));
      },
      (user) async {
        await sl<UserCubit>().store(
          UserEntity(email: params),
        );

        if (user != null) {
          sl<UserCubit>().emit(
            currentState.copyWith(email: user.email, user: user),
          );
        } else {
          sl<UserCubit>().emit(
            currentState.copyWith(
              email: params,
              user: UserEntity(email: params),
            ),
          );
        }

        emit(ProfileLoaded(
          user: sl<UserCubit>().state.user,
        ));
      },
    );
  }

  Future<void> update(UserEntity params) async {
    emit(ProfileLoading());

    bool isInputValid() {
      if (params.gender.toString().trim().isEmpty ||
          params.dateOfBirth.toString().trim().isEmpty ||
          params.name.toString().trim().isEmpty ||
          (params.height ?? 0) <= 0 ||
          params.height == null) {
        return false;
      } else {
        return true;
      }
    }

    if (isInputValid()) {
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
    } else {
      emit(
        const ProfileError(
          failure: Failure(message: MessageConstant.error),
        ),
      );
    }
  }

  Future<void> store(UserEntity params) async {
    emit(ProfileLoading());

    bool isInputValid() {
      if (params.gender.toString().trim().isEmpty ||
          params.dateOfBirth.toString().trim().isEmpty ||
          params.name.toString().trim().isEmpty ||
          (params.height ?? 0) <= 0 ||
          params.height == null) {
        return false;
      } else {
        return true;
      }
    }

    if (isInputValid()) {
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
    } else {
      emit(
        const ProfileError(
          failure: Failure(message: MessageConstant.error),
        ),
      );
    }
  }
}
