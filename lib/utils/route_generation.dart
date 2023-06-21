import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/main.dart';
import 'package:guide_up/pages/login/auth_page.dart';
import 'package:guide_up/pages/login/login_page.dart';
import 'package:guide_up/pages/profile/profile_main.dart';
import 'package:guide_up/pages/splash_screen/splash_screen.dart';

import '../pages/home/home_screen_page.dart';
import '../pages/other/error_page.dart';
import '../pages/other/test_data_conrol_page.dart';

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
      case '/main':
        return _createRoute(const MyApp(), settings);
      case '/testDataControl':
        return _createRoute(const TestDataControl(), settings);
      case '/':
        return _createRoute(HomeScreen(), settings);
      case '/loginPage':
        return _createRoute( LoginPage(), settings);
      case '/authPage':
        return _createRoute( const AuthPage(), settings);
      case '/splashScreen':
        return _createRoute(const SplashScreen(), settings);
      case '/profile':
        return _createRoute(const ProfileMain(), settings);
      default:
        return _createRoute(const ErrorPage(), settings);
    }
  }
}