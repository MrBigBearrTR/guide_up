import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/firestore_collectioon_constant.dart';
import '../../core/models/mentor/mentor_favourite_model.dart';

class MentorFavouriteRepository {
  late final CollectionReference<Map<String, dynamic>> _mentorFavouriteCollection;

  MentorFavouriteRepository() {
    _mentorFavouriteCollection = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.mentorFavourite);
  }

  Future<MentorFavourite> add(MentorFavourite mentorFavourite) async {
    mentorFavourite.dbCheck(mentorFavourite.getUserId()!);

    var process = await _mentorFavouriteCollection.add(mentorFavourite.toMap());

    mentorFavourite.setId(process.id);
    await _mentorFavouriteCollection.doc(process.id).update(mentorFavourite.toMap());

    return mentorFavourite;
  }

  Future<MentorFavourite?> get(String id) async {
    var query = await _mentorFavouriteCollection.doc(id).get();

    if (query.data() != null) {
      return MentorFavourite().toClass(query.data()!);
    }
    return null;
  }

  Future<List<MentorFavourite>> getMentorFavouriteListByUserId(
      String userId) async {
    List<MentorFavourite> mentorFavouriteList = [];
    var query =
        await _mentorFavouriteCollection.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      mentorFavouriteList = convertResponseObjectToList(query.docs.iterator);
    }
    return mentorFavouriteList;
  }

  Future<int> getMentorFavouriteListCountByUserId(String userId) async {
    int listCount = 0;
    var query =
        await _mentorFavouriteCollection.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<int> getMentorFavouriteListCountByMentorId(String mentorId) async {
    int listCount = 0;
    var query =
    await _mentorFavouriteCollection.where("mentorId", isEqualTo: mentorId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future update(MentorFavourite mentorFavourite) async {
    await _mentorFavouriteCollection
        .doc(mentorFavourite.getId()!)
        .update(mentorFavourite.toMap());
  }

  List<MentorFavourite> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<MentorFavourite> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      MentorFavourite temp = MentorFavourite();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
