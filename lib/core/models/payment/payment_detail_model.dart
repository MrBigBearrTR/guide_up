import 'package:guide_up/core/enumeration/enums/EnPaymentType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../enumeration/extensions/ExPaymentType.dart';

/// [@author MrBigBear] 
class PaymentDetail extends GeneralFields {
  
  String? _id;
  String? _paymentId;
  EnPaymentType? _enPaymentType;
  String? _cardId;
  String? _price;
  DateTime? _paymentDate;
  String? _refundCardId;
  String? _refundPrice;
  DateTime? _refundPaymentDate;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getPaymentId() {
    return _paymentId;
  }

  void setPaymentId(String paymentId) {
    _paymentId = paymentId;
  }

  EnPaymentType? getEnPaymentType() {
    return _enPaymentType;
  }

  void setEnPaymentType(EnPaymentType enPaymentType) {
    _enPaymentType = enPaymentType;
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

  String? getRefundCardId() {
    return _refundCardId;
  }

  void setRefundCardId(String refundCardId) {
    _refundCardId = refundCardId;
  }

  String? getRefundPrice() {
    return _refundPrice;
  }

  void setRefundPrice(String refundPrice) {
    _refundPrice = refundPrice;
  }

  DateTime? getRefundPaymentDate() {
    return _refundPaymentDate;
  }

  void setRefundPaymentDate(DateTime refundPaymentDate) {
    _refundPaymentDate = refundPaymentDate;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['paymentId'] = getPaymentId();
    if (getEnPaymentType() != null) {
      map['enPaymentType'] = getEnPaymentType()!.name;
    }
    map['cardId'] = getCardId();
    map['price'] = getPrice();
    map['paymentDate'] = getPaymentDate();
    map['refundCardId'] = getRefundCardId();
    map['refundPrice'] = getRefundPrice();
    map['refundPaymentDate'] = getRefundPaymentDate();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('paymentId')) {
      setPaymentId(map['paymentId']);
    }
    if (map.containsKey('enPaymentType')) {
      setEnPaymentType(ExPaymentType.getEnum(map['enPaymentType'])!);
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
    if (map.containsKey('refundCardId')) {
      setRefundCardId(map['refundCardId']);
    }
    if (map.containsKey('refundPrice')) {
      setRefundPrice(map['refundPrice']);
    }
    if (map.containsKey('refundPaymentDate')) {
      setRefundPaymentDate(map['refundPaymentDate']);
    }
  }
}
