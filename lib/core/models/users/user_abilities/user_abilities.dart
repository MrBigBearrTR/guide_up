import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

class UserAbilities extends GeneralFields {

  String? _id;
  String? _userId;
  String? _ability;

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

  String? getAbility() {
    return _ability;
  }

  void setAbility(String ability) {
    _ability = ability;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['ability'] = getAbility();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'ability')) {
      setAbility(map['ability']);
    }
  }
}
