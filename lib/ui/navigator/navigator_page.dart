import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/pages/home/home_screen_page.dart';
import 'package:guide_up/pages/login/login_page.dart';
import 'package:guide_up/pages/search/search_main_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          SearchMainPage(),
          LoginPage(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: ColorConstants.theme2White,
        color: ColorConstants.theme2Dark,
        height: 60,
        items: const <Widget>[
          Icon(Icons.home, size: 25,color: ColorConstants.theme2White,),
          Icon(Icons.search, size: 25,color: ColorConstants.theme2White,),
          Icon(Icons.dashboard, size: 25,color: ColorConstants.theme2White,),
          Icon(Icons.diversity_1, size: 25,color: ColorConstants.theme2White,),
          Icon(Icons.comment, size: 25,color: ColorConstants.theme2White,),
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
