import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/post/post_categories_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class PostCategoriesRepository {
  late final CollectionReference<Map<String, dynamic>>
      _postCategoriesCollections;

  PostCategoriesRepository() {
    _postCategoriesCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.postCategories);
  }

  Future<PostCategories> add(PostCategories postCategories) async {
    postCategories.dbCheck(postCategories.getUserId()!);

    var process = await _postCategoriesCollections.add(postCategories.toMap());

    postCategories.setId(process.id);
    await _postCategoriesCollections
        .doc(process.id)
        .update(postCategories.toMap());

    return postCategories;
  }

  Future<PostCategories?> get(String id) async {
    var query = await _postCategoriesCollections.doc(id).get();

    if (query.data() != null) {
      return PostCategories().toClass(query.data()!);
    }
    return null;
  }

  Future<List<PostCategories>> getCategoriesPostListByPostId(
      String postId) async {
    List<PostCategories> postCategoriesList = [];
    var query = await _postCategoriesCollections
        .where("postId", isEqualTo: postId)
        .get();

    if (query.docs.isNotEmpty) {
      postCategoriesList = convertResponseObjectToList(query.docs.iterator);
    }
    return postCategoriesList;
  }

  Future<int> getCategoriesPostListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _postCategoriesCollections
        .where("postId", isEqualTo: userId)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  List<PostCategories> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<PostCategories> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      PostCategories temp = PostCategories();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
