import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/pages/dashboard/dashboard_child_mentor.dart';
import 'package:guide_up/pages/dashboard/mentee/mentee_dashboard_main_page.dart';
import 'package:guide_up/repository/user/user_repository.dart';

import '../../core/constant/color_constants.dart';
import '../../core/utils/secure_storage_helper.dart';
import '../other/error_page.dart';
import '../splash_screen/intro_page_5.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IntroPage5();
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else {
          if (snapshot.data == null) {
            return IntroPage5();
          } else {
            return FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return IntroPage5();
                } else if (snapshot.hasError) {
                  return const ErrorPage();
                } else {
                  if (snapshot.data != null) {
                    if (snapshot.data!.isMentor()) {
                      return const DashboardChildMentor();
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          centerTitle: true,
                          title: Text('Dashboard',
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  color: ColorConstants.theme2Orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              )),
                          backgroundColor: ColorConstants.theme1White,
                        ),
                        body: const MenteeDashboardMainPage(),
                      );
                    }
                  } else {
                    return const ErrorPage();
                  }
                }
              },
              future: UserRepository().getUserByUserId(snapshot.data!),
            );
          }
        }
      },
      future: SecureStorageHelper().getUserId(),
    );
  }
}
