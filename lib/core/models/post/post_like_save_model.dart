import '../../enumeration/enums/EnLikeSaveType.dart';
import '../../enumeration/extensions/ExLikeSaveType.dart';
import '../../utils/control_helper.dart';
import '../general/general_fields_model.dart';

/// [@author MrBigBear] 
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

  PostLikeSave toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'postId')) {
      setPostId(map['postId']);
    }
    if (ControlHelper.checkMapValue(map, 'enLikeSaveType')) {
      setEnLikeSaveType(ExPostLikeSaveType.getEnum(map['enLikeSaveType'])!);
    }
    return this;
  }
}
