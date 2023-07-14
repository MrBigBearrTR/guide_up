import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/firestore_collectioon_constant.dart';
import '../../core/models/mentor/mentor_commend_model.dart';

class MentorCommentRepository {
  late final CollectionReference<Map<String, dynamic>>
      _mentorCommentCollections;

  MentorCommentRepository() {
    _mentorCommentCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.mentorComment);
  }

  Future<MentorComment> add(String userId, MentorComment mentorComment, String mentorId, int rating, bool showName) async {
    mentorComment.dbCheck(userId);

    var process = await _mentorCommentCollections.add(mentorComment.toMap());

    mentorComment.setId(process.id);
    await _mentorCommentCollections
        .doc(process.id)
        .update(mentorComment.toMap());

    return mentorComment;
  }

  Future<MentorComment?> get(String id) async {
    var query = await _mentorCommentCollections.doc(id).get();

    if (query.data() != null) {
      return MentorComment().toClass(query.data()!);
    }
    return null;
  }

  Future<List<MentorComment>> getMentorCommentListByMentorId(
      String mentorId) async {
    List<MentorComment> mentorCommentList = [];
    var query = await _mentorCommentCollections
        .where("mentorId", isEqualTo: mentorId)
        .get();

    if (query.docs.isNotEmpty) {
      mentorCommentList = convertResponseObjectToList(query.docs.iterator);
    }
    return mentorCommentList;
  }

  Future<int> getMentorCommentListCountByMentorId(String mentorId) async {
    int listCount = 0;
    var query = await _mentorCommentCollections
        .where("mentorId", isEqualTo: mentorId)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<MentorComment>> getMentorCommentListByMenteeId(
      String menteeId) async {
    List<MentorComment> mentorCommentList = [];
    var query = await _mentorCommentCollections
        .where("menteeId", isEqualTo: menteeId)
        .get();

    if (query.docs.isNotEmpty) {
      mentorCommentList = convertResponseObjectToList(query.docs.iterator);
    }
    return mentorCommentList;
  }

  Future<int> getMentorCommentListCountByMenteeId(String menteeId) async {
    int listCount = 0;
    var query = await _mentorCommentCollections
        .where("menteeId", isEqualTo: menteeId)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<MentorComment>> getList(int limit) async {
    List<MentorComment> postList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _mentorCommentCollections.limit(limit).get();
    } else {
      query = await _mentorCommentCollections.get();
    }

    if (query.docs.isNotEmpty) {
      postList = convertResponseObjectToList(query.docs.iterator);
    }

    return postList;
  }

  Future update(MentorComment post) async {
    await _mentorCommentCollections.doc(post.getId()!).update(post.toMap());
  }

  List<MentorComment> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<MentorComment> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      MentorComment temp = MentorComment();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
