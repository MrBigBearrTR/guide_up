import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class UserEducationCategories extends GeneralFields {
  String? _id;
  String? _userId;
  String? _userEducationId;
  String? _categoryId;

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

  String? getUserEducationId() {
    return _userEducationId;
  }

  void setUserEducationId(String userEducationId) {
    _userEducationId = userEducationId;
  }

  String? getCategoryId() {
    return _categoryId;
  }

  void setCategoryId(String categoryId) {
    _categoryId = categoryId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['userEducationId'] = getUserEducationId();
    map['categoryId'] = getCategoryId();
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
    if (map.containsKey('userEducationId')) {
      setUserEducationId(map['userEducationId']);
    }
    if (map.containsKey('categoryId')) {
      setCategoryId(map['categoryId']);
    }
  }
}
