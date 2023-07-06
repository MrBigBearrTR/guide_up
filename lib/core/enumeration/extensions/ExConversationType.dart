import 'package:guide_up/core/enumeration/enums/EnConversationType.dart';

extension ExConversationType on EnConversationType{

  String getDisplayName() {
    switch (this) {
      case EnConversationType.directMessage:
        return "Direkt Mesaj";
      default:
        return "";
    }
  }

  static EnConversationType? getEnum(String name) {
    for (EnConversationType en in EnConversationType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}