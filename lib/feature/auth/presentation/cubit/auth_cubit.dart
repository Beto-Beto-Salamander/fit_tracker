import 'package:equatable/equatable.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(AuthParams params) async {
    emit(AuthLoading());

    final response = await _authRepository.login(params);

    response.fold(
      (failure) {
        emit(AuthError(failure: failure));
      },
      (user) async {
        await sl<UserCubit>().deleteAll();
        await sl<UserCubit>().store(
          UserEntity(email: user.email!),
        );
        final currentState = sl<UserCubit>().state;
        sl<UserCubit>().emit(
          currentState.copyWith(email: user.email),
        );
        emit(AuthLoaded(email: user.email));
      },
    );
  }

  Future<void> signup(AuthParams params) async {
    emit(AuthLoading());

    final response = await _authRepository.signup(params);

    response.fold(
      (failure) {
        emit(AuthError(failure: failure));
      },
      (_) {
        emit(const AuthLoaded());
      },
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();

    await sl<UserCubit>().deleteAll();
  }
}
