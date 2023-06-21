import '../../enumeration/enums/EnLikeSaveType.dart';
import '../../enumeration/extensions/ExLikeSaveType.dart';
import '../general/general_fields_model.dart';

class PostLikeSave extends GeneralFields {
  String? _id;
  String? _userId;
  String? _postId;
  EnLikeSaveType? _enLikeSaveType;

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

  String? getPostId() {
    return _postId;
  }

  void setPostId(String postId) {
    _postId = postId;
  }

  EnLikeSaveType? geEnLikeSaveType() {
    return _enLikeSaveType;
  }

  void setEnLikeSaveType(EnLikeSaveType enLikeSaveType) {
    _enLikeSaveType = enLikeSaveType;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['postId'] = getPostId();
    if (geEnLikeSaveType() != null) {
      map['enLikeSaveType'] = geEnLikeSaveType()!.name;
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
    if (map.containsKey('postId')) {
      setPostId(map['postId']);
    }
    if (map.containsKey('enLikeSaveType')) {
      setEnLikeSaveType(ExPostLikeSaveType.getEnum(map['enLikeSaveType'])!);
    }
  }
}
