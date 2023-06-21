import 'package:guide_up/core/enumeration/enums/EnLocationType.dart';

extension ExLocationType on EnLocationType {

  String getDisplayName() {
    switch (this) {
      case EnLocationType.onSite:
        return 'Yüz Yüze';
      case EnLocationType.hybrid:
        return 'Hibrit';
      case EnLocationType.remote:
        return 'Uzaktan';
    }
  }

  static EnLocationType? getEnum(String name) {
    for (EnLocationType en in EnLocationType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
