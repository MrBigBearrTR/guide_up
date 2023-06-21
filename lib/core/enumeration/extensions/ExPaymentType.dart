import '../enums/EnPaymentType.dart';

extension ExPaymentType on EnPaymentType {
  String getDisplayName() {
    switch (this) {
      case EnPaymentType.cash:
        return 'Nakit';
      case EnPaymentType.creditCard:
        return 'Kredi Kartı';
      case EnPaymentType.debitCard:
        return 'Banka Kartı';
      case EnPaymentType.bankTransfer:
        return 'Banka Transferi';
      case EnPaymentType.paypal:
        return 'PayPal';
      default:
        return '';
    }
  }

  static EnPaymentType? getEnum(String name) {
    for (EnPaymentType en in EnPaymentType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
