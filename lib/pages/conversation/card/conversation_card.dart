import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';

class ConversationCard extends StatelessWidget {
  final ConversationCardView conversationCardView;
  final UserDetail userDetail;

  const ConversationCard(
      {Key? key, required this.conversationCardView, required this.userDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RouterConstants.messagesPage,
              arguments: conversationCardView);
        },
        title: Text(
          conversationCardView.otherParticipantFullName,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.darkBack,
            ),
          ),
        ),
        subtitle: Text(
          "${conversationCardView.lastMessageSenderName} : ${conversationCardView.lastMessage}",
          maxLines: 3,
          softWrap: true,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 11,
              color: ColorConstants.background,
            ),
          ),
        ),
        leading: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(snapshot.data!),
              );
            } else {
              return Text("data");
            }
          },
          future: FirebaseStorage.instance
              .ref(
                  '${FirestoreCollectionConstant.uploadProfilePicturesPath}${conversationCardView.otherParticipantUserId}')
              .getDownloadURL(),
        ),
      ),
    );
  }
}
