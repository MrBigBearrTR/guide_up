import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/general/general_repository.dart';
import 'package:guide_up/core/models/users/user_token.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class UserTokenRepository extends GeneralRepository<UserToken> {
  late final CollectionReference<Map<String, dynamic>> _userTokenCollections;

  UserTokenRepository() {
    _userTokenCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userToken);
  }

  @override
  Future<UserToken> add(UserToken model) async {
    model.dbCheck(model.getUserId()!);

    var process = await _userTokenCollections.add(model.toMap());

    model.setId(process.id);
    await _userTokenCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<void> delete(UserToken model) async {
    model.setActive(false);
    _userTokenCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<UserToken?> get(String id) async {
    var query = await _userTokenCollections.doc(id).get();

    if (query.data() != null) {
      return UserToken().toClass(query.data()!);
    }
    return null;
  }

  Future<UserToken?> getUserTokenByUserId(String userId) async {
    var query =
        await _userTokenCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      return UserToken().toClass(query.docs.first.data());
    }
    return null;
  }

  @override
  Future<List<UserToken>> getList(String userId, int limit) async {
    throw UnimplementedError();
  }

  @override
  Future<UserToken> update(UserToken model) async {
    model.dbCheck(model.getUserId()!);
    await _userTokenCollections.doc(model.getId()!).update(model.toMap());
    return model;
  }
}
