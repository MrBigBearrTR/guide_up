import 'package:flutter/material.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';

class MenteeCommendCard extends StatefulWidget {
  final MentorCommend mentorCommend;

  const MenteeCommendCard({Key? key, required this.mentorCommend})
      : super(key: key);

  @override
  State<MenteeCommendCard> createState() =>
      _MenteeCommendCardState(mentorCommend);
}

class _MenteeCommendCardState extends State<MenteeCommendCard> {
  final MentorCommend _mentorCommend;

  _MenteeCommendCardState(this._mentorCommend);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _mentorCommend.getRate()! * 25,
            height: 10,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 25,
                );
              },
              itemCount: _mentorCommend.getRate(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
      subtitle: Text(_mentorCommend.getCommend()!),
    );
  }
}
