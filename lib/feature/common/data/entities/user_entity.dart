import 'package:equatable/equatable.dart';

import 'package:fit_tracker/feature/feature.dart';

class UserEntity extends Equatable {
  final String email;
  final String password;
  final String? name;
  final String? gender;
  final int? height;
  final String? dateOfBirth;
  final List<WeightRecordEntity?> weightRecords;

  const UserEntity({
    required this.email,
    required this.password,
    this.name,
    this.gender,
    this.height,
    this.dateOfBirth,
    required this.weightRecords,
  });

  @override
  List<Object?> get props {
    return [
      email,
      password,
      name,
      gender,
      height,
      dateOfBirth,
      weightRecords,
    ];
  }

  UserEntity copyWith({
    String? email,
    String? password,
    String? name,
    String? gender,
    int? height,
    String? dateOfBirth,
    List<WeightRecordEntity?>? weightRecords,
  }) {
    return UserEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weightRecords: weightRecords ?? this.weightRecords,
    );
  }

  @override
  bool get stringify => true;
}
