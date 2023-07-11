import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_project/user_project_model.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';

class UserProjectRepository {
  late final CollectionReference<Map<String, dynamic>> _userProjectCollections;

  UserProjectRepository() {
    _userProjectCollections = FirebaseFirestore.instance.collection(FirestoreCollectionConstant.userProject);
  }

  Future<UserProject> add(UserProject userProject) async {
    userProject.dbCheck(userProject.getUserId()!);

    var process = await _userProjectCollections.add(userProject.toMap());

    userProject.setId(process.id);
    await _userProjectCollections.doc(process.id).set(userProject.toMap());

    return userProject;
  }

  Future<UserProject?> get(String id) async {
    var query = await _userProjectCollections.doc(id).get();

    if (query.data() != null) {
      return UserProject()..toClass(query.data()!);
    }
    return null;
  }

  Future<List<UserProject>> getUserProjectListByUserId(
      String userId) async {
    List<UserProject> projectList = [];
    var query = await _userProjectCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      projectList = convertResponseObjectToList(query.docs.iterator);
    }
    return projectList;
  }

  Future<int> getUserProjectListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _userProjectCollections
        .where("userId", isEqualTo: userId)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<UserProject>> getList(int limit) async {
    List<UserProject> projectList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _userProjectCollections.limit(limit).get();
    } else {
      query = await _userProjectCollections.get();
    }

    if (query.docs.isNotEmpty) {
      projectList = convertResponseObjectToList(query.docs.iterator);
    }

    return projectList;
  }

  Future<void> update(UserProject userProject) async {
    await _userProjectCollections.doc(userProject.getId()!).update(userProject.toMap());
  }

  Future<void> delete(UserProject project) async {
    project.setActive(false);
    await _userProjectCollections.doc(project.getId()!).update(project.toMap());
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
