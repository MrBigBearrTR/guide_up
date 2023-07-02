import 'package:flutter/cupertino.dart';

import '../../../core/models/category/category_model.dart';

class CategorySelectHelper extends ChangeNotifier {
  final List<Category> categoryList = [];

  addCategory(Category category) {
    bool isThere = false;
    for (var cat in categoryList) {
      if (cat.getId()!.compareTo(category.getId()!) == 0) {
        isThere = true;
        break;
      }
    }

    if (!isThere) {
      categoryList.add(category);
    }
    notifyListeners();
  }

  removeCategory(Category category) {
    bool isThere = false;
    int index = 0;
    if(categoryList.isNotEmpty) {
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].getId()!.compareTo(category.getId()!) == 0) {
          isThere = true;
          index = i;
          break;
        }
      }
    }

    if (isThere) {
      categoryList.removeAt(index);
    }
    notifyListeners();
  }
}
