import 'package:equatable/equatable.dart';

import 'package:fit_tracker/lib.dart';

class StoreWeightParams extends Equatable {
  final WeightRecordEntity data;

  const StoreWeightParams({ required this.data});

  @override
  List<Object> get props => [ data];


  StoreWeightParams copyWith({
    WeightRecordEntity? data,
  }) {
    return StoreWeightParams(
      
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

}
