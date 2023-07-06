import 'package:guide_up/core/enumeration/enums/EnDegreeType.dart';
import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/enumeration/extensions/ExDegreeType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

/// [@author MrBigBear] 
class UserEducation extends GeneralFields {
  String? _id;
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _schoolName;
  String? _department;
  EnDegreeType? _enDegreeType;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _grade;
  String? _activitiesSocienties;
  String? _description;
  String? _link;
  String? _educationInformation;
  EnLanguage? _enLanguage;

  String? getId() {
    return _id;
  }

  void setId(String id) {
    _id = id;
  }

  String? getUserId() {
    return _userId;
  }

  void setUserId(String userId) {
    _userId = userId;
  }
  String? getFirstName() {
    return _firstName;
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
  }
  String? getLastName() {
    return _lastName;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  String? getSchoolName() {
    return _schoolName;
  }

  void setSchoolName(String schoolName) {
    _schoolName = schoolName;
  }

  String? getDepartment() {
    return _department;
  }

  void setDepartment(String department) {
    _department = department;
  }

  EnDegreeType? getEnDegreeType() {
    return _enDegreeType;
  }

  void setEnDegreeType(EnDegreeType enDegreeType) {
    _enDegreeType = enDegreeType;
  }

  DateTime? getStartDate() {
    return _startDate;
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
  }

  DateTime? getEndDate() {
    return _endDate;
  }

  void setEndDate(DateTime endDate) {
    _endDate = endDate;
  }

  String? getGrade() {
    return _grade;
  }

  void setGrade(String grade) {
    _grade = grade;
  }

  String? getActivitiesSocienties() {
    return _activitiesSocienties;
  }

  void setActivitiesSocienties(String grade) {
    _activitiesSocienties = grade;
  }

  String? getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  String? getLink() {
    return _link;
  }

  void setLink(String link) {
    _link = link;
  }

  String? getEducationInformation() {
    return _educationInformation;
  }

  void setEducationInformation(String educationInformation) {
    _educationInformation = educationInformation;
  }

  EnLanguage? getEnLanguage() {
    return _enLanguage;
  }

  void setEnLanguage(EnLanguage? enLanguage) {
    _enLanguage = enLanguage;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['schoolName'] = getSchoolName();
    map['department'] = getDepartment();
    if (getEnDegreeType() != null) {
      map['enDegreeType'] = getEnDegreeType()!.name;
    }
    map['startDate'] = getStartDate();
    map['endDate'] = getEndDate();
    map['grade'] = getGrade();
    map['description'] = getDescription();
    map['activitiesSocienties'] = getActivitiesSocienties();
    map['link'] = getLink();
    map['educationInformation'] = getEducationInformation();
    if (getEnLanguage() != null) {
      map['enLanguage'] = getEnLanguage()!.name;
    }
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'schoolName')) {
      setId(map['schoolName']);
    }
    if (ControlHelper.checkMapValue(map, 'department')) {
      setId(map['department']);
    }
    if (ControlHelper.checkMapValue(map, 'enDegreeType')) {
      setEnDegreeType(ExDegreeType.getEnum(map['enDegreeType'])!);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setId(map['startDate']);
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setId(map['endDate']);
    }
    if (ControlHelper.checkMapValue(map, 'grade')) {
      setId(map['grade']);
    }
    if (ControlHelper.checkMapValue(map, 'description')) {
      setId(map['description']);
    }
    if (ControlHelper.checkMapValue(map, 'activitiesSocienties')) {
      setId(map['activitiesSocienties']);
    }
    if (ControlHelper.checkMapValue(map, 'link')) {
      setId(map['link']);
    }
    if (ControlHelper.checkMapValue(map, 'educationInformation')) {
      setId(map['educationInformation']);
    }
    if (ControlHelper.checkMapValue(map, 'enLanguage')) {
      String language = map['enLanguage'];
      setEnLanguage(ExLanguage.getEnum(language));
    }

  }
}
