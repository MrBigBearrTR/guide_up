import 'package:guide_up/core/enumeration/enums/EnDegreeType.dart';

extension ExDegreeType on EnDegreeType {

  String getDisplayName() {
    switch (this) {
      case EnDegreeType.associateDegree:
        return 'Ön Lisans';
      case EnDegreeType.bachelorsDegree:
        return "Lisans";
      case EnDegreeType.mastersDegree:
        return "Yüksek Lisans";
      case EnDegreeType.doctoralDegree:
        return "Doktora";
      case EnDegreeType.professionalDegree:
        return "Profesyonel Derece";
      case EnDegreeType.postgraduateCertificate:
        return "Lisansüstü Sertifika";
      case EnDegreeType.diplomaOrCertificateProgram:
        return "Diploma veya Sertifika Programı";
      case EnDegreeType.highSchoolDiplomaOrEquivalent:
        return "Lise Diploması veya Eşdeğeri";
      case EnDegreeType.vocationalOrTradeSchoolCertification:
        return "Meslek veya Meslek Okulu Sertifikası";
      case EnDegreeType.onlineCourseCertification:
        return "Online Kurs Sertifikası";
      case EnDegreeType.continuingEducationProgram:
        return "Sürekli Eğitim Programı";
      case EnDegreeType.nonDegreeOrAuditCourse:
        return "Derecesiz veya Denetimli Kurs";
      default:
        return '';
    }
  }

  static EnDegreeType? getEnum(String name) {
    for (EnDegreeType en in EnDegreeType.values) {
      if (en.name == name) {
        return en;
      }
    }

    return null;
  }
}
