import 'package:flutter/material.dart';
import 'package:guide_up/pages/other/error_page.dart';
import 'package:guide_up/pages/splash_screen/splash_screen.dart';
import 'package:guide_up/ui/navigator/navigator_child_member.dart';
import 'package:guide_up/ui/navigator/navigator_child_un_member.dart';

import '../../core/utils/secure_storage_helper.dart';
import '../../pages/splash_screen/intro_page_5.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IntroPage5();
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else {
          if (snapshot.data!) {
            return const SplashScreen();
          } else {
            return FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return IntroPage5();
                } else if (snapshot.hasError) {
                  return const ErrorPage();
                } else {
                  if (snapshot.data != null) {
                    return const NavigatorChildMember();
                  } else {
                    return const NavigatorChildUnMember();
                  }
                }
              },
              future: SecureStorageHelper().getUserDetail(),
            );
          }
        }
      },
      future: SecureStorageHelper().isFirstEnter(),
    );
  }
}
