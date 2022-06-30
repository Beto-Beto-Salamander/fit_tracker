import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> catchOrThrow<T>(
    Future<T> Function() body,
  ) async {
    try {
      final data = await body();
      return Right(data);
    } on BaseException catch (e) {
      throw BaseException(e.message);
    }
  }
}
