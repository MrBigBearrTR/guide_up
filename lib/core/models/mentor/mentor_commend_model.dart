import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class MentorCommend extends GeneralFields {
  String? _id;
  String? _userId;
  String? _mentorId;
  int? _rate;
  String? _commend;
  bool _isAnonymous = false;

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

  int? getRate() {
    return _rate;
  }

  void setRate(int rate) {
    _rate = rate;
  }

  String? getCommend() {
    return _commend;
  }

  void setCommend(String commend) {
    _commend = commend;
  }

  bool? isAnonymous() {
    return _isAnonymous;
  }

  void setAnonymous(bool isAnonymous) {
    _isAnonymous = isAnonymous;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['mentorId'] = getMentorId();
    map['rate'] = getRate();
    map['commend'] = getCommend();
    map['isAnonymous'] = isAnonymous();
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
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (map.containsKey('rate')) {
      setRate(map['rate']);
    }
    if (map.containsKey('commend')) {
      setCommend(map['commend']);
    }
    if (map.containsKey('isAnonymous')) {
      setAnonymous(map['isAnonymous']);
    }
  }
}
