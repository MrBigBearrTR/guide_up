import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class MentorRepository {
  late final CollectionReference<Map<String, dynamic>> _mentorCollections;

  MentorRepository() {
    _mentorCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.mentor);
  }

  Future<Mentor> add(Mentor mentor) async {
    mentor.dbCheck(mentor.getUserId()!);

    var process = await _mentorCollections.add(mentor.toMap());

    mentor.setId(process.id);
    await _mentorCollections.doc(process.id).update(mentor.toMap());

    return mentor;
  }

  Future<Mentor?> get(String id) async {
    var query = await _mentorCollections.doc(id).get();

    if (query.data() != null) {
      return Mentor().toClass(query.data()!);
    }
    return null;
  }

  Future<Mentor?> getMentorByUserId(String userId) async {
    var query =
        await _mentorCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      return Mentor().toClass(query.docs.first.data());
    }
    return null;
  }

  Future<List<Mentor>> searchBySearchColumn(
      String searchColumn, String searchValue) async {
    List<Mentor> mentorList = [];

    var query = await _mentorCollections
        .where(searchColumn, isGreaterThanOrEqualTo: searchValue)
        .where(searchColumn, isLessThanOrEqualTo: searchValue + '\uf8ff')
        .get();

    if (query.docs.isNotEmpty) {
      mentorList = convertResponseObjectToList(query.docs.iterator);
    }

    return mentorList;
  }

  // Senin için Önerilen Mentorlar için Recommend
  Future<List<Mentor>> getRecommendMentorListByUserId(String userId) async {
    // List<Mentor> mentorList = [];

    // var query =
    //     await mentorCollections.get();

    // mentorList = convertResponseObjectToList(query.docs.iterator);

    return getList(0);
  }

  Future<List<Mentor>> getList(int limit) async {
    List<Mentor> mentorList = [];

    QuerySnapshot<Map<String, dynamic>> query;
    if (limit > 0) {
      query = await _mentorCollections.limit(limit).get();
    } else {
      query = await _mentorCollections.get();
    }

    mentorList = convertResponseObjectToList(query.docs.iterator);

    return mentorList;
  }

  Future update(Mentor mentor) async {
    await _mentorCollections.doc(mentor.getId()!).update(mentor.toMap());
  }

  List<Mentor> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Mentor> mentorList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Mentor tempMentor = Mentor();
      tempMentor.toClass(snap.data());
      mentorList.add(tempMentor);
    }

    return mentorList;
  }
}