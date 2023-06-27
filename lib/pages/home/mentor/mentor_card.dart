import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/repository/mentor/mentor_repository.dart';

class MentorCard extends StatefulWidget {
  final Mentor mentor;

  const MentorCard({Key? key, required this.mentor}) : super(key: key);

  @override
  State<MentorCard> createState() => _MentorCardState(mentor);
}

class _MentorCardState extends State<MentorCard> {
  _MentorCardState(Mentor mentor) {
    _mentor = mentor;
  }

  //List<Mentor> _topMentorlist = [];
  late Mentor _mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            //spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      width: 150,
      margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQEIKjOOeI3xjQ/profile-displayphoto-shrink_800_800/0/1679749604159?e=2147483647&v=beta&t=S_nH42SUC7g-mMjInbFLzwODI4XC34UTFJq-g_PUtUs'),
            radius: 35,
          ),
          Text(
            '${_mentor.getName()!} ${_mentor.getLastname()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ListView.builder(
          //       itemBuilder: (context, index) {
          //         return Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //           size: 2,
          //         );
          //       },
          //       itemCount: _mentor.getRate(),
          //     ),
          //   ],
          // ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'Mobil Uygulama',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            color: ColorConstants.theme1CloudBlue,
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'Bilişim Teknolojileri',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            color: ColorConstants.theme1BrightCloudBlue,
          ),
        ],
      ),
    );
  }
}

/*
ListView(
      children: [ ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(_mentor.getPhoto() ?? 'Veri Yok'),
        ),
        title: Text(_mentor.getName() ?? 'Veri Yok'),
        subtitle: Text('Rate: ${_mentor.getRate() ?? 0}'),
      ),
      ListTile(title: Text('Yazılım'),tileColor: Colors.black,),
      ListTile(title: Text('Ekonomi'),tileColor: Colors.green[200],),
      ],
    );
*/