import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../utils/control_helper.dart';

/// [@author MrBigBear]
class Mentee extends GeneralFields {
  String? _id;
  String? _userId;
  String? _mentorId;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _price;
  String? _categoryId;
  bool _isApproval = false;

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

  String? getMentorId() {
    return _mentorId;
  }

  void setMentorId(String mentorId) {
    _mentorId = mentorId;
  }

  DateTime? getStartDate() {
    return _startDate;
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
  }

  DateTime? getEndDate() {
    return _endDate;
  }

  void setEndDate(DateTime endDate) {
    _endDate = endDate;
  }

  String? getPrice() {
    return _price;
  }

  void setPrice(String price) {
    _price = price;
  }

  String? getCategoryId() {
    return _categoryId;
  }

  void setCategoryId(String categoryId) {
    _categoryId = categoryId;
  }

  bool isApproval() {
    return _isApproval;
  }

  void setApproval(bool isApproval) {
    _isApproval = isApproval;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['mentorId'] = getMentorId();
    if (getStartDate() != null) {
      map['startDate'] = getStartDate().toString();
    } else {
      map['startDate'] = getStartDate();
    }
    if (getEndDate() != null) {
      map['endDate'] = getEndDate().toString();
    } else {
      map['endDate'] =  getEndDate();
    }
    map['price'] = getPrice();
    map['categoryId'] = getCategoryId();
    map['isApproval'] = isApproval();
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
    if (ControlHelper.checkMapValue(map, 'mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setStartDate(DateTime.parse(map['startDate']));
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setEndDate(DateTime.parse(map['endDate']));
    }
    if (ControlHelper.checkMapValue(map, 'price')) {
      setPrice(map['price']);
    }
    if (ControlHelper.checkMapValue(map, 'categoryId')) {
      setCategoryId(map['categoryId']);
    }
    if (ControlHelper.checkMapValue(map, 'isApproval')) {
      setApproval(map['isApproval']);
    }
  }
}
