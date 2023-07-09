import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../utils/control_helper.dart';

/// [@author MrBigBear]
class Mentor extends GeneralFields {
  String? _id;
  String? _userId;
  String? _name;
  String? _surname;
  String? _about;
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

  String? getSurname() {
    return _surname;
  }

  void setSurname(String surname) {
    _surname = surname;
  }

  String? getAbout() {
    return _about;
  }

  void setAbout(String about) {
    _about = about;
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
    map['userId'] = getUserId();
    map['name'] = getName();
    map['surname'] = getSurname();
    map['about'] = getAbout();
    map['photo'] = getPhoto();
    map['rate'] = getRate();
    return map;
  }

  Mentor toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'name')) {
      setName(map['name']);
    }
    if (ControlHelper.checkMapValue(map, 'surname')) {
      setSurname(map['surname']);
    }
    if (ControlHelper.checkMapValue(map, 'about')) {
      setAbout(map['about']);
    }
    if (ControlHelper.checkMapValue(map, 'photo')) {
      setPhoto(map['photo']);
    }
    if (ControlHelper.checkMapValue(map, 'rate')) {
      setRate(map['rate']);
    }
    return this;
  }
}
