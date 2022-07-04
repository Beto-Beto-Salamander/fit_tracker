import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:fit_tracker/lib.dart';

class ProfileRepository with BaseRepository implements BaseProfileRepository {
  @override
  Future<Either<Failure, UserEntity?>> get() async {
    return catchOrThrow(() async {
      if (await FirestoreServices().isExist()) {
        final result = await FirestoreServices().getDocument();
        final user = UserModel.fromJson(result.docs.first.data()).toEntity();

        return user;
      } else {
        return null;
      }
    });
  }

  @override
  Future<Either<Failure, String>> store(UserEntity params) async {
    return catchOrThrow(() async {
      if (!await FirestoreServices().isExist()) {
        final result = await FirestoreServices().store({
          "email": FirebaseServices.currentUser()?.email ?? "",
          "name": params.name,
          "gender": params.gender,
          "date_of_birth": params.dateOfBirth,
          "height": params.height,
        });
        return result.id;
      } else {
        await FirestoreServices().update(
          {
            "email": params.email,
            "name": params.name,
            "gender": params.gender,
            "date_of_birth": params.dateOfBirth,
            "height": params.height,
          },
          SetOptions(merge: true),
        );

        return await FirestoreServices().getDocumentID();
      }
    });
  }
}
