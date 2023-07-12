import '../../../utils/control_helper.dart';
import '../../general/general_fields_model.dart';

/// [@author MrBigBear] 
class CommentLike extends GeneralFields {
  String? _id;
  String? _userId;
  String? _commentId;

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

  String? getCommentId() {
    return _commentId;
  }

  void setCommentId(String commentId) {
    _commentId = commentId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['commentId'] = getCommentId();
    return map;
  }

  CommentLike toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'commentId')) {
      setCommentId(map['commentId']);
    }
    return this;
  }
}
