import 'package:equatable/equatable.dart';

import 'package:fit_tracker/lib.dart';

class DeleteWeightParams extends Equatable {
  final WeightRecordEntity data;

  const DeleteWeightParams({required this.data});

  @override
  List<Object> get props => [data];

  DeleteWeightParams copyWith({
    WeightRecordEntity? data,
  }) {
    return DeleteWeightParams(
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;
}
