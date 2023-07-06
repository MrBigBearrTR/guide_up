import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/conversation/card/conversation_card.dart';
import 'package:guide_up/service/conversation/conversation_service.dart';

import '../../core/constant/color_constants.dart';
import '../../ui/material/custom_material.dart';

class ConversationHomePage extends StatefulWidget {
  const ConversationHomePage({Key? key}) : super(key: key);

  @override
  State<ConversationHomePage> createState() => _ConversationHomePageState();
}

class _ConversationHomePageState extends State<ConversationHomePage> {
  UserDetail? userDetail;

  @override
  Widget build(BuildContext context) {
    getUserDetail(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Konuşmalarım",
          style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                  color: ColorConstants.theme2Dark,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Konuşmalarıma erişirken hata ile karşılaşıldı.'),
              );
            } else {
              if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                return const Center(
                  child: Text('Hiç konuşmanız yok :('),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final conversationCardView = snapshot.data![index];
                    return ConversationCard(
                        conversationCardView: conversationCardView,
                        userDetail: userDetail!);
                  },
                  itemCount: snapshot.data!.length,
                  //scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                );
              }
            }
          },
          future: ConversationService().getConversationCardViewByUserId(
              (userDetail != null ? userDetail!.getUserId()! : ""), 0),
        ),
      ),
    );
  }

  void getUserDetail(BuildContext context) async {
    if (userDetail == null) {
      var tempUserDetail = await SecureStorageHelper().getUserDetail();
      if (tempUserDetail == null) {
        Navigator.pushReplacementNamed(context, RouterConstants.loginPage);
      } else {
        userDetail = tempUserDetail;
      }
    }
  }
}
