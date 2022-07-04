import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getDocument() async {
    return await _firestore
        .collection(UrlConstant.baseCollection)
        .where('email', isEqualTo: sl<UserCubit>().state.email)
        .limit(1)
        .get();
  }

  Future<bool> isExist() async {
    final result = await getDocument();
    if (result.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getDocumentID() async {
    final result = await getDocument();
    return result.docs.first.id;
  }

  Future<DocumentReference<Map<String, dynamic>>> store(
      Map<String, Object?> params) async {
    final result =
        await _firestore.collection(UrlConstant.baseCollection).add(params);
    return result;
  }

  Future<void> update(
      Map<String, Object?> params, SetOptions setOptions) async {
    await _firestore
        .collection(UrlConstant.baseCollection)
        .doc(await getDocumentID())
        .set(params, setOptions);
  }

  Future<void> delete(Map<String, Object?> params) async {
    return _firestore
        .collection(UrlConstant.baseCollection)
        .doc(await getDocumentID())
        .update(params);
  }
}
