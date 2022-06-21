import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/feature/auth/params/auth_params.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(AuthParams params) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    return result.user;
  }

   Future<UserCredential?> signUp(AuthParams params) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    return result;
  }
}
