import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

class UserLicenseAndCertificate extends GeneralFields {
  String? _id;
  String? _userId;
  String? _name;
  String? _organization;
  String? _issueDate;
  String? _expiryDate;
  String? _qualificationId;
  String? _qualificationUrl;

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

  String? getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String? getOrganization() {
    return _organization;
  }

  void setOrganization(String organization) {
    _organization = organization;
  }

  String? getIssueDate() {
    return _issueDate;
  }

  void setIssueDate(String issueDate) {
    _issueDate = issueDate;
  }

  String? getExpiryDate() {
    return _expiryDate;
  }

  void setExpiryDate(String expiryDate) {
    _expiryDate = expiryDate;
  }

  String? getQualificationId() {
    return _qualificationId;
  }

  void setQualificationId(String qualificationId) {
    _qualificationId = qualificationId;
  }

  String? getQualificationUrl() {
    return _qualificationUrl;
  }

  void setQualificationUrl(String qualificationUrl) {
    _qualificationUrl = qualificationUrl;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['name'] = getName();
    map['organization'] = getOrganization();
    map['issueDate'] = getIssueDate();
    map['expiryDate'] = getExpiryDate();
    map['qualificationId'] = getQualificationId();
    map['qualificationUrl'] = getQualificationUrl();

    return map;
  }

  toClass(Map<String, dynamic> map) {
    toGeneralClass(map);

    if (ControlHelper.checkMapValue(map, 'id')) {
      setId(map['id']);
    }
    if (ControlHelper.checkMapValue(map, 'userId')) {
      setUserId(map['userId']);
    }
    if (ControlHelper.checkMapValue(map, 'name')) {
      setName(map['name']);
    }
    if (ControlHelper.checkMapValue(map, 'organization')) {
      setOrganization(map['organization']);
    }
    if (ControlHelper.checkMapValue(map, 'issueDate')) {
      setIssueDate(map['issueDate']);
    }
    if (ControlHelper.checkMapValue(map, 'expiryDate')) {
      setExpiryDate(map['expiryDate']);
    }
    if (ControlHelper.checkMapValue(map, 'qualificationId')) {
      setQualificationId(map['qualificationId']);
    }
    if (ControlHelper.checkMapValue(map, 'qualificationUrl')) {
      setQualificationUrl(map['qualificationUrl']);
    }
  }
}
