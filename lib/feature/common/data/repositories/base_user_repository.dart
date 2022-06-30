import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseUserRepository {
  Future<Either<Failure, UserEntity?>> get(String params);

  Future<Either<Failure, void>> store(UserEntity params);

  Future<Either<Failure,void>> delete(String params);

  Future<Either<Failure,void>> deleteAll();

  Future<Either<Failure,void>> update(UserEntity params);
}
