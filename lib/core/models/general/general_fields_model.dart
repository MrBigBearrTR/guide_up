class GeneralFields {

  bool _isActive = true;
  DateTime? _createDate;
  String? _createUser;
  DateTime? _updateDate;
  String? _updateUser;

  bool isActive() {
    return _isActive;
  }

  void setIsActive(bool isActive) {
    _isActive = isActive;
  }

  DateTime? getCreateDate() {
    return _createDate;
  }

  void setCreateDate(DateTime? createDate) {
    _createDate = createDate;
  }

  String? getCreateUser() {
    return _createUser;
  }

  void setCreateUser(String? createUser) {
    _createUser = createUser;
  }

  DateTime? getUpdateDate() {
    return _updateDate;
  }

  void setUpdateDate(DateTime? updateDate) {
    _updateDate = updateDate;
  }

  String? getUpdateUser() {
    return _updateUser;
  }

  void setUpdateUser(String? updateUser) {
    _updateUser = updateUser;
  }

  Map<String, dynamic> toGeneralMap(){
    Map<String, dynamic> map={};
    map['isActive']=isActive();
    map['createDate']=getCreateDate();
    map['createUser']=getCreateUser();
    map['updateDate']=getUpdateDate();
    map['updateUser']=getUpdateUser();
    return map;
  }

  toGeneralClass(Map<String, dynamic> map){

    if(map.containsKey('_isActive')) {
      setIsActive(map['_isActive']);
    }
    if(map.containsKey('createDate')) {
      setCreateDate(map['createDate']);
    }
    if(map.containsKey('createUser')) {
      setCreateUser(map['createUser']);
    }
    if(map.containsKey('updateDate')) {
      setUpdateDate(map['updateDate']);
    }
    if(map.containsKey('updateUser')) {
      setUpdateUser(map['updateUser']);
    }

  }


}
