import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserCategories extends GeneralFields {
  String? _id;
  String? _userId;
  String? _categoriesId;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getUserId() {
    return _userId;
  }

  void setUserId(String userId) {
    _userId = userId;
  }

  String? getCategoriesId() {
    return _categoriesId;
  }

  void setCategoriesId(String categoriesId) {
    _categoriesId = categoriesId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['categoriesId'] = getCategoriesId();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('userId')) {
      setUserId(map['userId']);
    }
    if (map.containsKey('categoriesId')) {
      setCategoriesId(map['categoriesId']);
    }
  }
}
