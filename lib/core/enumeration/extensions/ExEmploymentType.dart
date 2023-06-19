import 'package:guide_up/core/enumeration/enums/EnEmploymentType.dart';

extension ExEmploymentType on EnEmploymentType{

  String getDisplayname(){
    switch(this){
      case EnEmploymentType.fullTime:
        return 'Tam Zamanlı';
      case EnEmploymentType.partTime:
        return 'Yarı Zamanlı';
      case EnEmploymentType.contract:
        return 'Sözleşmeli';
      case EnEmploymentType.freelance:
        return 'Serbest Çalışan';
    }
  }
  static EnEmploymentType? getEnum(String name) {
    for (EnEmploymentType en in EnEmploymentType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}