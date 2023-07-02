import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/pages/profile/my_profile/my_profile_account.dart';

import '../../pages/login/login_page.dart';
import '../../pages/other/error_page.dart';
import '../../pages/other/test_data_conrol_page.dart';
import '../../pages/profile/about _us/about_us.dart';
import '../../pages/profile/help_and_support/help_and_support.dart';
import '../../pages/profile/my_profile/abilities_page/abilities.dart';
import '../../pages/profile/my_profile/education_information_page/education_information.dart';
import '../../pages/profile/my_profile/my_projects_page/my_projects.dart';
import '../../pages/profile/settings/general_settings.dart';
import '../../pages/profile/profile_main.dart';
import '../../pages/register_page/register_page.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../../ui/navigator/navigator_page.dart';
import '../constant/router_constants.dart';

class RouteGenerator {
  static Route<dynamic>? _createRoute(
      Widget routeWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (builder) => routeWidget,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
        settings: settings,
        builder: (builder) => routeWidget,
      );
    } else {
      return CupertinoPageRoute(
        settings: settings,
        builder: (builder) => routeWidget,
      );
    }
  }

  static Route<dynamic>? routeGeneration(RouteSettings settings) {
    switch (settings.name) {
      case RouterConstants.testDateControllerPage:
        return _createRoute(const TestDataControl(), settings);
      case RouterConstants.homePage:
        return _createRoute(const NavigatorPage(), settings);
      case RouterConstants.loginPage:
        return _createRoute(const LoginPage(), settings);
      case RouterConstants.splashScreenPage:
        return _createRoute(const SplashScreen(), settings);
      case RouterConstants.profilePage:
        return _createRoute(const ProfileMain(), settings);
      case RouterConstants.registerPage:
        return _createRoute(const RegisterPage(), settings);
      case RouterConstants.myProfileAccountPage:
        return _createRoute(const MyProfileAccount(), settings);
      case RouterConstants.generalSettingsPage:
        return _createRoute(const GeneralSettings(), settings);
      case RouterConstants.abilities:
        return _createRoute(const Abilities(), settings);
      case RouterConstants.myProjects:
        return _createRoute(const MyProjects(), settings);
      case RouterConstants.educationInformation:
        return _createRoute(const EducationInformation(), settings);
      case RouterConstants.helpAndSupport:
        return _createRoute(const HelpAndSupport(), settings);
      case RouterConstants.aboutUs:
        return _createRoute(const AboutUs(), settings);
      default:
        return _createRoute(const ErrorPage(), settings);
    }
  }
}
