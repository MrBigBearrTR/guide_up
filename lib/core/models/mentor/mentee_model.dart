import 'package:guide_up/core/models/general/general_fields_model.dart';

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

  bool? isApproval() {
    return _isApproval;
  }

  void setApproval(bool isApproval) {
    _isApproval = isApproval;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userid'] = getUserId();
    map['mentorId'] = getMentorId();
    map['startDate'] = getStartDate();
    map['endDate'] = getEndDate();
    map['price'] = getPrice();
    map['categoryId'] = getCategoryId();
    map['isApproval'] = isApproval();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('userid')) {
      setUserId(map['userid']);
    }
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (map.containsKey('startDate')) {
      setStartDate(map['startDate']);
    }
    if (map.containsKey('endDate')) {
      setEndDate(map['endDate']);
    }
    if (map.containsKey('price')) {
      setPrice(map['price']);
    }
    if (map.containsKey('categoryId')) {
      setCategoryId(map['categoryId']);
    }
    if (map.containsKey('isApproval')) {
      setApproval(map['isApproval']);
    }
  }
}
