import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/dto/mentor/comment/mentor_comment_card_view.dart';
import 'package:guide_up/ui/material/custom_material.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/service/mentor/mentor_comment_service.dart';

class MentorComments extends StatelessWidget {
  final mentorCommentService = MentorCommentService();

  MentorComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yorumlar',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConstants.itemBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: CustomMaterial.backgroundBoxDecoration,
                  child: FutureBuilder<List<MentorCommentCardView>>(
                    future: mentorCommentService.getListByMentorId('your_mentor_id'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Yorumları şu an listeleyemiyoruz.'),
                        );
                      } else if (snapshot.hasData) {
                        final mentorCommentCardViews = snapshot.data!;
                        return ListView.builder(
                          itemCount: mentorCommentCardViews.length,
                          itemBuilder: (context, index) {
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Hiç yorum bulunamadı"),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouterConstants.mentorFeedbackPage);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
