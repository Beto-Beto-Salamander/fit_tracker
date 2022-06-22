import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? currentUser() {
    return FirebaseAuth.instance.currentUser?.email;
  }

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

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
