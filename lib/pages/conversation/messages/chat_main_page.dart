import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../../core/constant/color_constants.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({Key? key}) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  late ConversationCardView conversationCardView;

  @override
  Widget build(BuildContext context) {
    conversationCardView =
        ModalRoute.of(context)!.settings.arguments as ConversationCardView;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          conversationCardView.otherParticipantFullName,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: ColorConstants.theme2Dark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
      ),
    );
  }
}
