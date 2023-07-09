import 'package:guide_up/core/models/general/general_fields_model.dart';
import '../../utils/control_helper.dart';

/// [@author MrBigBear] 
class Post extends GeneralFields {
  String? _id;
  String? _userId;
  String? _topic;
  String? _content;
  String? _photo;
  bool _isThereCategory = false;

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

  String? getTopic() {
    return _topic;
  }

  void setTopic(String topic) {
    _topic = topic;
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

  bool isThereCategory() {
    return _isThereCategory;
  }

  void setThereCategory(bool isThereCategory) {
    _isThereCategory = isThereCategory;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['topic'] = getTopic();
    map['content'] = getContent();
    map['photo'] = getPhoto();
    map['isThereCategory'] = isThereCategory();
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
    if (ControlHelper.checkMapValue(map, 'topic')) {
      setTopic(map['topic']);
    }
    if (ControlHelper.checkMapValue(map, 'content')) {
      setContent(map['content']);
    }
    if (ControlHelper.checkMapValue(map, 'photo')) {
      setPhoto(map['photo']);
    }
    if (ControlHelper.checkMapValue(map, 'isThereCategory')) {
      setThereCategory(map['isThereCategory']);
    }
  }
}
