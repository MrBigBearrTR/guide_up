import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant/color_constants.dart';
import '../../core/dto/post/post_card_view.dart';

class PostCard extends StatelessWidget {
  final PostCardView postCardView;

  const PostCard({Key? key, required this.postCardView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: ListTile(

        title: Text(
          postCardView.topic!,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              //fontSize: 11,
              fontWeight: FontWeight.bold,
              color: ColorConstants.theme2Dark,
            ),
          ),
        ),
        subtitle: Text(
          postCardView.content!,
          maxLines: 3,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 11,
              //fontWeight: FontWeight.bold,
              color: ColorConstants.theme2DarkBlue,
            ),
          ),
        ),
        leading: Image(image: AssetImage('assets/img/unknown_user.png'),)
      ),
    );
  }
}
