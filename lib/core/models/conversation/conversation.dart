import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../utils/control_helper.dart';

class Conversation extends GeneralFields {
  String? _id;
  String? _firstParticipantUserId;
  String? _secondParticipantUserId;
  bool _isHiddenFromFirst = false;
  bool _isHiddenFromSecond = false;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getFirstParticipantUserId() {
    return _firstParticipantUserId;
  }

  void setFirstParticipantUserId(String firstParticipantUserId) {
    _firstParticipantUserId = firstParticipantUserId;
  }

  String? getSecondParticipantUserId() {
    return _secondParticipantUserId;
  }

  void setSecondParticipantUserId(String secondParticipantUserId) {
    _secondParticipantUserId = secondParticipantUserId;
  }

  bool isHiddenFromFirst() {
    return _isHiddenFromFirst;
  }

  void setHiddenFromFirst(bool isHiddenFromFirst) {
    _isHiddenFromFirst = isHiddenFromFirst;
  }

  bool isHiddenFromSecond() {
    return _isHiddenFromSecond;
  }

  void setHiddenFromSecond(bool isHiddenFromSecond) {
    _isHiddenFromSecond = isHiddenFromSecond;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['firstParticipantUserId'] = getFirstParticipantUserId();
    map['secondParticipantUserId'] = getSecondParticipantUserId();
    map['isHiddenFromFirst'] = isHiddenFromFirst();
    map['isHiddenFromSecond'] = isHiddenFromSecond();

    return map;
  }

  Conversation toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }

    if (ControlHelper.checkMapValue(map, 'firstParticipantUserId')) {
      setFirstParticipantUserId(map['firstParticipantUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'secondParticipantUserId')) {
      setSecondParticipantUserId(map['secondParticipantUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'isHiddenFromFirst')) {
      setHiddenFromFirst(map['isHiddenFromFirst']);
    }

    if (ControlHelper.checkMapValue(map, 'isHiddenFromSecond')) {
      setHiddenFromSecond(map['isHiddenFromSecond']);
    }
    return this;
  }
}
