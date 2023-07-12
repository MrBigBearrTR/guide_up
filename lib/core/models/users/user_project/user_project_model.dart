import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExLanguage.dart';
import '../../../utils/control_helper.dart';

/// [@author MrBigBear]
class UserProject extends GeneralFields {
  String? _id;
  String? _userId;
  String? _experienceId;
  String? _projectTitle;
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

  String? getProjectTitle() {
    return _projectTitle;
  }

  void setProjectTitle(String projectTitle) {
    _projectTitle = projectTitle;
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
    map['projectTitle'] = getProjectTitle();
    if (getStartDate() != null) {
      map['startDate'] = getStartDate().toString();
    } else {
      map['startDate'] = getStartDate();
    }
    if (getEndDate() != null) {
      map['endDate'] = getEndDate().toString();
    } else {
      map['endDate'] = getEndDate();
    }
    map['description'] = getDescription();
    map['link'] = getLink();
    if (getEnLanguage() != null) {
      map['enLanguage'] = getEnLanguage()!.name;
    }
    return map;
  }

  UserProject toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'experienceId')) {
      setExperienceId(map['experienceId']);
    }
    if (ControlHelper.checkMapValue(map, 'projectTitle')) {
      setProjectTitle(map['projectTitle']);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setStartDate(DateTime.parse(map['startDate']));
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setEndDate(DateTime.parse(map['endDate']));
    }
    if (ControlHelper.checkMapValue(map, 'description')) {
      setDescription(map['description']);
    }
    if (ControlHelper.checkMapValue(map, 'link')) {
      setLink(map['link']);
    }
    if (ControlHelper.checkMapValue(map, 'enLanguage')) {
      setEnLanguage(ExLanguage.getEnum(map['enLanguage'])!);
    }
    return this;
  }
}
