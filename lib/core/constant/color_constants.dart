import 'package:flutter/material.dart';
class ColorConstants {

  static const Color darkBack = Color(0xFF1f2534); //theme2Dark
  static const Color background = Color(0xFF363f51); //theme2DarkBlue
  static const Color textwhite = Color(0xFFEEEEEE);  //theme2White
  static const Color buttonPurple = Color(0xFF8c87ef); //theme2Orange
  static const Color buttonPink = Color(0xFFdc81e1); //theme2Pink

  static const Color theme2DarkOpacity20 = Color(0xFFa5a8b1); //theme2DarkOpacity20
  static const Color theme1CloudBlue = Color(0xFF52c7e4); // theme1CloudBlue
  static const Color theme1BrightCloudBlue = Color(0xFFabe679); //theme1BrightCloudBlue
  static const Color theme1PowderSkin = Color(0xFFfe6e52); //theme1PowderSkin
  static const Color theme1PowderSkinOpacity = Color(0xFFf91564); //theme1PowderSkinOpacity


  static const Color theme1Dark = Color(0xFF2E393F);  //theme1Dark
  static const Color theme1DarkBlue = Color(0xFF07617C);  //theme1DarkBlue
  static const Color theme1White = Color(0xFFECECEA); //theme1White
  static const Color theme1Mustard = Color(0xFFFAA828);  //theme1Mustard

  static const Color itemWhite = Color(0xFFFFFFFF);  //itemWhite
  static const Color itemBlack = Color(0xFF000000);  //itemBlack


  static const Color appcolor1 = Color(0xFFdc81e1);  //appcolor1
  static const Color appcolor2 = Color(0xFF8c87ef);  //appcolor2
  static const Color appcolor3 = Color(0xFF212832);  //appcolor3
  static const Color appcolor4 = Color(0xFFEDEDED);  //appcolor4


  static const Color transparent = Color(0xFFEDEDED);  //appcolor4
  static const Color danger = Color(0xFFFF4444);
  static const Color dangerDark = Color(0xFFCC0000);
  static const Color warning = Color(0xFFFFBB33);
  static const Color warningDark = Color(0xFFFF8800);
  static const Color success = Color(0xFF00C851);
  static const Color successDark = Color(0xFF007E33);
  static const Color info = Color(0xFF0E90EC);
  static const Color infoDark = Color(0xFF0099CC);








  static const List<Color> backgroundGradientColors=[
    theme1PowderSkinOpacity,
    theme1White,
    textwhite,
  ];

  static const List<Color> backgroundRegisterWithLoginColors= [
   appcolor2,
    appcolor2,
    appcolor1,
    appcolor1,
  ];

  static Color calculateSlideItemColor(int headerCount) {

    switch(headerCount){
      case 0:
        return ColorConstants.theme1White;
      case 1:
        return ColorConstants.theme1BrightCloudBlue;
      case 2:
        return ColorConstants.theme1CloudBlue;
      case 3:
        return ColorConstants.theme1PowderSkin;
      default:
        return ColorConstants.theme1White;
    }

  }
}