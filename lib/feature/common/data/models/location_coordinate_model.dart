import 'package:fit_tracker/lib.dart';

class LocationCoordinateModel {
  double? latitude;
  double? longitude;

  LocationCoordinateModel({
    this.latitude,
    this.longitude,
  });

  @override
  String toString() =>
      'LocationCoordinateModel(latitude: $latitude, longitude: $longitude)';

  factory LocationCoordinateModel.fromJson(Map<String, dynamic> json) =>
      LocationCoordinateModel(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  LocationCoordinateEntity toEntity() => LocationCoordinateEntity(
        latitude: latitude,
        longitude: longitude,
      );
}
