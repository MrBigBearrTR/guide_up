import '../../utils/control_helper.dart';
import '../general/general_fields_model.dart';

/// [@author MrBigBear] 
class PostCategories extends GeneralFields {
  String? _id;
  String? _userId;
  String? _postId;
  String? _categoryId;

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

  String? getCategoryId() {
    return _categoryId;
  }

  void setCategoryId(String categoryId) {
    _categoryId = categoryId;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['postId'] = getPostId();
    map['categoryId'] = getCategoryId();
    return map;
  }

  toClass(Map<String, dynamic> map) {
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
    if (ControlHelper.checkMapValue(map, 'categoryId')) {
      setCategoryId(map['categoryId']);
    }
  }
}
