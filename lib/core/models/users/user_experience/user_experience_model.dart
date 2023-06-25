import 'package:guide_up/core/enumeration/enums/EnEmploymentType.dart';
import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/enumeration/enums/EnLocationType.dart';
import 'package:guide_up/core/enumeration/extensions/ExEmploymentType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLocationType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExLanguage.dart';

/// [@author MrBigBear] 
class UserExperience extends GeneralFields {
  String? _id;
  String? _userId;
  String? _companyName;
  String? _jobTitle;
  EnEmploymentType? _enEmploymentType;
  String? _location;
  EnLocationType? _enLocationType;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _industry;
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

  String? getCompanyName() {
    return _companyName;
  }

  void setCompanyName(String companyName) {
    _companyName = companyName;
  }

  String? getJobTitle() {
    return _jobTitle;
  }

  void setJobTitle(String jobTitle) {
    _jobTitle = jobTitle;
  }

  EnEmploymentType? getEnEmploymentType() {
    return _enEmploymentType;
  }

  void setEnEmploymentType(EnEmploymentType enEmploymentType) {
    _enEmploymentType = enEmploymentType;
  }

  String? getLocation() {
    return _location;
  }

  void setLocation(String location) {
    _location = location;
  }

  EnLocationType? getEnLocationType() {
    return _enLocationType;
  }

  void setEnLocationType(EnLocationType enLocationType) {
    _enLocationType = enLocationType;
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

  String? getIndustry() {
    return _industry;
  }

  void setIndustry(String industry) {
    _industry = industry;
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
    map['companyName'] = getCompanyName();
    map['jobTitle'] = getJobTitle();
    if (getEnEmploymentType() != null) {
      map['enEmploymentType'] = getEnEmploymentType()!.name;
    }
    map['location'] = getLocation();
    if (getEnLocationType() != null) {
      map['enLocationType'] = getEnLocationType()!.name;
    }
    map['startDate'] = getStartDate();
    map['endDate'] = getEndDate();
    map['industry'] = getIndustry();
    map['description'] = getDescription();
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
    if (map.containsKey('companyName')) {
      setCompanyName(map['companyName']);
    }
    if (map.containsKey('jobTitle')) {
      setJobTitle(map['jobTitle']);
    }
    if (map.containsKey('enEmploymentType')) {
      setEnEmploymentType(ExEmploymentType.getEnum(map['enEmploymentType'])!);
    }
    if (map.containsKey('location')) {
      setLocation(map['location']);
    }
    if (map.containsKey('enLocationType(')) {
      setEnLocationType(ExLocationType.getEnum(map['enLocationType'])!);
    }
    if (map.containsKey('startDate')) {
      setStartDate(map['startDate']);
    }
    if (map.containsKey('endDate')) {
      setEndDate(map['endDate']);
    }
    if (map.containsKey('industry')) {
      setIndustry(map['industry']);
    }
    if (map.containsKey('description')) {
      setDescription(map['description']);
    }
    if (map.containsKey('link')) {
      setLink(map['link']);
    }
    if (map.containsKey('enLanguage')) {
      setEnLanguage(ExLanguage.getEnum(map['enLanguage'])!);
    }
  }
}
