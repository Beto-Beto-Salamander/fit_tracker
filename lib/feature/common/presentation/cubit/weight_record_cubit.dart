import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'weight_record_state.dart';

class WeightRecordCubit extends Cubit<WeightRecordState> {
  final WeightRecordRepository _weightRecordRepository;

  WeightRecordCubit(this._weightRecordRepository)
      : super(WeightRecordInitial());

  Future<void> get() async {
    emit(WeightRecordLoading());

    final response = await _weightRecordRepository.get();

    response.fold(
      (failure) {
        emit(WeightRecordError(failure: failure));
      },
      (record) {
        emit(WeightRecordLoaded(weightRecords: record));
      },
    );
  }

  Future<void> store(WeightRecordEntity params) async {
    emit(WeightRecordLoading());

    final response = await _weightRecordRepository.store(params);

    response.fold(
      (failure) {
        emit(WeightRecordError(failure: failure));
      },
      (record) {
        emit(WeightRecordLoaded(weightRecords: record));
      },
    );
  }

  Future<void> update(
      {required WeightRecordEntity oldValue,
      required WeightRecordEntity newValue}) async {
    emit(WeightRecordLoading());

    final response = await _weightRecordRepository.update(
        oldValue: oldValue, newValue: newValue);

    response.fold(
      (failure) {
        emit(WeightRecordError(failure: failure));
      },
      (record) {
        emit(WeightRecordLoaded(weightRecords: record));
      },
    );
  }

  Future<void> delete(WeightRecordEntity params) async {
    emit(WeightRecordLoading());

    final response = await _weightRecordRepository.delete(params);

    response.fold(
      (failure) {
        emit(WeightRecordError(failure: failure));
      },
      (record) {
        emit(WeightRecordLoaded(weightRecords: record));
      },
    );
  }
}
