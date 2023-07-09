import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant/color_constants.dart';
import '../../ui/material/custom_material.dart';

class GuideAddPage extends StatefulWidget {
  const GuideAddPage({Key? key}) : super(key: key);

  @override
  State<GuideAddPage> createState() => _GuideAddPageState();
}

class _GuideAddPageState extends State<GuideAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Guide 'in",
            style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    color: ColorConstants.theme2Dark,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        body: Container(
          decoration: CustomMaterial.backgroundBoxDecoration,
        ));
  }
}
