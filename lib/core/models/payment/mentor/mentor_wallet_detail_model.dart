import 'package:guide_up/core/models/general/general_fields_model.dart';

/// [@author MrBigBear] 
class MentorWalletDetail extends GeneralFields {
  String? _id;
  String? _walletId;
  String? _paymentId;
  String? _price;
  DateTime? _paymentDate;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getWalletId() {
    return _walletId;
  }

  void setWalletId(String walletId) {
    _walletId = walletId;
  }

  String? getPaymentId() {
    return _paymentId;
  }

  void setPaymentId(String paymentId) {
    _paymentId = paymentId;
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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['paymentId'] = getPaymentId();
    map['walletId'] = getWalletId();
    map['price'] = getPrice();
    map['paymentDate'] = getPaymentDate();
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
    if (map.containsKey('walletId')) {
      setWalletId(map['walletId']);
    }
    if (map.containsKey('price')) {
      setPrice(map['price']);
    }
    if (map.containsKey('paymentDate')) {
      setPaymentDate(map['paymentDate']);
    }
  }
}
