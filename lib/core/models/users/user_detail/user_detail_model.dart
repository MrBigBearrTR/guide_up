import 'dart:convert';

import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

/// [@author MrBigBear] 
class UserDetail extends GeneralFields {
  String? _id;
  String? _userId;
  String? _name;
  String? _surname;
  DateTime? _birthday;
  String? _about;
  String? _photo;
  String? _phone;
  bool _isMentor = false;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getUserId() {
    return _userId;
  }

  void setUserId(String? userId) {
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

  DateTime? getBirthday() {
    return _birthday;
  }

  void setBirthday(DateTime birthday) {
    _birthday = birthday;
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

  String? getPhone() {
    return _phone;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  bool isMentor() {
    return _isMentor;
  }

  void setMentor(bool isMentor) {
    _isMentor = isMentor;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['name'] = getName();
    map['surname'] = getSurname();
    map['birthday'] = getBirthday().toString();
    map['about'] = getAbout();
    map['photo'] = getPhoto();
    map['phone'] = getPhone();
    map['isMentor'] = isMentor();
    return map;
  }

  UserDetail toClass(Map<String, dynamic> map) {
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
    if (ControlHelper.checkMapValue(map, 'birthday')) {
      setBirthday(DateTime.parse(map['birthday']));
    }
    if (ControlHelper.checkMapValue(map, 'about')) {
      setAbout(map['about']);
    }
    if (ControlHelper.checkMapValue(map, 'photo')) {
      setPhoto(map['photo']);
    }
    if (ControlHelper.checkMapValue(map, 'phone')) {
      setPhone(map['phone']);
    }
    if (ControlHelper.checkMapValue(map, 'isMentor')) {
      setMentor(map['isMentor']);
    }
    return this;
  }

  String toJson() => jsonEncode(toMap());

  UserDetail fromJson(String json) {
    toClass(jsonDecode(json));
    return this;
  }
}
