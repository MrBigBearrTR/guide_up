import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/pages/dashboard/mentee/mentee_dashboard_main_page.dart';
import 'package:guide_up/pages/dashboard/mentor/mentor_dashboard.dart';

import '../../core/constant/color_constants.dart';

class DashboardChildMentor extends StatefulWidget {
  const DashboardChildMentor({Key? key}) : super(key: key);

  @override
  State<DashboardChildMentor> createState() => _DashboardChildMentorState();
}

class _DashboardChildMentorState extends State<DashboardChildMentor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Dashboardların',
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  color: ColorConstants.theme2Orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
          backgroundColor: ColorConstants.theme1White,
          bottom: TabBar(
            tabs: [
              Tab(
                height: 30,
                child: Text('Mentor',
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: ColorConstants.theme2Dark,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
              ),
              Tab(
                height: 30,
                child: Text('Mentee',
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: ColorConstants.theme2Dark,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MentorDashboard(),
            MenteeDashboardMainPage(),
          ],
        ),
      ),
    );
  }
}
