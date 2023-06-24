import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserModel extends GeneralFields {
  String? _id;
  String? _username;
  String? _password;
  String? _email;
  bool _isMentor = false;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getUsername() {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
  }

  String? getPassword() {
    return _password;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? getEmail() {
    return _email;
  }

  void setEmail(String email) {
    _email = email;
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
    map['username'] = getUsername();
    map['password'] = getPassword();
    map['email'] = getEmail();
    map['isMentor'] = isMentor();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('username')) {
      setUsername(map['username']);
    }
    if (map.containsKey('password')) {
      setPassword(map['password']);
    }
    if (map.containsKey('email')) {
      setEmail(map['email']);
    }
    if (map.containsKey('isMentor')) {
      setMentor(map['isMentor']);
    }
  }
}
