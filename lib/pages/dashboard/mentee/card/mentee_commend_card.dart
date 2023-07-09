import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';

import '../../../../core/models/mentor/mentee_model.dart';

class MenteeCommendCard extends StatefulWidget {
  final Mentee mentee;

  const MenteeCommendCard({Key? key, required this.mentee}) : super(key: key);

  @override
  State<MenteeCommendCard> createState() => _MenteeCommendCardState();
}

class _MenteeCommendCardState extends State<MenteeCommendCard> {
  _MentorCommendCardState(Mentor mentor) {
    _mentor = mentor;
  }

  late Mentor _mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
      width: 330,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.itemWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 50),
              ListView.builder(
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
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/img/unknown_user.png'),
              ),
              const SizedBox(width: 6),
              Container(
                width: 220,
                child: const Expanded(
                  child: Text(
                    ' Yazılım alanındaki deneyimleriniz ile çok daha iyi yerler geleceğime inanıyorum.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
