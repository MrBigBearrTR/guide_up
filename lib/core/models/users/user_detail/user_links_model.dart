import 'package:guide_up/core/enumeration/extensions/ExLinkType.dart';

import '../../../enumeration/enums/EnLinkType.dart';
import '../../general/general_fields_model.dart';

/// [@author MrBigBear] 
class UserLinks extends GeneralFields {
  String? _id;
  String? _userId;
  String? _link;
  EnLinkType? _enLinkType;

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

  String? getLink() {
    return _link;
  }

  void setLink(String link) {
    _link = link;
  }

  EnLinkType? getEnLinkType() {
    return _enLinkType;
  }

  void setEnLinkType(EnLinkType? enLinkType) {
    _enLinkType = enLinkType;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['link'] = getLink();
    if (getEnLinkType() != null) {
      map['enLinkType'] = getEnLinkType()!.name;
    }
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
    if (map.containsKey('link')) {
      setLink(map['link']);
    }
    if (map.containsKey('enLinkType')) {
      setEnLinkType(ExLinksType.getEnum(map['enLinkType']));
    }
  }
}
