import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/dto/mentor/comment/mentor_comment_card_view.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/mentor/card_pages/mentor_comments_card.dart';
import 'package:guide_up/repository/mentee/mentee_repository.dart';
import 'package:guide_up/service/mentor/mentor_comment_service.dart';
import 'package:guide_up/ui/material/custom_material.dart';

class MentorCommentsPage extends StatefulWidget {
  const MentorCommentsPage({Key? key}) : super(key: key);

  @override
  State<MentorCommentsPage> createState() => _MentorCommentsPageState();
}

class _MentorCommentsPageState extends State<MentorCommentsPage> {
  late Mentor _mentor;
  Mentee? _myMentee;
  String? _userId;
  bool _isValueGet = false;

  @override
  Widget build(BuildContext context) {
    _mentor = ModalRoute.of(context)!.settings.arguments as Mentor;
    getValue();
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
                    future: MentorCommentService()
                        .getListByMentorId(_mentor.getId()!),
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
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final mentorCommentCardViews =
                                snapshot.data![index];
                            return MentorCommentsCard(
                                mentorCommentCardView: mentorCommentCardViews);
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
              Visibility(
                visible: _myMentee != null,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouterConstants.mentorFeedbackPage,
                        arguments: _myMentee);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getValue() async {
    if (!_isValueGet) {
      SecureStorageHelper().getUserId().then((value) async {
        if (value != null && value.isNotEmpty) {
          _userId = value;
          _myMentee = await MenteeRepository()
              .getMenteeByUserIdAndMentorId(_userId!, _mentor.getId()!);
        }
      });
      _isValueGet = true;
    }
  }
}
