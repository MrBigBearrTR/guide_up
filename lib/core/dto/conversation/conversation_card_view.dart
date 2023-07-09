import 'dart:convert';

import '../../utils/control_helper.dart';

class ConversationCardView {
  String id = "";

  String myUserId = "";
  String myName = "";
  String myFullName = "";
  String? myPhoto;

  String otherParticipantUserId = "";
  String otherParticipantName = "";
  String otherParticipantFullName = "";
  String? otherParticipantPhoto;

  String lastMessage = "";
  String lastMessageSenderName = "";

  bool isHiddenFromFirst = false;
  bool isHiddenFromSecond = false;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['myUserId'] = myUserId;
    map['myName'] = myName;
    map['myFullName'] = myFullName;
    map['myPhoto'] = myPhoto;
    map['otherParticipantUserId'] = otherParticipantUserId;
    map['otherParticipantName'] = otherParticipantName;
    map['otherParticipantFullName'] = otherParticipantFullName;
    map['otherParticipantPhoto'] = otherParticipantPhoto;
    map['lastMessage'] = lastMessage;
    map['lastMessageSenderName'] = lastMessageSenderName;
    map['isHiddenFromFirst'] = isHiddenFromFirst;
    map['isHiddenFromSecond'] = isHiddenFromSecond;
    return map;
  }

  ConversationCardView toClass(Map<String, dynamic> map) {
    if (ControlHelper.checkMapValue(map, 'id')) {
      id = map['id'];
    }
    if (ControlHelper.checkMapValue(map, 'myUserId')) {
      myUserId = map['myUserId'];
    }
    if (ControlHelper.checkMapValue(map, 'myName')) {
      myName = map['myName'];
    }
    if (ControlHelper.checkMapValue(map, 'myFullName')) {
      myFullName = map['myFullName'];
    }
    if (ControlHelper.checkMapValue(map, 'myPhoto')) {
      myPhoto = map['myPhoto'];
    }
    if (ControlHelper.checkMapValue(map, 'otherParticipantUserId')) {
      otherParticipantUserId = map['otherParticipantUserId'];
    }
    if (ControlHelper.checkMapValue(map, 'otherParticipantName')) {
      otherParticipantName = map['otherParticipantName'];
    }
    if (ControlHelper.checkMapValue(map, 'otherParticipantFullName')) {
      otherParticipantFullName = map['otherParticipantFullName'];
    }
    if (ControlHelper.checkMapValue(map, 'otherParticipantPhoto')) {
      otherParticipantPhoto = map['otherParticipantPhoto'];
    }
    if (ControlHelper.checkMapValue(map, 'lastMessage')) {
      lastMessage = map['lastMessage'];
    }
    if (ControlHelper.checkMapValue(map, 'lastMessageSenderName')) {
      lastMessageSenderName = map['lastMessageSenderName'];
    }
    if (ControlHelper.checkMapValue(map, 'isHiddenFromFirst')) {
      isHiddenFromFirst = map['isHiddenFromFirst'];
    }
    if (ControlHelper.checkMapValue(map, 'isHiddenFromSecond')) {
      isHiddenFromSecond = map['isHiddenFromSecond'];
    }
    return this;
  }

  String toJson() => jsonEncode(toMap());

  ConversationCardView fromJson(String json) {
    toClass(jsonDecode(json));
    return this;
  }
}
