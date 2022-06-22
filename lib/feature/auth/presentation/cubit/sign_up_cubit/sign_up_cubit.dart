import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(AuthParams params) async {
    try {
      emit(SignUpLoading());
      bool isInputValid() {
        if (params.email.trim().isEmpty || params.password.trim().isEmpty) {
          emit(
            const SignUpError(MessageConstant.emptyInputField),
          );
        } else if (params.password.trim().length < 8) {
          emit(
            const SignUpError(MessageConstant.passwordLength),
          );
        } else {
          return true;
        }

        return false;
      }

      if (isInputValid()) {
        await FirebaseServices().signUp(params);
        emit(SignUpLoaded());
      }
    } on FirebaseAuthException catch (e) {
      
      emit(SignUpError(e.message.toString()));
    }
  }
}
