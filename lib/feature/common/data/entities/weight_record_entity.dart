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

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'recorded_date': recordedDate,
      'location': location.toJson(),
    };
  }

  static WeightRecordEntity fromMap(Map<String, dynamic> map) {
    return WeightRecordEntity(
      weight: map['weight'] as int,
      recordedDate: map['recorded_date'] as String,
      location: LocationCoordinateEntity.fromMap(map['location'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

}
