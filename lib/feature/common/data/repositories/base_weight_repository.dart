import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseWeightRecordRepository {
  Future<Either<Failure, List<WeightRecordEntity>?>> get();

  Future<Either<Failure, void>> store(WeightRecordEntity weightRecord);

  Future<Either<Failure,List<WeightRecordEntity>?>> delete(WeightRecordEntity weightRecord);

  Future<Either<Failure,List<WeightRecordEntity>?>> update({required WeightRecordEntity oldValue, required WeightRecordEntity newValue});
}
