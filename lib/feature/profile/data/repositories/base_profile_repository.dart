import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseProfileRepository {
  Future<Either<Failure, UserEntity?>> get();

  Future<Either<Failure, String>> store(UserEntity user);
}
