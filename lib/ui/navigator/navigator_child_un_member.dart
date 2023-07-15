import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/constant/color_constants.dart';
import '../../pages/guide/guide_home_page.dart';
import '../../pages/home/home_screen_page.dart';
import '../../pages/search/search_main_page.dart';

class NavigatorChildUnMember extends StatefulWidget {
  const NavigatorChildUnMember({Key? key}) : super(key: key);

  @override
  State<NavigatorChildUnMember> createState() => _NavigatorChildUnMemberState();
}

class _NavigatorChildUnMemberState extends State<NavigatorChildUnMember> {

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
          const GuideHomePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        index: _selectedIndex,
        backgroundColor: ColorConstants.textwhite,
        color: ColorConstants.darkBack,
        height: 60,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: ColorConstants.textwhite,
          ),
          Icon(
            Icons.search,
            size: 25,
            color: ColorConstants.textwhite,
          ),
          Icon(
            Icons.diversity_1,
            size: 25,
            color: ColorConstants.textwhite,
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
