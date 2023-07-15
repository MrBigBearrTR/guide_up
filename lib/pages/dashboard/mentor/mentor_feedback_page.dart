import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/repository/mentor/mentor_comment_repository.dart';

import '../../../core/models/mentor/mentee_model.dart';

class MenteeFeedbackPage extends StatefulWidget {
  const MenteeFeedbackPage({Key? key}) : super(key: key);

  @override
  State<MenteeFeedbackPage> createState() => _MenteeFeedbackPageState();
}

class _MenteeFeedbackPageState extends State<MenteeFeedbackPage> {
  double rating = 0;
  bool showName = false;
  final TextEditingController _commentController = TextEditingController();

  void submitFeedback(BuildContext context) async {

    // MentorComment örneği oluştur
    MentorComment mentorComment = MentorComment();
    mentorComment.setMenteeId(_mentee.getId()!);
    mentorComment.setMentorId(_mentee.getMentorId()!);
    mentorComment.setRate(rating.round());
    mentorComment.setComment(_commentController.text.trim());
    mentorComment.setAnonymous(showName);

    MentorCommentRepository()
        .add(_mentee.getUserId()!, mentorComment)
        .then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Geribildirim Gönderildi'),
            content:
                const Text('Mentore geribildiriminiz başarıyla gönderildi.'),
            actions: [
              TextButton(
                child: const Text('Tamam'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    });
  }

  late Mentee _mentee;

  @override
  Widget build(BuildContext context) {
    _mentee = ModalRoute.of(context)!.settings.arguments as Mentee;
    return Container(
      alignment: Alignment.center,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mentor Geribildirimi'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Değerlendirme Yapın',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Yıldız Derecelendirmesi: $rating',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'Görüş ve Düşüncelerim',
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: ColorConstants.theme2DarkBlue,
                  ),
                ),
              ),
              TextFormField(
                controller: _commentController,
                onChanged: (value) {
                  // Yorumu işlemek için gereken işlemleri gerçekleştirin
                },
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mentora hakkında düşüncelerinizi yazın...',
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: showName,
                          onChanged: (value) {
                            setState(() {
                              showName = value ?? false;
                            });
                          },
                        ),
                        const Text('İsmim Görünmesin'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: ElevatedButton(
                  onPressed: () {
                    submitFeedback(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.deepOrange,
                      elevation: 18,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.deepOrange, Colors.orange]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: 400,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text(
                        'Gönder ',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
