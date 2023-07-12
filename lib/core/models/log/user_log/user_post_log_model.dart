import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class UserPostLog extends GeneralFields {
  String? _id;
  String? _userId;
  String? _postId;

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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['postId'] = getPostId();
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
  }
}
