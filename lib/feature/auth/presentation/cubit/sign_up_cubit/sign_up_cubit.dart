import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(AuthParams params) async {
    try {
      emit(SignUpLoading());
      final result = await FirebaseServices().signUp(params);
      log(result.toString());
      emit(SignUpLoaded());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
