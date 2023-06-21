import '../enums/EnPaymentCardType.dart';

extension ExPaymentCardType on EnPaymentCardType {

  String getDisplayName() {
    switch (this) {
      case EnPaymentCardType.visa:
        return 'Visa';
      case EnPaymentCardType.mastercard:
        return 'Mastercard';
      case EnPaymentCardType.amex:
        return 'American Express';
      case EnPaymentCardType.discover:
        return 'Discover';
      default:
        return '';
    }
  }

  static EnPaymentCardType? getEnum(String name) {
    for (EnPaymentCardType en in EnPaymentCardType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}