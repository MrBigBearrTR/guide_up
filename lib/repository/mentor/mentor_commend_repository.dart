import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constant/firestore_collectioon_constant.dart';
import '../../core/models/mentor/mentor_commend_model.dart';


class MentorCommendRepository {
  late final CollectionReference<Map<String, dynamic>> _mentorCommendCollections;

  MentorCommendRepository() {
    _mentorCommendCollections =
        FirebaseFirestore.instance.collection(FirestoreCollectionConstant.mentorCommend);
  }

  Future<MentorCommend> add(MentorCommend mentorCommend) async {
    mentorCommend.dbCheck(mentorCommend.getUserId()!);

    var process = await _mentorCommendCollections.add(mentorCommend.toMap());

    mentorCommend.setId(process.id);
    await _mentorCommendCollections.doc(process.id).update(mentorCommend.toMap());

    return mentorCommend;
  }

  Future<MentorCommend?> get(String id) async {
    var query = await _mentorCommendCollections.doc(id).get();

    if (query.data() != null) {
      return MentorCommend().toClass(query.data()!);
    }
    return null;
  }

  Future<List<MentorCommend>> getMentorCommendListByMentorId(String mentorId) async {
    List<MentorCommend> mentorCommendList = [];
    var query = await _mentorCommendCollections.where("mentorId", isEqualTo: mentorId).get();

    if (query.docs.isNotEmpty) {
      mentorCommendList = convertResponseObjectToList(query.docs.iterator);
    }
    return mentorCommendList;
  }

    Future<int> getMentorCommendListCountByMentorId(String mentorId) async {
    int listCount = 0;
    var query = await _mentorCommendCollections.where("mentorId", isEqualTo: mentorId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

   Future<List<MentorCommend>> getMentorCommendListByUserId(String userId) async {
    List<MentorCommend> mentorCommendList = [];
    var query = await _mentorCommendCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      mentorCommendList = convertResponseObjectToList(query.docs.iterator);
    }
    return mentorCommendList;
  }

  Future<int> getMentorCommendListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _mentorCommendCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<MentorCommend>> getList(int limit) async {
    List<MentorCommend> postList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _mentorCommendCollections.limit(limit).get();
    } else {
      query = await _mentorCommendCollections.get();
    }

    if (query.docs.isNotEmpty) {
      postList = convertResponseObjectToList(query.docs.iterator);
    }

    return postList;
  }

  Future update(MentorCommend post) async {
    await _mentorCommendCollections.doc(post.getId()!).update(post.toMap());
  }

  List<MentorCommend> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<MentorCommend> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      MentorCommend temp = MentorCommend();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
