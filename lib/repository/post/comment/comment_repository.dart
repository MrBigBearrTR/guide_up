import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/general/general_repository.dart';
import 'package:guide_up/core/models/post/commend/commend_model.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class CommentRepository extends GeneralRepository<Comment> {
  late final CollectionReference<Map<String, dynamic>> _commentCollections;

  CommentRepository() {
    _commentCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.postComment);
  }

  @override
  Future<Comment> add(Comment model) async {
    model.dbCheck(model.getUserId()!);

    var process = await _commentCollections.add(model.toMap());

    model.setId(process.id);
    await _commentCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<void> delete(Comment model) async {
    model.setActive(false);
    await _commentCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<Comment?> get(String id) async {
    var query = await _commentCollections.doc(id).get();

    if (query.data() != null) {
      return Comment().toClass(query.data()!);
    }
    return null;
  }

  @override
  Future<List<Comment>> getList(String postId, int limit) async {
    List<Comment> commendList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _commentCollections
          .where("postId", isEqualTo: postId)
          .where("isActive", isEqualTo: true)
          .limit(limit)
          .orderBy("createDate", descending: true)
          .get();
    } else {
      query = await _commentCollections
          .where("postId", isEqualTo: postId)
          .where("isActive", isEqualTo: true)
          .orderBy("createDate", descending: true)
          .get();
    }

    if (query.docs.isNotEmpty) {
      commendList = convertResponseObjectToList(query.docs.iterator);
    }

    return commendList;
  }

  Future<int> getPostCommentCount(String postId) async {
    int count = 0;

    QuerySnapshot<Map<String, dynamic>> query;

    query = await _commentCollections
        .where("postId", isEqualTo: postId)
        .where("isActive", isEqualTo: true)
        .orderBy("createDate", descending: true)
        .get();

    if (query.docs.isNotEmpty) {
      count = query.docs.length;
    }

    return count;
  }

  @override
  Future<void> update(Comment model) async {
    await _commentCollections.doc(model.getId()!).update(model.toMap());
  }

  Future<int> getUserPostListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _commentCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .orderBy("createDate", descending: true)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  List<Comment> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Comment> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Comment temp = Comment();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
