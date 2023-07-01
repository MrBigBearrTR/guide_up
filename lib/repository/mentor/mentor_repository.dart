import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class MentorRepository {
  late final CollectionReference<Map<String, dynamic>> mentorCollections;

  MentorRepository() {
    mentorCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.mentor);
  }

  //Sık Kullanılan Mentorlar için Top kelimesini kullandım.
  Future<List<Mentor>> getTopMentorList() async {
    // List<Mentor> mentorList = [];

    // var query =
    //     await mentorCollections.get();

    // mentorList = convertResponseObjectToList(query.docs.iterator);

    return getList();
  }

  // Senin için Önerilen Mentorlar için Recommend
  Future<List<Mentor>> getRecommendMentorListByUserId (String userId) async {
    // List<Mentor> mentorList = [];

    // var query =
    //     await mentorCollections.get();

    // mentorList = convertResponseObjectToList(query.docs.iterator);

    return getList();
  }

  Future<List<Mentor>> getList() async {
    List<Mentor> mentorList = [];

    var query = await mentorCollections.get();

    mentorList = convertResponseObjectToList(query.docs.iterator);

    return mentorList;
  }

  Future<Mentor> add(Mentor mentor) async {
    String? userId = await SecureStorageHelper().getUserId();
    if (userId != null) {
      mentor.dbCheck(userId);
    }

    var process = await mentorCollections.add(mentor.toMap());

    mentor.setId(process.id);
    await mentorCollections.doc(process.id).update(mentor.toMap());

    return mentor;
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