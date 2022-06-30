import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

class UserRepository with BaseRepository implements BaseUserRepository {
  final UserDataSource _userDataSource = UserDataSource();

  @override
  Future<Either<Failure, UserEntity?>> get(String params) async {
    return catchOrThrow(() async {
      final result = await _userDataSource.get(params);

      return result;
    });
  }

  @override
  Future<Either<Failure, void>> store(UserEntity params) async {
    return catchOrThrow(() async {
      await _userDataSource.store(params);
    });
  }

  @override
  Future<Either<Failure, void>> update(
    UserEntity params,
  ) async {
    return catchOrThrow(() async {
      await _userDataSource.update(params);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAll() async {
    return catchOrThrow(() async {
      await _userDataSource.deleteAll();
    });
  }

  @override
  Future<Either<Failure, void>> delete(String params) async {
    return catchOrThrow(() async {
      await _userDataSource.delete(params);
    });
  }
}
