import 'package:guide_up/core/models/general/general_fields_model.dart';

import '../../../utils/control_helper.dart';

class UserLicenseAndCertificate extends GeneralFields {
  String? _id;
  String? _userId;
  String? _licenseName;
  String? _organization;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _authorizationId;
  String? _authorizationUrl;

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

  String? getLicenseName() {
    return _licenseName;
  }

  void setLicenseName(String licenseName) {
    _licenseName = licenseName;
  }

  String? getOrganization() {
    return _organization;
  }

  void setOrganization(String organization) {
    _organization = organization;
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

  String? getAuthorizationId() {
    return _authorizationId;
  }

  void setAuthorizationId(String authorizationId) {
    _authorizationId = authorizationId;
  }

  String? getAuthorizationUrl() {
    return _authorizationUrl;
  }

  void setAuthorizationUrl(String authorizationUrl) {
    _authorizationUrl = authorizationUrl;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = toGeneralMap();
    map['id'] = getId();
    map['userId'] = getUserId();
    map['licenseName'] = getLicenseName();
    map['organization'] = getOrganization();
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
    map['authorizationId'] = getAuthorizationId();
    map['authorizationUrl'] = getAuthorizationUrl();

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
    if (ControlHelper.checkMapValue(map, 'licenseName')) {
      setLicenseName(map['licenseName']);
    }
    if (ControlHelper.checkMapValue(map, 'organization')) {
      setOrganization(map['organization']);
    }
    if (ControlHelper.checkMapValue(map, 'startDate')) {
      setStartDate(DateTime.parse(map['startDate']));
    }
    if (ControlHelper.checkMapValue(map, 'endDate')) {
      setEndDate(DateTime.parse(map['endDate']));
    }
    if (ControlHelper.checkMapValue(map, 'authorizationId')) {
      setAuthorizationId(map['authorizationId']);
    }
    if (ControlHelper.checkMapValue(map, 'authorizationUrl')) {
      setAuthorizationUrl(map['authorizationUrl']);
    }
    return this;
  }
}
