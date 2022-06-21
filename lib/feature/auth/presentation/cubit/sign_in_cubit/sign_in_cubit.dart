import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(AuthParams params) async {
    try {
      emit(SignInLoading());

      bool isInputValid() {
        if (params.email.trim().isEmpty || params.password.trim().isEmpty) {
          emit(
            const SignInError(MessageConstant.emptyInputField),
          );
        } else if (params.password.trim().length < 8) {
          emit(
            const SignInError(MessageConstant.passwordLength),
          );
        } else {
          return true;
        }

        return false;
      }

      if (isInputValid()) {
        final user = await FirebaseServices().signIn(params);
        SignInLoaded(user!);
      }
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }
}
