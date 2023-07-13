import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/models/mentor/mentee_model.dart';

class MenteeCard extends StatefulWidget {
  final Mentee mentee;
  final DateFormat dateFormat;
  const MenteeCard({Key? key,required this.mentee, required this.dateFormat}) : super(key: key);

  @override
  State<MenteeCard> createState() => _MenteeCardState(mentee);
}

class _MenteeCardState extends State<MenteeCard> {
  _MenteeCardState(Mentee mentee) {
    _mentee = mentee;
  }

  late Mentee _mentee;
  late DateFormat dateFormat;
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: Column(
        children: [
          ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_mentee.getName()!} ${_mentee.getSurname()}',
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: ColorConstants.theme2DarkBlue,
                    ),
                  ),
                ),
                Text(
                  widget.dateFormat.format(selectedDate) ??"",
                  maxLines: 1,
                  softWrap: true,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      color: ColorConstants.theme2DarkBlue,
                    ),
                  ),

                ),
              ],
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: UserInfoHelper.getProfilePictureByPath(_mentee.getPhoto()),
            ),
          ),
        ],
      ),
    );
  }
}