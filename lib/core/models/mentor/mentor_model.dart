import 'package:guide_up/core/models/general/general_fields_model.dart';

class Mentor extends GeneralFields {
  String? _id;
  String? _userId;
  int? _rate;

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

  int? getRate() {
    return _rate;
  }

  void setRate(int rate) {
    _rate = rate;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userid'] = getUserId();
    map['rate'] = getRate();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('userid')) {
      setUserId(map['userid']);
    }
    if (map.containsKey('rate')) {
      setRate(map['rate']);
    }
  }
}
