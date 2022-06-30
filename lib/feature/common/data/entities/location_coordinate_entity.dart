import 'package:equatable/equatable.dart';

class LocationCoordinateEntity extends Equatable {
  final double? latitude;
  final double? longitude;

  const LocationCoordinateEntity({
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];

  LocationCoordinateEntity copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LocationCoordinateEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static LocationCoordinateEntity fromMap(Map<String, dynamic> map) {
    return LocationCoordinateEntity(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  @override
  bool get stringify => true;
}
