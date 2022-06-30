import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

class AuthRepository with BaseRepository implements BaseAuthRepository {
  @override
  Future<Either<Failure, void>> signup(AuthParams params) async {
    return catchOrThrow(() async {
      await FirebaseServices().signUp(params);
    });
  }

  @override
  Future<Either<Failure, User>> login(AuthParams params) async {
    return catchOrThrow(() async {
      final result = await FirebaseServices().login(params);

      return result!;
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return catchOrThrow(() async {
       await FirebaseServices().logout();
    });
  }
}
