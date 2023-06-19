import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserDetail extends GeneralFields {
  String? _id;
  String? _userId;
  String? _name;
  String? _surname;
  DateTime? _birthday;
  String? _about;
  String? _photo;
  String? _phone;

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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['name'] = getName();
    map['surname'] = getSurname();
    map['birthday'] = getBirthday();
    map['about'] = getAbout();
    map['photo'] = getPhoto();
    map['phone'] = getPhone();
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
    if (map.containsKey('name')) {
      setName(map['name']);
    }
    if (map.containsKey('surname')) {
      setSurname(map['surname']);
    }
    if (map.containsKey('birthday')) {
      setBirthday(map['birthday']);
    }
    if (map.containsKey('about')) {
      setAbout(map['about']);
    }
    if (map.containsKey('photo')) {
      setPhoto(map['photo']);
    }
    if (map.containsKey('phone')) {
      setPhone(map['phone']);
    }
  }
}