import 'package:guide_up/core/enumeration/enums/EnLinkType.dart';

extension ExLinksType on EnLinkType {
  String get stringDefination {
    switch (this) {
      case EnLinkType.linkedin:
        return "LinkedIn";

      case EnLinkType.instagram:
        return "Instagram";

      case EnLinkType.twitter:
        return "Twitter";

      case EnLinkType.youtube:
        return "YouTube";

      case EnLinkType.personelPage:
        return "Kişisel Sayfa";

      case EnLinkType.github:
        return "GitHub";
    }
  }

  static EnLinkType? getLink(String name) {
    for (EnLinkType en in EnLinkType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
