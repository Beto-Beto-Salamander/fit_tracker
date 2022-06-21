import 'package:fit_tracker/lib.dart';

class WeightRecordModel {
  final int weight;
  final String recordedDate;
  final LocationCoordinateModel location;

  const WeightRecordModel({
    required this.weight,
    required this.recordedDate,
    required this.location,
  });

  factory WeightRecordModel.fromJson(Map<String, dynamic> json) {
    return WeightRecordModel(
      weight: json['weight'] as int ,
      recordedDate: json['recordedDate'] as String,
      location: LocationCoordinateModel.fromJson(
          json['location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'recordedDate': recordedDate,
      'location': location.toJson(),
    };
  }

  WeightRecordEntity toEntity() {
    return WeightRecordEntity(
      weight: weight,
      recordedDate: recordedDate,
      location: location.toEntity(),
    );
  }
}
