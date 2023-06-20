import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExLanguage.dart';

class UserProject extends GeneralFields {
  String? _id;
  String? _userId;
  String? _experienceId;
  String? _jobTitle;
  DateTime? _startDate;
  DateTime? _endDate;
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

  String? getExperienceId() {
    return _experienceId;
  }

  void setExperienceId(String experienceId) {
    _experienceId = experienceId;
  }

  String? getJobTitle() {
    return _jobTitle;
  }

  void setJobTitle(String jobTitle) {
    _jobTitle = jobTitle;
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
    map['experienceId'] = getExperienceId();
    map['jobTitle'] = getJobTitle();
    map['startDate'] = getStartDate();
    map['endDate'] = getEndDate();
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
    if (map.containsKey('experienceId')) {
      setExperienceId(map['experienceId']);
    }
    if (map.containsKey('jobTitle')) {
      setJobTitle(map['jobTitle']);
    }
    if (map.containsKey('startDate')) {
      setStartDate(map['startDate']);
    }
    if (map.containsKey('endDate')) {
      setEndDate(map['endDate']);
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
