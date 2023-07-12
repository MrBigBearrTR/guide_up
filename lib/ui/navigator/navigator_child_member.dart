import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/constant/color_constants.dart';
import '../../pages/conversation/conversation_main_page.dart';
import '../../pages/dashboard/dashboard_main.dart';
import '../../pages/guide/guide_home_page.dart';
import '../../pages/home/home_screen_page.dart';
import '../../pages/search/search_main_page.dart';

class NavigatorChildMember extends StatefulWidget {
  const NavigatorChildMember({Key? key}) : super(key: key);

  @override
  State<NavigatorChildMember> createState() => _NavigatorChildMemberState();
}

class _NavigatorChildMemberState extends State<NavigatorChildMember> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(navigationKey: navigationKey),
          SearchMainPage(navigationKey: navigationKey),
          const DashboardMain(),
          const GuideHomePage(),
          const ConversationHomePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        index: _selectedIndex,
        backgroundColor: ColorConstants.theme2White,
        color: ColorConstants.theme2Dark,
        height: 60,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: ColorConstants.theme2White,
          ),
          Icon(
            Icons.search,
            size: 25,
            color: ColorConstants.theme2White,
          ),
          Icon(
            Icons.dashboard,
            size: 25,
            color: ColorConstants.theme2White,
          ),
          Icon(
            Icons.diversity_1,
            size: 25,
            color: ColorConstants.theme2White,
          ),
          Icon(
            Icons.comment,
            size: 25,
            color: ColorConstants.theme2White,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
