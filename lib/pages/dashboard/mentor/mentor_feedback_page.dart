import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/firestore_collectioon_constant.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import  'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/mentor/mentor_comment_repository.dart';
import 'package:guide_up/service/mentor/mentor_comment_service.dart';
import 'package:http/http.dart';

class MenteeFeedbackPage extends StatefulWidget {
  const MenteeFeedbackPage({Key? key}) : super(key: key);

  @override
  _MenteeFeedbackPageState createState() => _MenteeFeedbackPageState();
}

class _MenteeFeedbackPageState extends State<MenteeFeedbackPage> {
  double rating = 0;
  bool showName = false;
  final TextEditingController _commentController = TextEditingController();

  void submitFeedback() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String mentorId = FirestoreCollectionConstant.mentor;
    String userName = showName ? FirebaseAuth.instance.currentUser?.displayName ?? '' : '';

    // Yorumu al
    String comment = _commentController.text.trim();

    // MentorComment örneği oluştur

    MentorComment mentorComment = MentorComment()
      ..setId(FirebaseFirestore.instance.collection('mentorCommend').doc().id ) // Özel bir ID belirtin veya `.doc().id` kullanarak otomatik bir ID ataması yapabilirsiniz.
      ..setMenteeId(userId)
      ..setMentorId(mentorId)
      ..setRate(rating.toInt())
      ..setComment(comment)
      ..setAnonymous(!showName);


    await MentorCommentRepository().add(userId, mentorComment, mentorId, rating.toInt(), showName);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Geribildirim Gönderildi'),
          content: Text('Mentore geribildiriminiz başarıyla gönderildi.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pushNamed(context, RouterConstants.mentorFeedbackPage);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mentor Geribildirimi'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Değerlendirme Yapın',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Yıldız Derecelendirmesi: $rating',
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 16),
              Text(
                'Görüş ve Düşüncelerim',
    style: GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 20,
      color: ColorConstants.background,
              ),
    ),
              ),
              TextFormField(
                controller: _commentController,
                onChanged: (value) {
                  // Yorumu işlemek için gereken işlemleri gerçekleştirin
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mentora hakkında düşüncelerinizi yazın...',
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(25.0),
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
                        Text('İsminiz Gözüksün'),
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
                    submitFeedback();
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
