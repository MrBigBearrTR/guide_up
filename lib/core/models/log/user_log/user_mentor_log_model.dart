import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserMentorLog extends GeneralFields {
  String? _id;
  String? _userId;
  String? _mentorId;

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

  String? getMentorId() {
    return _mentorId;
  }

  void setMentorId(String mentorId) {
    _mentorId = mentorId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userid'] = getUserId();
    map['mentorId'] = getMentorId();
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
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
  }
}
