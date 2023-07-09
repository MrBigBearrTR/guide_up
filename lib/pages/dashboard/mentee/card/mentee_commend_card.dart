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
      title: Text(_mentorCommend.getCommend()!),
    );
  }
}
