import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:intl/intl.dart';

import '../constant/color_constants.dart';
import '../enumeration/enums/EnLinkType.dart';

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

  static Widget getEnLinkTypeIcon(EnLinkType enLinkType) {
    switch (enLinkType) {
      case EnLinkType.linkedin:
        return const FaIcon(
          FontAwesomeIcons.linkedinIn,
          color: ColorConstants.buttonPurple,
        );
      case EnLinkType.github:
        return const FaIcon(
          FontAwesomeIcons.github,
          color: ColorConstants.buttonPurple,
        );
      case EnLinkType.youtube:
        return const FaIcon(
          FontAwesomeIcons.youtube,
          color: ColorConstants.buttonPurple,
        );
      case EnLinkType.twitter:
        return const FaIcon(
          FontAwesomeIcons.twitter,
          color: ColorConstants.buttonPurple,
        );
      case EnLinkType.instagram:
        return const FaIcon(
          FontAwesomeIcons.instagram,
          color: ColorConstants.buttonPurple,
        );
      case EnLinkType.personelPage:
        return const FaIcon(
          FontAwesomeIcons.blog,
          color: ColorConstants.buttonPurple,
        );
    }
  }

  static final dateFormat = DateFormat('dd.MM.yyyy');

  static bool hasValidUrl(String value) {
    String pattern = r'[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/+#-]*[\w@?^=%&amp;/+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
