import 'package:flutter/material.dart';
class ColorConstants {
  static const Color itemWhite = Color(0xFFFFFFFF);
  static const Color itemBlack = Color(0xFF000000);
  static const Color appcolor1 = Color(0xFFD26409);
  static const Color appcolor2 = Color(0xFF2C394C);
  static const Color appcolor3 = Color(0xFF212832);
  static const Color appcolor4 = Color(0xFFEDEDED);
  static const Color danger = Color(0xFFFF4444);
  static const Color dangerDark = Color(0xFFCC0000);
  static const Color warning = Color(0xFFFFBB33);
  static const Color warningDark = Color(0xFFFF8800);
  static const Color success = Color(0xFF00C851);
  static const Color successDark = Color(0xFF007E33);
  static const Color info = Color(0xFF0E90EC);
  static const Color infoDark = Color(0xFF0099CC);


  static const Color theme1Dark = Color(0xFF2E393F);
  static const Color theme1DarkBlue = Color(0xFF07617C);
  static const Color theme1White = Color(0xFFECECEA);
  static const Color theme1Mustard = Color(0xFFFAA828);

  static const Color theme2Dark = Color(0xFF212832);
  static const Color theme2DarkBlue = Color(0xFF2C4059);
  static const Color theme2White = Color(0xFFEEEEEE);
  static const Color theme2Orange = Color(0xFFFE5722);

  static const Color theme2DarkOpacity20 = Color(0x33212832);
  static const Color theme1CloudBlue = Color(0xFF98C2D0);
  static const Color theme1BrightCloudBlue = Color(0xFFDAE4EC);
  static const Color theme1PowderSkin = Color(0xFFF6E0CD);
  static const Color theme1PowderSkinOpacity = Color(0x73F6E0CD);

  static const List<Color> backgroundGradientColors=[
    theme1PowderSkinOpacity,
    theme1White,
    theme2White,
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