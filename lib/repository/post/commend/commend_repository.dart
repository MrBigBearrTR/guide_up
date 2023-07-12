import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/general/general_repository.dart';
import 'package:guide_up/core/models/post/commend/commend_model.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class CommendRepository extends GeneralRepository<Commend> {
  late final CollectionReference<Map<String, dynamic>> _commendCollections;

  CommendRepository() {
    _commendCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.postCommend);
  }

  @override
  Future<Commend> add(Commend model) async {
    model.dbCheck(model.getUserId()!);

    var process = await _commendCollections.add(model.toMap());

    model.setId(process.id);
    await _commendCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<void> delete(Commend model) async {
    await _commendCollections.doc(model.getId()!).delete();
  }

  @override
  Future<Commend?> get(String id) async {
    var query = await _commendCollections.doc(id).get();

    if (query.data() != null) {
      return Commend().toClass(query.data()!);
    }
    return null;
  }

  @override
  Future<List<Commend>> getList(String postId, int limit) async {
    List<Commend> commendList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _commendCollections
          .where("postId", isEqualTo: postId)
          .limit(limit)
          .get();
    } else {
      query =
          await _commendCollections.where("postId", isEqualTo: postId).get();
    }

    if (query.docs.isNotEmpty) {
      commendList = convertResponseObjectToList(query.docs.iterator);
    }

    return commendList;
  }

  Future<int> getPostCommendCount(String postId) async {
    int count = 0;

    QuerySnapshot<Map<String, dynamic>> query;

    query = await _commendCollections.where("postId", isEqualTo: postId).get();

    if (query.docs.isNotEmpty) {
      count = query.docs.length;
    }

    return count;
  }

  @override
  Future<void> update(Commend model) async {
    await _commendCollections.doc(model.getId()!).update(model.toMap());
  }

  Future<int> getUserPostListCountByUserId(String userId) async {
    int listCount = 0;
    var query =
        await _commendCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  List<Commend> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Commend> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Commend temp = Commend();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
