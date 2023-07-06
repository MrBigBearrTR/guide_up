import 'package:guide_up/core/enumeration/enums/EnMediaType.dart';

extension ExMediaType on EnMediaType {
  String getDisplayName() {
    switch (this) {
      case EnMediaType.image:
        return "Resim";
      case EnMediaType.video:
        return "Video";
      case EnMediaType.gif:
        return "Gif";
      case EnMediaType.sound:
        return "Ses";
      case EnMediaType.document:
        return "Belge";
      default:
        return "";
    }
  }

  static EnMediaType? getEnum(String name) {
    for (EnMediaType en in EnMediaType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
