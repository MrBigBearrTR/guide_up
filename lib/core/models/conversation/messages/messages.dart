import 'package:guide_up/core/enumeration/enums/EnMediaType.dart';
import 'package:guide_up/core/enumeration/extensions/ExMediaType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

class Messages extends GeneralFields {
  String? _id;
  String? _conversationId;
  String? _senderUserId;
  String? _receiverUserId;
  String? _content;
  EnMediaType? _enMediaType;
  String? _mediaUrl;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getConversationId() {
    return _conversationId;
  }

  void setConversationId(String conversationId) {
    _conversationId = conversationId;
  }

  String? getSenderUserId() {
    return _senderUserId;
  }

  void setSenderUserId(String senderUserId) {
    _senderUserId = senderUserId;
  }

  String? getReceiverUserId() {
    return _receiverUserId;
  }

  void setReceiverUserId(String receiverUserId) {
    _receiverUserId = receiverUserId;
  }

  String? getContent() {
    return _content;
  }

  void setContent(String content) {
    _content = content;
  }

  EnMediaType? getEnMediaType() {
    return _enMediaType;
  }

  void setEnMediaType(EnMediaType enMediaType) {
    _enMediaType = enMediaType;
  }

  String? getMediaUrl() {
    return _mediaUrl;
  }

  void setMediaUrl(String mediaUrl) {
    _mediaUrl = mediaUrl;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['conversationId'] = getConversationId();
    map['senderUserId'] = getSenderUserId();
    map['receiverUserId'] = getReceiverUserId();
    map['content'] = getContent();
    if (getEnMediaType() != null) {
      map['enMediaType'] = getEnMediaType()!.name;
    }
    map['mediaUrl'] = getMediaUrl();

    return map;
  }

  Messages toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }

    if (ControlHelper.checkMapValue(map, 'conversationId')) {
      setConversationId(map['conversationId']);
    }

    if (ControlHelper.checkMapValue(map, 'senderUserId')) {
      setSenderUserId(map['senderUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'receiverUserId')) {
      setReceiverUserId(map['receiverUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'content')) {
      setContent(map['content']);
    }

    if (ControlHelper.checkMapValue(map, 'enMediaType')) {
      setEnMediaType(ExMediaType.getEnum(map['enMediaType'])!);
    }

    if (ControlHelper.checkMapValue(map, 'mediaUrl')) {
      setReceiverUserId(map['mediaUrl']);
    }
    return this;
  }
}
