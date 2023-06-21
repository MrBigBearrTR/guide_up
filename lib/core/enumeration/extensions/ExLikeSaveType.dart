import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';

extension ExPostLikeSaveType on EnLikeSaveType {

  String getDisplayName() {
    switch (this) {
      case EnLikeSaveType.like:
        return "Like";
      case EnLikeSaveType.save:
        return "save";
      default:
        return "";
    }
  }

  static EnLikeSaveType? getEnum(String name) {
    for (EnLikeSaveType en in EnLikeSaveType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
