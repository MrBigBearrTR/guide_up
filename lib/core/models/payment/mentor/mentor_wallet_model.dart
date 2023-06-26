import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class MentorWallet extends GeneralFields {
  String? _id;
  String? _mentorId;
  String? _price;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getMentorId() {
    return _mentorId;
  }

  void setMentorId(String mentorId) {
    _mentorId = mentorId;
  }

  String? getPrice() {
    return _price;
  }

  void setPrice(String price) {
    _price = price;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['mentorId'] = getMentorId();
    map['price'] = getPrice();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (map.containsKey('price')) {
      setPrice(map['price']);
    }
  }
}
