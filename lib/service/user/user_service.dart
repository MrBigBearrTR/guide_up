import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/core/utils/user_helper.dart';
import 'package:guide_up/repository/user/user_repository.dart';
import 'package:guide_up/service/user/user_token_service.dart';

import '../../core/constant/secure_strorage_constant.dart';
import '../../core/enumeration/enums/EnUserType.dart';
import '../../core/models/users/user_detail/user_detail_model.dart';
import '../../repository/user/user_detail/user_detail_repository.dart';

class UserService {
  late UserRepository _userRepository;

  late UserHelper _userHelper;

  UserService() {
    _userRepository = UserRepository();
    _userHelper = UserHelper();
  }

  Future<String> saveUserModel(UserModel userModel) async {
    var uid = await _userHelper.createUser(
        userModel.getEmail()!, userModel.getPassword()!);
    userModel.setId(uid);
    var userId = await _userRepository.add(userModel);

    UserTokenService().setToken(userId);
    return userId;
  }

  Future<String> saveUserModelOnlyUidAndEmail(String uid, String email) async {
    UserModel userModel = UserModel();
    userModel.setId(uid);
    userModel.setEmail(email);

    var userId = await _userRepository.add(userModel);
    UserTokenService().setToken(userId);
    return userId;
  }

  Future<Map<EnUserType, UserCredential>>
      getUserStatusSignInWithGoogle() async {
    var userCredential = await _userHelper.signInWithGoogle();
    Map<EnUserType, UserCredential> map = {};

    final user = userCredential.user;
    if (user != null) {
      UserModel? userModel = await _userRepository.getUserByUid(user.uid);
      if (userModel == null) {
        map[EnUserType.havenNotUserModel] = userCredential;
        return map;
      }

      UserDetail? userDetail =
          await UserDetailRepository().getUserByAuthUid(user.uid);

      if (userDetail == null) {
        map[EnUserType.havenNotUserDetail] = userCredential;
        return map;
      } else {
        UserTokenService().setToken(userDetail.getUserId()!);

        const FlutterSecureStorage().write(
            key: SecureStrogeConstants.USER_DETAIL_KEY,
            value: userDetail.toJson());
        map[EnUserType.haveUserDetail] = userCredential;
        return map;
      }
    } else {
      map[EnUserType.havenNotUserModel] = userCredential;
      return map;
    }
  }

  Future<bool> checkUser() async {
    bool isSignIn = await _userHelper.checkUser();

    if (!isSignIn) {
      return false;
    }

    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      _userHelper.signOut();
      return false;
    }

    return true;
  }
}
