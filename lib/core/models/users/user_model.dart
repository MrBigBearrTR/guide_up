import 'package:guide_up/core/models/general/general_fields_model.dart';
import 'package:guide_up/core/utils/control_helper.dart';

/// [@author MrBigBear] 
class UserModel extends GeneralFields {
  String? _id;
  String? _username;
  String? _password;
  String? _email;

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


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['username'] = getUsername();
    map['password'] = getPassword();
    map['email'] = getEmail();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'username')) {
      setUsername(map['username']);
    }
    if (ControlHelper.checkMapValue(map, 'password')) {
      setPassword(map['password']);
    }
    if (ControlHelper.checkMapValue(map, 'email')) {
      setEmail(map['email']);
    }

    return this;
  }
}
