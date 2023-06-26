import '../../general/general_fields_model.dart';

/// [@author MrBigBear] 
class UserExperienceCategories extends GeneralFields {

  String? _id;
  String? _userId;
  String? _userExperienceId;
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

  String? getUserExperienceId() {
    return _userExperienceId;
  }

  void setUserExperienceId(String userExperienceId) {
    _userExperienceId = userExperienceId;
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
    map['userExperienceId'] = getUserExperienceId();
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

    if (map.containsKey('userExperienceId')) {
      setUserExperienceId(map['userExperienceId']);
    }

    if (map.containsKey('categoryId')) {
      setCategoryId(map['categoryId']);
    }

  }
}
