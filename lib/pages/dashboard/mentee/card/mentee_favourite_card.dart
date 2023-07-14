import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/mentor/mentor_model.dart';
import '../../../../core/utils/user_info_helper.dart';

class MenteeFavouriteCard extends StatefulWidget {

  final Mentor mentor;

  const MenteeFavouriteCard({Key? key, required this.mentor}) : super(key: key);

  @override
  State<MenteeFavouriteCard> createState() => _MenteeFavouriteCardState(mentor);
}

class _MenteeFavouriteCardState extends State<MenteeFavouriteCard> {
  _MenteeFavouriteCardState(this._mentor);

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
            const SizedBox(width: 10,),
            CircleAvatar(
              backgroundImage:
                  UserInfoHelper.getProfilePictureByPath(_mentor.getPhoto()),
              radius: 35,
            ),
            const SizedBox(width: 10),
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
                      fontSize: 12,
                      color: ColorConstants.theme1Mustard,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Bilişim Teknolojileri',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.theme2Orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            IconButton(
                onPressed: () {},
                icon: const Icon(
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