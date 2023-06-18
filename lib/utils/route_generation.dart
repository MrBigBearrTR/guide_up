import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/main.dart';
import 'package:guide_up/pages/login/login_page.dart';

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
        return _createRoute(const LoginPage(), settings);
      default:
        return _createRoute(const ErrorPage(), settings);
    }
  }
}