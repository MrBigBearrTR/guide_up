import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/models/post/post_like_save_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class PostLikeSaveRepository {
  late final CollectionReference<Map<String, dynamic>> _postSaveLinkCollections;

  PostLikeSaveRepository() {
    _postSaveLinkCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.postLikeSave);
  }

  Future<PostLikeSave> add(PostLikeSave postLikeSave) async {
    postLikeSave.dbCheck(postLikeSave.getUserId()!);

    var process = await _postSaveLinkCollections.add(postLikeSave.toMap());

    postLikeSave.setId(process.id);
    await _postSaveLinkCollections.doc(process.id).update(postLikeSave.toMap());

    return postLikeSave;
  }

  Future<PostLikeSave?> get(String id) async {
    var query = await _postSaveLinkCollections.doc(id).get();

    if (query.data() != null) {
      return PostLikeSave().toClass(query.data()!);
    }
    return null;
  }

  Future<PostLikeSave?> getByUserIdAndPostId(
      String userId, String postId,EnLikeSaveType enLikeSaveType) async {
    var query = await _postSaveLinkCollections
        .where("userId", isEqualTo: userId)
        .where("postId", isEqualTo: postId)
        .where("enLikeSaveType", isEqualTo: enLikeSaveType.name)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      return PostLikeSave().toClass(query.docs.first.data());
    }
    return null;
  }

  Future<List<PostLikeSave>> getCategoriesPostListByPostId(
      String postId) async {
    List<PostLikeSave> postLikeSaveList = [];
    var query = await _postSaveLinkCollections
        .where("postId", isEqualTo: postId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      postLikeSaveList = convertResponseObjectToList(query.docs.iterator);
    }
    return postLikeSaveList;
  }

  Future<int> getLikeSavePostListCountByUserId(String postId,EnLikeSaveType enLikeSaveType) async {
    int listCount = 0;
    var query = await _postSaveLinkCollections
        .where("postId", isEqualTo: postId)
        .where("enLikeSaveType", isEqualTo: enLikeSaveType.name)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<PostLikeSave>> getListByType(
      EnLikeSaveType enLikeSaveType) async {
    List<PostLikeSave> postLikeSaveList = [];

    var query = await _postSaveLinkCollections
        .where("enLikeSaveType", isEqualTo: enLikeSaveType.name)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      postLikeSaveList = convertResponseObjectToList(query.docs.iterator);
    }

    return postLikeSaveList;
  }

  Future<bool> update(PostLikeSave postLikeSave) async {
    _postSaveLinkCollections
        .doc(postLikeSave.getId()!)
        .update(postLikeSave.toMap())
        .then((value) {
      return true;
    });
    return false;
  }

  Future delete(PostLikeSave postLikeSave) async {
    postLikeSave.setActive(false);
    await _postSaveLinkCollections
        .doc(postLikeSave.getId()!)
        .update(postLikeSave.toMap());
  }

  List<PostLikeSave> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<PostLikeSave> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      PostLikeSave temp = PostLikeSave();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
