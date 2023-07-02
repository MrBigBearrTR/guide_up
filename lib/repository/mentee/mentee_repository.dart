import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class MenteeRepository {
  late final CollectionReference<Map<String, dynamic>> menteeCollections;

  MenteeRepository() {
    menteeCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.mentee);
  }

  Future<List<Mentee>> getList(int limit) async {
    List<Mentee> mentorList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await menteeCollections.limit(limit).get();
    } else {
      query = await menteeCollections.get();
    }

    mentorList = convertResponseObjectToList(query.docs.iterator);

    return mentorList;
  }

  Future<Mentee> add(Mentee mentee) async {
    if (mentee.getUserId() != null) {
      mentee.dbCheck(mentee.getUserId()!);
    }

    var process = await menteeCollections.add(mentee.toMap());

    mentee.setId(process.id);
    await menteeCollections.doc(process.id).update(mentee.toMap());

    return mentee;
  }

  List<Mentee> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Mentee> tempList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Mentee temp = Mentee();
      temp.toClass(snap.data());
      tempList.add(temp);
    }

    return tempList;
  }
}
