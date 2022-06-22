import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker/lib.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getDocument() async {
    return await _firestore
        .collection(UrlConstant.baseCollection)
        .where('email', isEqualTo: FirebaseServices.currentUser())
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

  Future<UserModel> get() async {
    final result = await getDocument();
    final user = UserModel.fromJson(result.docs.first.data());

    return user;
  }

  Future<String?> store(StoreParams params) async {
    if (!await isExist()) {
      final result =
          await _firestore.collection(UrlConstant.baseCollection).add({
        "email": FirebaseServices.currentUser(),
        "name": params.user.name,
        "gender": params.user.gender,
        "date_of_birth": params.user.dateOfBirth,
        "height": params.user.height,
        "weight_records": params.user.weightRecords
            ?.map(
              (e) => WeightRecordModel(
                weight: e.weight,
                recordedDate: e.recordedDate,
                location: LocationCoordinateModel(
                  latitude: e.location.latitude,
                  longitude: e.location.longitude,
                ),
              ).toJson(),
            )
            .toList(),
      });
      return result.id;
    } else {
      await _firestore
          .collection(UrlConstant.baseCollection)
          .doc(await getDocumentID())
          .set(
        {
          "email": params.user.email,
          "name": params.user.name,
          "gender": params.user.gender,
          "date_of_birth": params.user.dateOfBirth,
          "height": params.user.height,
        },
        SetOptions(merge: true),
      );

      return getDocumentID();
    }
  }

  Future<void> storeWeight(StoreWeightParams params) async {
    await _firestore
        .collection(UrlConstant.baseCollection)
        .doc(await getDocumentID())
        .set(
      {
        "weight_records": FieldValue.arrayUnion([
          {
            "weight": params.data.weight,
            "recordedDate": params.data.recordedDate,
            "location": LocationCoordinateModel(
              latitude: params.data.location.latitude,
              longitude: params.data.location.longitude,
            ).toJson(),
          }
        ])
      },
      SetOptions(merge: true),
    );
  }

  Future<void> deleteWeight(DeleteWeightParams params) async {
    return _firestore
        .collection(UrlConstant.baseCollection)
        .doc(await getDocumentID())
        .update(
      {
        "weight_records": FieldValue.arrayRemove([
          {
            "weight": params.data.weight,
            "recordedDate": params.data.recordedDate,
            "location": LocationCoordinateModel(
              latitude: params.data.location.latitude,
              longitude: params.data.location.longitude,
            ).toJson(),
          }
        ]),
      },
    );
  }
}
