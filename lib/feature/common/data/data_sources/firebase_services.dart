import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<User?> login(AuthParams params) async {
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

  Future<void> logout() async {
    await _auth.signOut();
  }
}
