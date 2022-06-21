import 'package:equatable/equatable.dart';

import 'package:fit_tracker/lib.dart';

class WeightRecordEntity extends Equatable {
  final int weight;
  final String recordedDate;
  final LocationCoordinateEntity location;

  const WeightRecordEntity({
    required this.weight,
    required this.recordedDate,
    required this.location,
  });

  @override
  List<Object?> get props => [weight, recordedDate, location];

  WeightRecordEntity copyWith({
    int? weight,
    String? recordedDate,
    LocationCoordinateEntity? location,
  }) {
    return WeightRecordEntity(
      weight: weight ?? this.weight,
      recordedDate: recordedDate ?? this.recordedDate,
      location: location ?? this.location,
    );
  }

  @override
  bool get stringify => true;

}
