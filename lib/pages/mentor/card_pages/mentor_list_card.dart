import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/utils/user_info_helper.dart';

class MentorListCard extends StatelessWidget {
  final Mentor mentor;

  const MentorListCard({Key? key, required this.mentor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: ListTile(
        title: Text(
          mentor.getName()!,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.theme2Dark,
            ),
          ),
        ),
        subtitle: Text(
          mentor.getAbout() != null ? mentor.getAbout()! : "",
          maxLines: 3,
          softWrap: true,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 11,
              color: ColorConstants.theme2DarkBlue,
            ),
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              UserInfoHelper.getProfilePictureByPath(mentor.getPhoto()),
        ),
      ),
    );
  }
}
