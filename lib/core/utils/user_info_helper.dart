import 'package:flutter/cupertino.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';

class UserInfoHelper {

  static ImageProvider<Object> getProfilePictureByPath(String? path) {
    if (path != null && path.isNotEmpty) {
      return NetworkImage(path);
    } else {
      return const AssetImage("assets/img/unknown_user.png");
    }
  }

  static ImageProvider<Object> getProfilePicture(UserDetail? userDetail) {
    if (isProfileNotEmpty(userDetail)) {
      return NetworkImage(userDetail!.getPhoto()!);
    } else {
      return const AssetImage("assets/img/unknown_user.png");
    }
  }

  static bool isProfileNotEmpty(UserDetail? userDetail) {
    if (userDetail != null && userDetail.getPhoto() != null) {
      return true;
    } else {
      return false;
    }
  }
}
