import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class Payment extends GeneralFields{

  String? _id;
  String? _menteeId;
  String? _mentorId;
  String? _cardId;
  String? _price;
  DateTime? _paymentDate;
  bool _isApproval=false;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getMenteeId() {
    return _menteeId;
  }

  void setMenteeId(String menteeId) {
    _menteeId = menteeId;
  }

  String? getMentorId() {
    return _mentorId;
  }

  void setMentorId(String mentorId) {
    _mentorId = mentorId;
  }

  String? getCardId() {
    return _cardId;
  }

  void setCardId(String cardId) {
    _cardId = cardId;
  }

  String? getPrice() {
    return _price;
  }

  void setPrice(String price) {
    _price = price;
  }

  DateTime? getPaymentDate() {
    return _paymentDate;
  }

  void setPaymentDate(DateTime paymentDate) {
    _paymentDate = paymentDate;
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
    map['menteeId'] = getMenteeId();
    map['mentorId'] = getMentorId();
    map['cardId'] = getCardId();
    map['price'] = getPrice();
    map['paymentDate'] = getPaymentDate();
    map['isApproval'] = isApproval();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('menteeId')) {
      setMenteeId(map['menteeId']);
    }
    if (map.containsKey('mentorId')) {
      setMentorId(map['mentorId']);
    }
    if (map.containsKey('cardId')) {
      setCardId(map['cardId']);
    }
    if (map.containsKey('price')) {
      setPrice(map['price']);
    }
    if (map.containsKey('paymentDate')) {
      setPaymentDate(map['paymentDate']);
    }
    if (map.containsKey('isApproval')) {
      setApproval(map['isApproval']);
    }
  }
}