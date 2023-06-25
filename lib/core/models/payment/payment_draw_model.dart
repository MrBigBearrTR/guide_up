import 'package:guide_up/core/enumeration/enums/EnPaymentType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../enumeration/extensions/ExPaymentType.dart';

/// [@author MrBigBear] 
class PaymentDraw extends GeneralFields {
  String? _id;
  String? _walletId;
  EnPaymentType? _enPaymentType;
  String? _iban;
  String? _price;
  DateTime? _paymentDate;
  bool _isTransfer = false;

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

  EnPaymentType? getEnPaymentType() {
    return _enPaymentType;
  }

  void setEnPaymentType(EnPaymentType enPaymentType) {
    _enPaymentType = enPaymentType;
  }

  String? getIban() {
    return _iban;
  }

  void setIban(String iban) {
    _iban = iban;
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

  bool? isTransfer() {
    return _isTransfer;
  }

  void setTransfer(bool isTransfer) {
    _isTransfer = isTransfer;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['walletId'] = getWalletId();
    if (getEnPaymentType() != null) {
      map['enPaymentType'] = getEnPaymentType()!.name;
    }
    map['iban'] = getIban();
    map['price'] = getPrice();
    map['paymentDate'] = getPaymentDate();
    map['isTransfer'] = isTransfer();
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('walletId')) {
      setWalletId(map['walletId']);
    }
    if (map.containsKey('enPaymentType')) {
      setEnPaymentType(ExPaymentType.getEnum(map['enPaymentType'])!);
    }
    if (map.containsKey('iban')) {
      setIban(map['iban']);
    }
    if (map.containsKey('price')) {
      setPrice(map['price']);
    }
    if (map.containsKey('paymentDate')) {
      setPaymentDate(map['paymentDate']);
    }
  }
}
