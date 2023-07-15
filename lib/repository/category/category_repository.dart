import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/category/category_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

/// [@author MrBigBear]
class CategoryRepository {
  late final CollectionReference<Map<String, dynamic>> categoryCollections;

  CategoryRepository() {
    categoryCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.category);
  }

  Future<Category?> get(String id) async {
    var query = await categoryCollections.doc(id).get();

    if (query.data() != null) {
      return Category().toClass(query.data()!);
    }
    return null;
  }


  Future<List<Category>> getMainCategoryList() async {
    List<Category> categoryList = [];

    var query = await categoryCollections
        .where("mainCategory", isNull: true)
        .orderBy("name")
        .get();

    categoryList = convertResponseObjectToList(query.docs.iterator);

    return categoryList;
  }

  Future<List<Category>> getSubCategoryList(String mainCategoryId) async {
    List<Category> categoryList = [];

    var query = await categoryCollections
        .where("mainCategory", isEqualTo: mainCategoryId)
        .get();

    categoryList = convertResponseObjectToList(query.docs.iterator);

    return categoryList;
  }

  Future<List<Category>> getList() async {
    List<Category> categoryList = [];

    var query = await categoryCollections.get();

    categoryList = convertResponseObjectToList(query.docs.iterator);

    return categoryList;
  }

  Future<Category> add(Category category) async {
    String? userId = await SecureStorageHelper().getUserId();
    if (userId != null) {
      category.dbCheck(userId);
    }

    var process = await categoryCollections.add(category.toMap());

    category.setId(process.id);
    await categoryCollections.doc(process.id).update(category.toMap());

    return category;
  }

  List<Category> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Category> categoryList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Category tempCategory = Category();
      tempCategory.toClass(snap.data());
      categoryList.add(tempCategory);
    }

    return categoryList;
  }
}
