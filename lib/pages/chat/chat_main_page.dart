import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant/color_constants.dart';
import '../../ui/material/custom_material.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({Key? key}) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mesajlar",
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
