import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_project/user_project_model.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';

class UserProjectRepository {

  late final CollectionReference<Map<String, dynamic>>
  _userProjectCollections;

  UserProjectRepository() {
    _userProjectCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userProject);
  }

  Future<UserProject> add(UserProject userProject) async {
    userProject.dbCheck(userProject.getUserId()!);

    var process = await _userProjectCollections.add(userProject.toMap());
    userProject.setId(process.id);

    await _userProjectCollections.doc(process.id).set(userProject.toMap());

    return userProject;
  }

  Future<List<UserProject>> getUserProjectListByUserId(
      String userId) async {
    // ignore: non_constant_identifier_names
    List<UserProject> ProjectList = [];
    var query = await _userProjectCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      ProjectList = convertResponseObjectToList(query.docs.iterator);
    }
    return ProjectList;
  }

  Future<void> update(UserProject userProject) async {
    await _userProjectCollections
        .doc(userProject.getId()!)
        .update(userProject.toMap());
  }

  Future<void> delete(UserProject project) async {
    project.setActive(false);
    await _userProjectCollections
        .doc(project.getId()!)
        .update(project.toMap());
  }

  List<UserProject> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserProject> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserProject temp = UserProject();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }

}
