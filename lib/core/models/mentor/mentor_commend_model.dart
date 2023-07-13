import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class MentorComment extends GeneralFields {
  String? _id;
  String? _menteeId;
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

  String? getMenteeId() {
    return _menteeId;
  }

  void setMenteeId(String menteeId) {
    _menteeId = menteeId;
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

  String? getComment() {
    return _commend;
  }

  void setComment(String commend) {
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
    map['menteeId'] = getMenteeId();
    map['mentorId'] = getMentorId();
    map['rate'] = getRate();
    map['comment'] = getComment();
    map['isAnonymous'] = isAnonymous();
    return map;
  }

  MentorComment toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('menteeId')) {
      setMenteeId(map['menteeId']);
    }
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (map.containsKey('rate')) {
      setRate(map['rate']);
    }
    if (map.containsKey('comment')) {
      setComment(map['comment']);
    }
    if (map.containsKey('isAnonymous')) {
      setAnonymous(map['isAnonymous']);
    }
    return this;
  }
}