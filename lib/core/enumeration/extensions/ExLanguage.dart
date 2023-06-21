import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';

extension ExLanguage on EnLanguage {

  String getDisplayName() {
    switch (this) {
      case EnLanguage.turkish:
        return 'Türkçe';
      case EnLanguage.english:
        return "İngilizce";
      default:
        return '';
    }
  }

  static EnLanguage? getEnum(String name) {
    for (EnLanguage en in EnLanguage.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
