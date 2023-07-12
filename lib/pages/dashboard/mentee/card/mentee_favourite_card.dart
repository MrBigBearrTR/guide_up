import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/mentor/mentor_model.dart';
import '../../../../core/utils/user_info_helper.dart';

class MenteeFavouriteCard extends StatefulWidget {
  // final MentorFavourite mentorFavourite;

  // const MenteeFavouriteCard({Key? key, required this.mentorFavourite})
  //     : super(key: key);

  final Mentor mentor;

  const MenteeFavouriteCard({Key? key, required this.mentor}) : super(key: key);

  @override
  State<MenteeFavouriteCard> createState() => _MenteeFavouriteCardState(mentor);
  //_MenteeFavouriteCardState(mentorFavourite);
}

class _MenteeFavouriteCardState extends State<MenteeFavouriteCard> {
  _MenteeFavouriteCardState(Mentor mentor);

  _MentorCardState(Mentor mentor) {
    _mentor = mentor;
  }

  late Mentor _mentor;
  // final MentorFavourite _mentorFavourite;

  // _MenteeFavouriteCardState(this._mentorFavourite);

  // late Mentor _mentor;

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
                      width: _mentor.getRate()! * 25,
                      height: 10,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 25,
                          );
                        },
                        itemCount: _mentor.getRate(),
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
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                )),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }
}