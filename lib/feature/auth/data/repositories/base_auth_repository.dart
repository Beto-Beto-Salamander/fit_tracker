import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

abstract class BaseAuthRepository {

  Future<Either<Failure, void>> signup(AuthParams params);

  Future<Either<Failure, User>> login(AuthParams params);

  Future<Either<Failure, void>> logout();
}
