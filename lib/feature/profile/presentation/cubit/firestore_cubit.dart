import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';

part 'firestore_state.dart';

class FirestoreCubit extends Cubit<FirestoreState> {
  FirestoreCubit() : super(FirestoreInitial());

  Future<void> store(StoreParams params) async {
    try {
      emit(FirestoreLoading());

      bool isValidInput() {
        if (params.user.email.trim().isEmpty ||
            params.user.name!.trim().isEmpty ||
            params.user.gender!.trim().isEmpty ||
            params.user.dateOfBirth!.trim().isEmpty ||
            params.user.height!.toString().trim().isEmpty) {
          emit(
            const FirestoreError(MessageConstant.emptyInputField),
          );
        } else if (params.user.height! <= 0) {
          emit(
            const FirestoreError(MessageConstant.heightInvalid),
          );
        } else {
          return true;
        }

        return false;
      }

      if (isValidInput()) {
        await FirestoreServices().store(params);
        final result = await FirestoreServices().get();
        final entity = result.toEntity();
        emit(
          FirestoreLoaded(user: entity),
        );
      } else {
        emit(
          const FirestoreError(MessageConstant.error),
        );
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      emit(FirestoreError(e.message.toString()));
    }
  }

  Future<void> storeWeight(StoreWeightParams params) async {
    try {
      emit(FirestoreLoading());
      await FirestoreServices().storeWeight(params);
      final result = await FirestoreServices().get();
      final entity = result.toEntity();
      emit(
        FirestoreLoaded(user: entity),
      );
    } on FirebaseException catch (e) {
      log(e.toString());
      emit(FirestoreError(e.message.toString()));
    }
  }

  Future<void> get() async {
    try {
      emit(FirestoreLoading());
      if (await FirestoreServices().isExist()) {
        final result = await FirestoreServices().get();
        final entity = result.toEntity();
        emit(
          FirestoreLoaded(user: entity),
        );
      } else {
        emit(
          const FirestoreError(MessageConstant.error),
        );
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      emit(FirestoreError(e.message.toString()));
    }
  }

  Future<void> deleteWeight(DeleteWeightParams params) async {
    try {
      emit(FirestoreLoading());
      if (await FirestoreServices().isExist()) {
        await FirestoreServices().deleteWeight(params);
        final result = await FirestoreServices().get();
        final entity = result.toEntity();
        emit(
          FirestoreLoaded(user: entity),
        );
      } else {
        emit(
          const FirestoreError(MessageConstant.error),
        );
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      emit(FirestoreError(e.message.toString()));
    }
  }

  Future<void> updateWeight(WeightRecordEntity oldValue, WeightRecordEntity newValue) async {
    try {
      emit(FirestoreLoading());
      if (await FirestoreServices().isExist()) {
        await FirestoreServices().deleteWeight(
          DeleteWeightParams(data: oldValue),
        );
        await FirestoreServices().storeWeight(
          StoreWeightParams(
            data: newValue,
          ),
        );
        final result = await FirestoreServices().get();
        final entity = result.toEntity();
        emit(
          FirestoreLoaded(user: entity),
        );
      } else {
        emit(
          const FirestoreError(MessageConstant.error),
        );
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      emit(FirestoreError(e.message.toString()));
    }
  }
}
