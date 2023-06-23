import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../pages/login/auth_page.dart';
import '../../pages/login/login_page.dart';
import '../../pages/other/error_page.dart';
import '../../pages/other/test_data_conrol_page.dart';
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
      case RouterConstants.authPage:
        return _createRoute(const AuthPage(), settings);
      case RouterConstants.splashScreenPage:
        return _createRoute(const SplashScreen(), settings);
      case RouterConstants.profilePage:
        return _createRoute(const ProfileMain(), settings);
      case RouterConstants.registerPage:
        return _createRoute(const RegisterPage(), settings);
      default:
        return _createRoute(const ErrorPage(), settings);
    }
  }
}
