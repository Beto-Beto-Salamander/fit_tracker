import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/lib.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<bool> isExisted(AuthParams params) async {
    final result = await _firestore
        .collection(UrlConstant.baseCollection)
        .where('email', isEqualTo: params.email)
        .limit(1)
        .get();
    if (result.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String getDocumentID(AuthParams params) {
    final result = _firestore.doc(
      "${UrlConstant.baseCollection}/${params.email}",
    );
    return result.id;
  }

  Future<String?> store(AuthParams params) async {
    if (await isExisted(params)) {
      return getDocumentID(params);
    } else {
      final result =
          await _firestore.collection(UrlConstant.baseCollection).add(
                UserModel(
                  email: params.email,
                  name: "",
                  gender: "",
                  dateOfBirth: "",
                  height: 0,
                  weightRecords: [],
                  password: params.password,
                ).toJson(),
              );

      return result.id;
    }
  }
}
