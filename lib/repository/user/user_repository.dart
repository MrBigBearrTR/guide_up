import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class UserRepository{
  late final CollectionReference<Map<String, dynamic>> userCollections;

  UserRepository() {
    userCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.user);
  }

  Future<UserModel?> getUserByUid(String uid) async {

    var query = await userCollections.where("id",isEqualTo: uid).get();

    if(query.docs.isNotEmpty){

      return UserModel().toClass(query.docs.first.data());
    }
    return null;
  }
}