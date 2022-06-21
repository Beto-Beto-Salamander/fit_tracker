import 'package:fit_tracker/lib.dart';

class UserModel {
  final String email;
  final String password;
  final String? name;
  final String? gender;
  final int? height;
  final String? dateOfBirth;
  final List<WeightRecordModel>? weightRecords;

  const UserModel({
    required this.email,
    required this.password,
    this.name,
    this.gender,
    this.height,
    this.dateOfBirth,
    this.weightRecords,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] as String,
        password: json["password"] as String,
        name: json["name"] as String? ?? "-",
        gender: json["gender"] as String? ?? "-",
        dateOfBirth: json['date_of_birth'] as String? ?? "-",
        height: json["height"] as int? ?? 0,
        weightRecords: (json["weight_records"] as List)
            .map((e) => WeightRecordModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "height" : height,
        "weight_records" :  weightRecords?.map((e) => e.toJson()),
      };
}
