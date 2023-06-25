import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class UserDetailRepository {
  late final CollectionReference<Map<String, dynamic>> _userDetailCollections;

  UserDetailRepository() {
    _userDetailCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userDetail);
  }

  Future<UserDetail?> getUserByUserId(String userId) async {
    var query = await _userDetailCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      return UserDetail().toClass(query.docs.first.data());
    }
    return null;
  }

  Future<UserDetail?> getUserByAuthUid(String authUid) async {

    var userCollections =FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.user);


    var userQuery = await userCollections.where("id", isEqualTo: authUid).get();

    if(userQuery.docs.isNotEmpty) {

      var detailQuery = await _userDetailCollections.where("userId", isEqualTo: userQuery.docs.first.id)
          .get();

      if (detailQuery.docs.isNotEmpty) {
        return UserDetail().toClass(detailQuery.docs.first.data());
      }
    }
    return null;
  }
}
