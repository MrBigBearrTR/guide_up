import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/mentor/mentor_model.dart';
import '../../../../core/utils/user_info_helper.dart';

class MenteeMyMentorCard extends StatefulWidget {
  final Mentor mentor;

  const MenteeMyMentorCard({Key? key, required this.mentor}) : super(key: key);

  @override
  State<MenteeMyMentorCard> createState() => _MenteeMyMentorCardState(mentor);
}

class _MenteeMyMentorCardState extends State<MenteeMyMentorCard> {
  _MenteeMyMentorCardState(this._mentor);

  final Mentor _mentor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              //spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        width: 300,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundImage:
                  UserInfoHelper.getProfilePictureByPath(_mentor.getPhoto()),
              radius: 35,
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  '${_mentor.getName()!} ${_mentor.getSurname()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'Kariyer Planlama Dersi',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.theme1Mustard,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 30),
            Text(
              '2 Saat',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
