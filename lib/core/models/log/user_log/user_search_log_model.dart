import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class UserSearchLog extends GeneralFields {
  String? _id;
  String? _userId;
  String? _searchText;
  String? _categoriesIds;

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

  String? getSearchText() {
    return _searchText;
  }

  void setSearchText(String searchText) {
    _searchText = searchText;
  }

  String? getCategoriesIds() {
    return _categoriesIds;
  }

  void setCategoriesIds(String categoriesIds) {
    _categoriesIds = categoriesIds;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['searchText'] = getSearchText();
    map['categoriesIds'] = getCategoriesIds();
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
    if (map.containsKey('searchText')) {
      setSearchText(map['searchText']);
    }
    if (map.containsKey('categoriesIds')) {
      setCategoriesIds(map['categoriesIds']);
    }
  }
}
