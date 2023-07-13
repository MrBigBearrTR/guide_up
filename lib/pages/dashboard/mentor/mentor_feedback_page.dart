import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guide_up/core/constant/router_constants.dart';

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
    String userName = showName ? FirebaseAuth.instance.currentUser?.displayName ?? '' : '';

    // Yorumu al
    String comment = _commentController.text.trim();

    // Firebase Firestore veritabanına yorumu kaydet
    await FirebaseFirestore.instance
        .collection('feedbacks')
        .add({
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
    });

    // Geribildirimin başarıyla gönderildiğine dair kullanıcıya bildirim göster
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
                'Yorum:',
                style: TextStyle(fontSize: 18),
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
              SizedBox(height: 50),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  submitFeedback();
                },
                child: Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
