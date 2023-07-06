import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/core/utils/user_helper.dart';
import 'package:guide_up/repository/user/user_repository.dart';

class  UserService {
  late UserRepository _userRepository ;
  late UserHelper _userHelper ;
  UserService(){
    _userRepository = UserRepository();
    _userHelper = UserHelper() ;

  }

  Future<String> saveUserModel (UserModel userModel)async {
    var uid = await _userHelper.createUser(userModel.getEmail()! , userModel.getPassword()!);
    userModel.setId(uid);
    var userId = await _userRepository.add(userModel);

    return userId;

  }
}