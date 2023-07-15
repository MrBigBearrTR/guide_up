import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/general/general_repository.dart';
import 'package:guide_up/core/models/users/user_experience/user_experience_model.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class UserExperienceRepository extends GeneralRepository<UserExperience> {
  late final CollectionReference<Map<String, dynamic>>
      _userExperienceCollections;

  UserExperienceRepository() {
    _userExperienceCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userExperience);
  }

  @override
  Future<UserExperience> add(UserExperience model) async {
    model.dbCheck(model.getUserId()!);

    var process = await _userExperienceCollections.add(model.toMap());
    model.setId(process.id);

    await _userExperienceCollections.doc(process.id).set(model.toMap());

    return model;
  }


  @override
  Future<UserExperience?> get(String id) async {
    var query = await _userExperienceCollections.doc(id).get();

    if (query.data() != null) {
      return UserExperience().toClass(query.data()!);
    }
    return null;
  }

  @override
  Future<List<UserExperience>> getList(String userId, int limit) async {
    List<UserExperience> experienceList = [];
    var query;

    if (limit > 0) {
      query = await _userExperienceCollections
          .where("userId", isEqualTo: userId)
          .where("isActive", isEqualTo: true)
          .limit(limit)
          .get();
    } else {
      query = await _userExperienceCollections
          .where("userId", isEqualTo: userId)
          .where("isActive", isEqualTo: true)
          .get();
    }

    if (query.docs.isNotEmpty) {
      experienceList = convertResponseObjectToList(query.docs.iterator);
    }
    return experienceList;
  }

  @override
  Future<void> update(UserExperience model) async {
    await _userExperienceCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<void> delete(UserExperience model) async {
    model.setActive(false);
    await _userExperienceCollections.doc(model.getId()!).update(model.toMap());
  }

  List<UserExperience> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserExperience> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserExperience temp = UserExperience();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
