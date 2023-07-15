import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../utils/control_helper.dart';

/// [@author MrBigBear]
class Category extends GeneralFields {
  String? _id;
  String? _name;
  String? _mainCategory;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String? getMainCategory() {
    return _mainCategory;
  }

  void setMainCategory(String mainCategory) {
    _mainCategory = mainCategory;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['name'] = getName();
    map['mainCategory'] = getMainCategory();
    return map;
  }

  Category toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'name')) {
      setName(map['name']);
    }
    if (ControlHelper.checkMapValue(map, 'mainCategory')) {
      setMainCategory(map['mainCategory']);
    }
    return this;
  }
}
