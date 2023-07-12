import '../../../utils/control_helper.dart';
import '../../general/general_fields_model.dart';

/// [@author MrBigBear] 
class Comment extends GeneralFields {
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

  Comment toClass(Map<String, dynamic> map) {
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
    if (ControlHelper.checkMapValue(map, 'content')) {
      setContent(map['content']);
    }
    if (ControlHelper.checkMapValue(map, 'photo')) {
      setPhoto(map['photo']);
    }
    return this;
  }
}
