import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/constant/color_constants.dart';
import '../../service/conversation/conversation_service.dart';
import '../../ui/material/custom_material.dart';
import 'card/conversation_card.dart';

class ConversationHomePage extends StatefulWidget {
  const ConversationHomePage({Key? key}) : super(key: key);

  @override
  State<ConversationHomePage> createState() => _ConversationHomePageState();
}

class _ConversationHomePageState extends State<ConversationHomePage> {
  UserDetail? userDetail;
  final ScrollController _scrollController = ScrollController();
  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    getUserDetail(context);
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {});
      } else if (_scrollController.offset ==
          _scrollController.position.minScrollExtent) {
        setState(() {});
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Konuşmalarım",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: ColorConstants.theme2Dark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
              child: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh))),
        ],
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: userDetail != null
            ? FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Konuşmalarıma erişirken hata ile karşılaşıldı.',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.theme2Dark,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                      return Center(
                        child: Text(
                          'Hiç konuşmanız yok :(',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.theme2Dark,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final conversationCardView = snapshot.data![index];
                          return ConversationCard(
                              conversationCardView: conversationCardView,
                              userDetail: userDetail!);
                        },
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                      );
                    }
                  }
                },
                future: ConversationService()
                    .getConversationCardViewByUserId(userDetail, 0),
              )
            : Center(
                child: Text(
                  'Hiç konuşmanız yok :(',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.theme2Dark,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void getUserDetail(BuildContext context) async {
    if (userDetail == null) {
      var tempUserDetail = await SecureStorageHelper().getUserDetail();
      if (tempUserDetail == null) {
        //Navigator.pushReplacementNamed(context, RouterConstants.loginPage);
      } else {
        userDetail = tempUserDetail;
        setState(() {});
      }
    }
  }
}
