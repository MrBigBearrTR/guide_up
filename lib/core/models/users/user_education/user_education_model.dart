import 'package:guide_up/core/enumeration/enums/EnDegreeType.dart';
import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserEducation extends GeneralFields{

  String? _id;
  String? _userId;
  String? _schoolName;
  String? _department;
  EnDegreeType? _enDegreeType;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _grade;
  String? _activitiesSocienties;
  String? _description;
  String? _link;
  EnLanguage? _enLanguages;

}