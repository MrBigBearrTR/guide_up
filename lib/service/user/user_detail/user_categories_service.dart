import 'package:guide_up/repository/category/category_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_categories_repository.dart';

import '../../../core/models/category/category_model.dart';
import '../../../core/models/users/user_detail/user_categories_model.dart';

class UserCategoriesService {
  late UserCategoriesRepository _userCategoriesRepository;
  late CategoryRepository _categoryRepository;

  UserCategoriesService() {
    _userCategoriesRepository = UserCategoriesRepository();
    _categoryRepository = CategoryRepository();
  }

  Future<List<Category>> getUserCategoriesList(String userId) async {
    List<Category> catList = [];

    List<UserCategories> userCatList =
        await _userCategoriesRepository.getUserCategoriesListByUserId(userId);

    for (var userCat in userCatList) {
      if (userCat.getCategoriesId() != null) {
        Category? cat =
            await _categoryRepository.get(userCat.getCategoriesId()!);
        if (cat != null) {
          catList.add(cat);
        }
      }
    }

    Category? cat =
    await _categoryRepository.get("11SUrHXKZxQo8gwqdypf");
    if (cat != null) {
      catList.add(cat);
    }Category? cat2 =
    await _categoryRepository.get("1KeM8Fyu8gthR136z5LG");
    if (cat2 != null) {
      catList.add(cat2);
    }Category? cat3 =
    await _categoryRepository.get("2VsJajbrIpJmfDeOLCGr");
    if (cat3 != null) {
      catList.add(cat3);
    }


    return catList;
  }
}
