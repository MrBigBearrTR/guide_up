import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constant/color_constants.dart';

class CustomMaterial {
  static const backgroundBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: ColorConstants.backgroundGradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static const  backgroundRegisterWithLoginDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topCenter,
      colors: ColorConstants.backgroundRegisterWithLoginColors,
    ),
  );

}
