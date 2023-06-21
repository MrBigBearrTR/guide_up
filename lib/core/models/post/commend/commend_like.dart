import '../../general/general_fields_model.dart';

class CommendLike extends GeneralFields {
  String? _id;
  String? _userId;
  String? _commendId;

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

  String? getCommendId() {
    return _commendId;
  }

  void setCommendId(String commendId) {
    _commendId = commendId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['commendId'] = getCommendId();
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
    if (map.containsKey('commendId')) {
      setCommendId(map['commendId']);
    }
  }
}
