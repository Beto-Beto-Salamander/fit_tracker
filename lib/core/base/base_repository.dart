import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> catchOrThrow<T>(
    Future<T> Function() body,
  ) async {
    try {
      final data = await body();

      return Right(data);
    } on BaseException catch (e) {
      return Left(
        Failure(exception: e, message: e.message ?? MessageConstant.error),
      );
    } on FirebaseException catch (e) {
      return Left(
        Failure(
          exception: const BaseException(MessageConstant.error),
          message: e.message ?? MessageConstant.error,
        ),
      );
    }
  }
}
