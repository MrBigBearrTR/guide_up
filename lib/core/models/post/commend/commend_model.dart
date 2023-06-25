import '../../general/general_fields_model.dart';

/// [@author MrBigBear] 
class Commend extends GeneralFields {
  String? _id;
  String? _userId;
  String? _postId;
  String? _content;
  String? _photo;

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

  String? getContent() {
    return _content;
  }

  void setContent(String content) {
    _content = content;
  }

  String? getPhoto() {
    return _photo;
  }

  void setPhoto(String photo) {
    _photo = photo;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['postId'] = getPostId();
    map['content'] = getContent();
    map['photo'] = getPhoto();
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
    if (map.containsKey('content')) {
      setContent(map['content']);
    }
    if (map.containsKey('photo')) {
      setPhoto(map['photo']);
    }
  }
}
