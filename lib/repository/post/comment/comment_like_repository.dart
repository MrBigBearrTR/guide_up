import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/general/general_repository.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';
import '../../../core/models/post/commend/commend_like_model.dart';

class CommentLikeRepository extends GeneralRepository<CommentLike> {
  late final CollectionReference<Map<String, dynamic>> _commendLikeCollections;

  CommentLikeRepository() {
    _commendLikeCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.postCommentLike);
  }

  @override
  Future<CommentLike> add(CommentLike model) async {
    model.dbCheck(model.getUserId()!);

    var process = await _commendLikeCollections.add(model.toMap());

    model.setId(process.id);
    await _commendLikeCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<void> delete(CommentLike model) async {
    model.setActive(false);
    await _commendLikeCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<CommentLike?> get(String id) async {
    var query = await _commendLikeCollections.doc(id).get();

    if (query.data() != null) {
      return CommentLike().toClass(query.data()!);
    }
    return null;
  }

  @override
  Future<List<CommentLike>> getList(String commentId, int limit) async {
    List<CommentLike> commendList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _commendLikeCollections
          .where("commentId", isEqualTo: commentId)
          .where("isActive", isEqualTo: true)
          .limit(limit)
          .get();
    } else {
      query = await _commendLikeCollections
          .where("commentId", isEqualTo: commentId)
          .where("isActive", isEqualTo: true)
          .get();
    }

    if (query.docs.isNotEmpty) {
      commendList = convertResponseObjectToList(query.docs.iterator);
    }

    return commendList;
  }

  Future<int> getCommentCount(String commentId) async {
    int count = 0;

    QuerySnapshot<Map<String, dynamic>> query;

    query = await _commendLikeCollections
        .where("commentId", isEqualTo: commentId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      count = query.docs.length;
    }

    return count;
  }

  Future<CommentLike?> getByUserIdAndCommentId(
      String userId, String commentId) async {
    var query = await _commendLikeCollections
        .where("userId", isEqualTo: userId)
        .where("commentId", isEqualTo: commentId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      return CommentLike().toClass(query.docs.first.data());
    }
    return null;
  }

  @override
  Future<void> update(CommentLike model) async {
    await _commendLikeCollections.doc(model.getId()!).update(model.toMap());
  }

  Future<int> getUserCommentCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _commendLikeCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  List<CommentLike> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<CommentLike> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      CommentLike temp = CommentLike();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
