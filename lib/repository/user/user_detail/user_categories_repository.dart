import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_detail/user_categories_model.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class UserCategoriesRepository {
  late final CollectionReference<Map<String, dynamic>>
      _userCategoriesCollections;

  UserCategoriesRepository() {
    _userCategoriesCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userCategories);
  }

  Future<UserCategories> add(UserCategories userCategories) async {
    userCategories.dbCheck(userCategories.getUserId()!);

    var process = await _userCategoriesCollections.add(userCategories.toMap());

    userCategories.setId(process.id);
    await _userCategoriesCollections
        .doc(process.id)
        .update(userCategories.toMap());

    return userCategories;
  }

  Future<UserCategories?> get(String id) async {
    var query = await _userCategoriesCollections.doc(id).get();

    if (query.data() != null) {
      return UserCategories().toClass(query.data()!);
    }
    return null;
  }

  Future<List<UserCategories>> getUserCategoriesListByUserId(
      String userId) async {
    List<UserCategories> userCategoriesList = [];
    var query = await _userCategoriesCollections
        .where("userId", isEqualTo: userId)
        .get();

    if (query.docs.isNotEmpty) {
      userCategoriesList = convertResponseObjectToList(query.docs.iterator);
    }
    return userCategoriesList;
  }

  Future<int> getUserCategoriesListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _userCategoriesCollections
        .where("userId", isEqualTo: userId)
        .get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<UserCategories>> getUserCategoriesListByCategoryId(
      String categoryId) async {
    List<UserCategories> userCategoriesList = [];
    var query = await _userCategoriesCollections
        .where("categoriesId", isEqualTo: categoryId)
        .get();

    if (query.docs.isNotEmpty) {
      userCategoriesList = convertResponseObjectToList(query.docs.iterator);
    }
    return userCategoriesList;
  }

  Future<List<UserCategories>> getList(int limit) async {
    List<UserCategories> userCategoriesList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _userCategoriesCollections.limit(limit).get();
    } else {
      query = await _userCategoriesCollections.get();
    }

    if (query.docs.isNotEmpty) {
      userCategoriesList = convertResponseObjectToList(query.docs.iterator);
    }

    return userCategoriesList;
  }

  Future update(UserCategories userCategories) async {
    await _userCategoriesCollections
        .doc(userCategories.getId()!)
        .update(userCategories.toMap());
  }

  List<UserCategories> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserCategories> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserCategories temp = UserCategories();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
