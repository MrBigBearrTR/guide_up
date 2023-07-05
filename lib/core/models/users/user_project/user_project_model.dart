import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExLanguage.dart';
import '../../../utils/control_helper.dart';

/// [@author MrBigBear] 
class UserProject extends GeneralFields {
  String? _id;
  String? _userId;
  String? _experienceId;
  String? _jobTitle;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _description;
  String? _link;
  String? _project;
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

  String? getProject() {
    return _project;
  }

  // ignore: non_constant_identifier_names
  void setProject(String Project) {
    _project = Project;
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
    map['project'] = getProject();
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
    if (ControlHelper.checkMapValue(map, 'experienceId')) {
      setId(map['experienceId']);
    }
    if (ControlHelper.checkMapValue(map, 'jobTitle')) {
      setId(map['jobTitle']);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setId(map['startDate']);
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setId(map['endDate']);
    }
    if (ControlHelper.checkMapValue(map, 'description')) {
      setId(map['description']);
    }
    if (ControlHelper.checkMapValue(map, 'link')) {
      setId(map['link']);
    }
    if (ControlHelper.checkMapValue(map, 'project')) {
      setId(map['project']);
    }
    if (ControlHelper.checkMapValue(map, 'enLanguage')) {
      setEnLanguage(ExLanguage.getEnum(map['enLanguage'])!);
    }
  }
}
