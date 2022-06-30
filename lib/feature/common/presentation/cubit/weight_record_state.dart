part of 'weight_record_cubit.dart';

class WeightRecordState extends Equatable {
  const WeightRecordState();

  @override
  List<Object?> get props => [];
}

class WeightRecordInitial extends WeightRecordState {}

class WeightRecordLoading extends WeightRecordState {}

class WeightRecordLoaded extends WeightRecordState {
  final List<WeightRecordEntity>? weightRecords;

  const WeightRecordLoaded({
    this.weightRecords,
  });

  @override
  List<Object?> get props => [weightRecords];
}

class WeightRecordError extends WeightRecordState {
  final Failure? failure;

  const WeightRecordError({
    this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
