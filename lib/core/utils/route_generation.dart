import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/pages/conversation/messages/chat_main_page.dart';
import 'package:guide_up/pages/dashboard/mentee/mentee_favourite_mentor_page.dart';
import 'package:guide_up/pages/guide/guide_add_page.dart';
import 'package:guide_up/pages/guide/guide_home_page.dart';
import 'package:guide_up/pages/profile/my_profile/my_profile_account.dart';
import 'package:guide_up/pages/register_page/register_with_detail.dart';

import '../../pages/dashboard/mentor/mentor_preview.dart';
import '../../pages/login/login_page.dart';
import '../../pages/other/error_page.dart';
import '../../pages/other/test_data_conrol_page.dart';
import '../../pages/profile/about _us/about_us.dart';
import '../../pages/profile/help_and_support/help_and_support.dart';
import '../../pages/profile/licenses_and_certificates/licences_And_Certificates.dart';
import '../../pages/profile/my_profile/abilities_page/user_abilities_page.dart';
import '../../pages/profile/my_profile/education_information_page/user_education_information.dart';
import '../../pages/profile/my_profile/projects_page/user_projects.dart';
import '../../pages/profile/profile_main.dart';
import '../../pages/profile/settings/general_settings.dart';
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

  static Route<dynamic> createExceptRoute(Widget routeWidget,
      {RouteSettings? settings}) {
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
      case RouterConstants.registerWithDetailPage:
        return _createRoute(const RegisterWithDetail(), settings);
      case RouterConstants.myProfileAccountPage:
        return _createRoute(const MyProfileAccount(), settings);
      case RouterConstants.generalSettingsPage:
        return _createRoute(const GeneralSettings(), settings);
      case RouterConstants.userAbilities:
        return _createRoute(const UserAbilitiesPage(), settings);
      case RouterConstants.userProjectPage:
        return _createRoute(const UserProjectPage(), settings);
      case RouterConstants.userEducationInformationPage:
        return _createRoute(const UserEducationInformationPage(), settings);
      case RouterConstants.helpAndSupport:
        return _createRoute(const HelpAndSupport(), settings);
      case RouterConstants.aboutUs:
        return _createRoute(const AboutUs(), settings);
      case RouterConstants.messagesPage:
        return _createRoute(const ChatMainPage(), settings);
      case RouterConstants.guideAdd:
        return _createRoute( GuideAddPage(), settings);
      case RouterConstants.guideHomePage:
        return _createRoute( const GuideHomePage(), settings);
      case RouterConstants.licensesAndCertificatesPage:
        return _createRoute(const LicensesAndCertificatesPage(), settings);
      case RouterConstants.mentorPreview:
        return _createRoute(const MentorPreview(), settings);
      case RouterConstants.menteeFavouriteMentorPage:
        return _createRoute(const MenteeFavouriteMentorPage(), settings);
      default:
        return _createRoute(const ErrorPage(), settings);
    }
  }
}
