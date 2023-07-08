import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/constant/firestore_collectioon_constant.dart';
import 'package:guide_up/core/models/post/post_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';


class PostRepository {
  late final CollectionReference<Map<String, dynamic>> _postCollections;

  PostRepository() {
    _postCollections =
        FirebaseFirestore.instance.collection(FirestoreCollectionConstant.post);
  }

  Future<Post> add(Post post) async {
    post.dbCheck(post.getUserId()!);

    var process = await _postCollections.add(post.toMap());

    post.setId(process.id);
    await _postCollections.doc(process.id).update(post.toMap());

    return post;
  }

  Future<Post?> get(String id) async {
    var query = await _postCollections.doc(id).get();

    if (query.data() != null) {
      return Post().toClass(query.data()!);
    }
    return null;
  }

  Future<List<Post>> getUserPostListByUserId(String userId) async {
    List<Post> postList = [];
    var query = await _postCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      postList = convertResponseObjectToList(query.docs.iterator);
    }
    return postList;
  }

  Future<int> getUserPostListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _postCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<Post>> getList(int limit) async {
    List<Post> postList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _postCollections.limit(limit).get();
    } else {
      query = await _postCollections.get();
    }

    if (query.docs.isNotEmpty) {
      postList = convertResponseObjectToList(query.docs.iterator);
    }

    return postList;
  }

  Future<void> deletePost(String postId) async {
    await _postCollections.doc(postId).delete();
  }

  Future update(Post post) async {
    await _postCollections.doc(post.getId()!).update(post.toMap());
  }

  List<Post> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Post> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Post temp = Post();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
