import '../../utils/control_helper.dart';
import '../general/general_fields_model.dart';

class MentorFavourite extends GeneralFields {
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

  void setMentorId(String postId) {
    _mentorId = postId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['mentorId'] = getMentorId();
    return map;
  }

  MentorFavourite toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'mentorId')) {
      setMentorId(map['mentorId']);
    }
     return this;
  }
}
