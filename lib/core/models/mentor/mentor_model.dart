import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class Mentor extends GeneralFields {
  String? _id;
  String? _userId;
  String? _name;
  String? _lastname;
  String? _photo;
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

  String? getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String? getLastname() {
    return _lastname;
  }

  void setLastname(String lastname) {
    _lastname = lastname;
  }

  String? getPhoto() {
    return _photo;
  }

  void setPhoto(String photo) {
    _photo = photo;
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
    map['name'] = getName();
    map['lastname'] = getLastname();
    map['photo'] = getPhoto();
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
    if (map.containsKey('name')) {
      setName(map['name']);
    }
    if (map.containsKey('lastname')) {
      setLastname(map['lastname']);
    }
    if (map.containsKey('photo')) {
      setPhoto(map['photo']);
    }
    if (map.containsKey('rate')) {
      setRate(map['rate']);
    }
  }
}
