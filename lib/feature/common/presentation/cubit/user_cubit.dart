import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserState());

  Future<void> get(String params) async {
    emit(state.copyWith(isLoading: true));

    final response = await _userRepository.get(params);

    emit(
      response.fold(
        (failure) => state.copyWith(failure: failure),
        (user) => state.copyWith(user: user),
      ),
    );
  }

  Future<void> store(UserEntity params) async {
    emit(state.copyWith(isLoading: true));

    final response = await _userRepository.store(params);

    emit(
      response.fold(
        (failure) => state.copyWith(failure: failure),
        (response) {
          return state.copyWith();
        },
      ),
    );
  }

  Future<void> deleteAll() async {
    emit(state.copyWith(isLoading: true));

    final response = await _userRepository.deleteAll();

    emit(
      response.fold(
        (failure) => state.copyWith(failure: failure),
        (response) {
          return state.copyWith();
        },
      ),
    );
  }

  Future<void> delete(String params) async {
    emit(state.copyWith(isLoading: true));

    final response = await _userRepository.delete(params);

    emit(
      response.fold(
        (failure) => state.copyWith(failure: failure),
        (response) {
          return state.copyWith();
        },
      ),
    );
  }

  Future<void> update(UserEntity params) async {
    emit(state.copyWith(isLoading: true));

    final response = await _userRepository.update(params);

    emit(
      response.fold(
        (failure) => state.copyWith(failure: failure),
        (response) {
          return state.copyWith();
        },
      ),
    );
  }
}
