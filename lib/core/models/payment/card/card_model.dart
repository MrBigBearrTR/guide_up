import 'package:guide_up/core/enumeration/enums/EnPaymentCardType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExPaymentCardType.dart';

/// [@author MrBigBear] 
class Card extends GeneralFields {

  String? _id;
  String? _userId;
  EnPaymentCardType? _enPaymentCardType;
  String? _cardNumber;
  String? _cardHolder;
  String? _month;
  String? _year;

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

  EnPaymentCardType? getEnPaymentCardType() {
    return _enPaymentCardType;
  }

  void setEnPaymentCardType(EnPaymentCardType enPaymentCardType) {
    _enPaymentCardType = enPaymentCardType;
  }

  String? getCardNumber() {
    return _cardNumber;
  }

  void setCardNumber(String cardNumber) {
    _cardNumber = cardNumber;
  }

  String? getCardHolder() {
    return _cardHolder;
  }

  void setCardHolder(String cardHolder) {
    _cardHolder = cardHolder;
  }

  String? getMonth() {
    return _month;
  }

  void setMonth(String month) {
    _month = month;
  }

  String? getYear() {
    return _year;
  }

  void setYear(String year) {
    _year = year;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    if (getEnPaymentCardType() != null) {
      map['enPaymentCardType'] = getEnPaymentCardType()!.name;
    }
    map['cardNumber'] = getCardNumber();
    map['cardHolder'] = getCardHolder();
    map['month'] = getMonth();
    map['year'] = getYear();
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
    if (map.containsKey('enPaymentCardType')) {
      setEnPaymentCardType(
          ExPaymentCardType.getEnum(map['enPaymentCardType'])!);
    }
    if (map.containsKey('cardNumber')) {
      setCardNumber(map['cardNumber']);
    }
    if (map.containsKey('cardHolder')) {
      setCardHolder(map['cardHolder']);
    }
    if (map.containsKey('month')) {
      setMonth(map['month']);
    }
    if (map.containsKey('year')) {
      setYear(map['year']);
    }
  }
}
