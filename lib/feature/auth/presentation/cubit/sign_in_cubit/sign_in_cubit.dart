import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(AuthParams params) async {
    try {
      emit(SignInLoading());

      bool isInputValid() {
        if (params.email.isEmpty || params.password.isEmpty) {
          emit(
            const SignInError(MessageConstant.emptyInputField),
          );
        }
        if (params.password.trim().length < 8) {
          emit(
            const SignInError(MessageConstant.passwordLength),
          );
        } else {
          return false;
        }
        return true;
      }

      if (isInputValid()) {
        final result = await FirebaseServices().signIn(params);
        log(result.toString());
        emit(SignInLoaded());
      }
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }
}
