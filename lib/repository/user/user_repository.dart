import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class UserRepository {
  late final CollectionReference<Map<String, dynamic>> userCollections;

  UserRepository() {
    userCollections =
        FirebaseFirestore.instance.collection(FirestoreCollectionConstant.user);
  }
  Future<String> add(UserModel userModel) async {
    userModel.dbCheck('admin');

    var process = await userCollections.add(userModel.toMap());

    return process.id;
  }

  Future<UserModel?> getUserByUid(String uid) async {
    var query = await userCollections.where("id", isEqualTo: uid).get();

    if (query.docs.isNotEmpty) {
      return UserModel().toClass(query.docs.first.data());
    }
    return null;
  }

  Future<String?> getUserIdByUid(String uid) async {
    var query = await userCollections.where("id", isEqualTo: uid).get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    }
    return null;
  }

  Future<UserModel?> getUserByUserId(String userId) async {
    var query = await userCollections.doc(userId).get();

    if (query.data() != null) {
      return UserModel().toClass(query.data()!);
    }
    return null;
  }
}
