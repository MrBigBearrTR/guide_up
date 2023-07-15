import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';
import '../../../core/models/users/user_education/user_education_model.dart';

class UserEducationInformationRepository {
  late final CollectionReference<Map<String, dynamic>>
  _userEducationInformationCollections;

  UserEducationInformationRepository() {
    _userEducationInformationCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userEducationInformation);
  }

  Future<UserEducation> add(UserEducation userEducationInformation) async {
    userEducationInformation.dbCheck(userEducationInformation.getUserId()!);

    var process = await _userEducationInformationCollections.add(userEducationInformation.toMap());
    userEducationInformation.setId(process.id);

    await _userEducationInformationCollections.doc(process.id).set(userEducationInformation.toMap());

    return userEducationInformation;
  }

  Future<List<UserEducation>> getUserEducationInformationListByUserId(
      String userId) async {
    List<UserEducation> educationInformationList = [];
    var query = await _userEducationInformationCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      educationInformationList = convertResponseObjectToList(query.docs.iterator);
    }
    return educationInformationList;
  }


  Future<void> update(UserEducation userEducationInformation) async {
    await _userEducationInformationCollections
        .doc(userEducationInformation.getId()!)
        .update(userEducationInformation.toMap());
  }

  Future<void> delete(UserEducation educationInformation) async {
    educationInformation.setActive(false);
    await _userEducationInformationCollections
        .doc(educationInformation.getId()!)
        .update(educationInformation.toMap());
  }

  List<UserEducation> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserEducation> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserEducation temp = UserEducation();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }

}
