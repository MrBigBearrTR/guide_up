import 'package:flutter/material.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';

class MenteeCommentCard extends StatefulWidget {
  final MentorComment mentorComment;

  const MenteeCommentCard({Key? key, required this.mentorComment})
      : super(key: key);

  @override
  State<MenteeCommentCard> createState() =>
      _MenteeCommentCardState(mentorComment);
}

class _MenteeCommentCardState extends State<MenteeCommentCard> {
  final MentorComment _mentorComment;

  _MenteeCommentCardState(this._mentorComment);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _mentorComment.getRate()! * 25,
            height: 10,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 25,
                );
              },
              itemCount: _mentorComment.getRate(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
      subtitle: Text(_mentorComment.getComment()!),
    );
  }
}
