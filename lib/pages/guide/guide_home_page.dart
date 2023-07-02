import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../core/constant/color_constants.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  State<GuideHomePage> createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Guide",
          style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                  color: ColorConstants.theme2Dark,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
      ),
    );
  }
}
