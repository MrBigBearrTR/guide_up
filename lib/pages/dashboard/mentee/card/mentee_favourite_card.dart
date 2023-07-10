import 'package:flutter/material.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/repository/mentor/mentor_favourite_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/mentor/mentor_favourite_model.dart';
import '../../../../core/models/mentor/mentor_model.dart';
import '../../../../core/utils/user_info_helper.dart';

class MenteeFavouriteCard extends StatefulWidget {
  final MentorFavourite mentorFavourite;

  const MenteeFavouriteCard({Key? key, required this.mentorFavourite})
      : super(key: key);

  @override
  State<MenteeFavouriteCard> createState() =>
      _MenteeFavouriteCardState(mentorFavourite);
}

class _MenteeFavouriteCardState extends State<MenteeFavouriteCard> {
  final MentorFavourite _mentorFavourite;

  _MenteeFavouriteCardState(this._mentorFavourite);

  late Mentor _mentor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                UserInfoHelper.getProfilePictureByPath(_mentor.getPhoto()),
            radius: 35,
          ),
          Column(
            children: [
              Text(
                '${_mentor.getName()!} ${_mentor.getSurname()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _mentorFavourite.getRate()! * 25,
                    height: 10,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25,
                        );
                      },
                      itemCount: _mentorFavourite.getRate(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Mobil Uygulama',
                  style: TextStyle(
                    fontSize: 8,
                    color: ColorConstants.theme1Mustard,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Bilişim Teknolojileri',
                  style: TextStyle(
                    fontSize: 8,
                    color: ColorConstants.theme2Orange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
