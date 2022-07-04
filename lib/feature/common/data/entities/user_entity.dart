import 'package:equatable/equatable.dart';

import 'package:fit_tracker/feature/feature.dart';

class UserEntity extends Equatable {
  final String email;
  final String? name;
  final String? gender;
  final int? height;
  final String? dateOfBirth;
  final List<WeightRecordEntity>? weightRecords;

  const UserEntity({
    required this.email,
    this.name = "-",
    this.gender = "male",
    this.height = 0,
    this.dateOfBirth = "1000-00-00 00:00:00",
    this.weightRecords,
  });

  @override
  List<Object?> get props {
    return [
      email,
      name,
      gender,
      height,
      dateOfBirth,
      weightRecords,
    ];
  }

  UserEntity copyWith({
    String? email,
    String? name,
    String? gender,
    int? height,
    String? dateOfBirth,
    List<WeightRecordEntity>? weightRecords,
  }) {
    return UserEntity(
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weightRecords: weightRecords ?? this.weightRecords,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'height': height,
      'date_of_birth': dateOfBirth,
      'weight_records': weightRecords?.map((e) => e.toJson()),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
        email: map['email'] as String,
        name: map['name'] as String? ?? "-",
        gender: map['gender'] as String? ?? "-",
        height: map['height'] as int? ?? 0,
        dateOfBirth: map['date_of_birth'] as String? ?? "-",
        weightRecords: (map['weight_records'] as List?)
            ?.map(
              (e) => WeightRecordEntity.fromMap(e as Map<String, Object?>),
            )
            .toList());
  }

  @override
  bool get stringify => true;
}
