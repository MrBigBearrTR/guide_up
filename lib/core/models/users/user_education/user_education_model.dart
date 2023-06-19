import 'package:guide_up/core/enumeration/enums/EnDegreeType.dart';
import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/enumeration/extensions/ExDegreeType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

class UserEducation extends GeneralFields {
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

  EnLanguage? getEnLanguage() {
    return _enLanguage;
  }

  void setEnLanguage(EnLanguage enLanguage) {
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
    if (getEnLanguage() != null) {
      map['enLanguage'] = getEnLanguage()!.name;
    }
    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (map.containsKey('id')) {
      setId(map['id']);
    }
    if (map.containsKey('userId')) {
      setUserId(map['userId']);
    }
    if (map.containsKey('schoolName')) {
      setSchoolName(map['schoolName']);
    }
    if (map.containsKey('department')) {
      setDepartment(map['department']);
    }
    if (map.containsKey('enDegreeType')) {
      setEnDegreeType(ExDegreeType.getEnum(map['enDegreeType'])!);
    }
    if (map.containsKey('startDate')) {
      setStartDate(map['startDate']);
    }
    if (map.containsKey('endDate')) {
      setEndDate(map['endDate']);
    }
    if (map.containsKey('grade')) {
      setGrade(map['grade']);
    }
    if (map.containsKey('description')) {
      setDescription(map['description']);
    }
    if (map.containsKey('activitiesSocienties')) {
      setActivitiesSocienties(map['activitiesSocienties']);
    }
    if (map.containsKey('link')) {
      setLink(map['link']);
    }
    if (map.containsKey('enLanguage')) {
      setEnLanguage(ExLanguage.getEnum(map['enLanguage'])!);
    }
  }
}