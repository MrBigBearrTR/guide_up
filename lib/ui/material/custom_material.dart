import 'package:flutter/cupertino.dart';

import '../../core/constant/color_constants.dart';

class CustomMaterial {
  static const backgroundBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: ColorConstants.backgroundGradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
