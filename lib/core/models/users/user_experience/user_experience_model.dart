import 'package:guide_up/core/enumeration/enums/EnEmploymentType.dart';
import 'package:guide_up/core/enumeration/enums/EnLanguage.dart';
import 'package:guide_up/core/enumeration/enums/EnLocationType.dart';
import 'package:guide_up/core/enumeration/extensions/ExEmploymentType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLocationType.dart';
import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../enumeration/extensions/ExLanguage.dart';
import '../../../utils/control_helper.dart';

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
    map['industry'] = getIndustry();
    map['description'] = getDescription();
    map['link'] = getLink();
    if (getEnLanguage() != null) {
      map['enLanguage'] = getEnLanguage()!.name;
    }
    return map;
  }

  UserExperience toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'companyName')) {
      setCompanyName(map['companyName']);
    }
    if (ControlHelper.checkMapValue(map, 'jobTitle')) {
      setJobTitle(map['jobTitle']);
    }
    if (ControlHelper.checkMapValue(map, 'enEmploymentType')) {
      setEnEmploymentType(ExEmploymentType.getEnum(map['enEmploymentType'])!);
    }
    if (ControlHelper.checkMapValue(map, 'location')) {
      setLocation(map['location']);
    }
    if (ControlHelper.checkMapValue(map, 'enLocationType')) {
      setEnLocationType(ExLocationType.getEnum(map['enLocationType'])!);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setStartDate(DateTime.parse(map['startDate']));
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setEndDate(DateTime.parse(map['endDate']));
    }
    if (ControlHelper.checkMapValue(map, 'industry')) {
      setIndustry(map['industry']);
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
