import 'package:guide_up/core/enumeration/enums/EnMediaType.dart';
import 'package:guide_up/core/enumeration/extensions/ExMediaType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

class Messages extends GeneralFields {

  String? _id;
  String? _senderUserId;
  String? _receiverUserId;
  EnMediaType? _enMediaType;
  String? _mediaUrl;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
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
    map['senderUserId'] = getSenderUserId();
    map['receiverUserId'] = getReceiverUserId();
    if (getEnMediaType() != null) {
      map['enMediaType'] = getEnMediaType()!.name;
    }
    map['mediaUrl'] = getMediaUrl();

    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }

    if (ControlHelper.checkMapValue(map, 'senderUserId')) {
      setSenderUserId(map['senderUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'receiverUserId')) {
      setReceiverUserId(map['receiverUserId']);
    }

    if (ControlHelper.checkMapValue(map, 'enMediaType')) {
      setEnMediaType(ExMediaType.getEnum(map['enMediaType'])!);
    }

    if (ControlHelper.checkMapValue(map, 'mediaUrl')) {
      setReceiverUserId(map['mediaUrl']);
    }
  }
}
