import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

class WeightRecordRepository
    with BaseRepository
    implements BaseWeightRecordRepository {
  @override
  Future<Either<Failure, List<WeightRecordEntity>?>> get() async {
    return catchOrThrow(() async {
      final result = await FirestoreServices().getDocument();
      final user = UserModel.fromJson(result.docs.first.data());
      final weightRecords =
          user.weightRecords?.map((e) => e.toEntity()).toList();

      return weightRecords;
    });
  }

  @override
  Future<Either<Failure, List<WeightRecordEntity>?>> store(
      WeightRecordEntity params) async {
    return catchOrThrow(() async {
      await FirestoreServices().update(
        {
          "weight_records": FieldValue.arrayUnion([
            {
              "weight": params.weight,
              "recordedDate": params.recordedDate,
              "location": LocationCoordinateModel(
                latitude: params.location.latitude,
                longitude: params.location.longitude,
              ).toJson(),
            }
          ])
        },
        SetOptions(merge: true),
      );
      final result = await FirestoreServices().getDocument();
      final user = UserModel.fromJson(result.docs.first.data());
      final weightRecords =
          user.weightRecords?.map((e) => e.toEntity()).toList();

      return weightRecords;
    });
  }

  @override
  Future<Either<Failure, List<WeightRecordEntity>?>> update({
    required WeightRecordEntity oldValue,
    required WeightRecordEntity newValue,
  }) async {
    return catchOrThrow(() async {
      await FirestoreServices().delete(
        {
          "weight_records": FieldValue.arrayRemove([
            {
              "weight": oldValue.weight,
              "recordedDate": oldValue.recordedDate,
              "location": LocationCoordinateModel(
                latitude: oldValue.location.latitude,
                longitude: oldValue.location.longitude,
              ).toJson(),
            }
          ])
        },
      );

      await FirestoreServices().update(
        {
          "weight_records": FieldValue.arrayUnion([
            {
              "weight": newValue.weight,
              "recordedDate": newValue.recordedDate,
              "location": LocationCoordinateModel(
                latitude: newValue.location.latitude,
                longitude: newValue.location.longitude,
              ).toJson(),
            }
          ])
        },
        SetOptions(merge: true),
      );
      final result = await FirestoreServices().getDocument();
      final user = UserModel.fromJson(result.docs.first.data());
      final weightRecords =
          user.weightRecords?.map((e) => e.toEntity()).toList();

      return weightRecords;
    });
  }

  @override
  Future<Either<Failure, List<WeightRecordEntity>?>> delete(
      WeightRecordEntity params) async {
    return catchOrThrow(() async {
      await FirestoreServices().delete({
        "weight_records": FieldValue.arrayRemove([
          {
            "weight": params.weight,
            "recordedDate": params.recordedDate,
            "location": LocationCoordinateModel(
              latitude: params.location.latitude,
              longitude: params.location.longitude,
            ).toJson(),
          }
        ]),
      });
      final result = await FirestoreServices().getDocument();
      final user = UserModel.fromJson(result.docs.first.data());
      final weightRecords =
          user.weightRecords?.map((e) => e.toEntity()).toList();

      return weightRecords;
    });
  }
}
