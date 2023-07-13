import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/dto/post/post_card_view.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/pages/guide/card/guide_comment_card.dart';
import 'package:guide_up/service/post/comment/comment_service.dart';

import '../../core/constant/color_constants.dart';
import '../../core/utils/secure_storage_helper.dart';
import '../../ui/material/custom_material.dart';

class GuideDetailPage extends StatefulWidget {
  const GuideDetailPage({Key? key}) : super(key: key);

  @override
  State<GuideDetailPage> createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  late PostCardView _postCardView;
  UserDetail? _userDetail;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      _userDetail = detail;
      _userId = detail.getId()!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _postCardView = ModalRoute.of(context)!.settings.arguments as PostCardView;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ('${_postCardView.topic}'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ('${_postCardView.content}'),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              if (_postCardView.photo != null)
                Image.network(
                  _postCardView.photo!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              const Text(
                'Yorumlar:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder(
                future: CommentService().getList(_postCardView.id!, 0, _userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Yorumlara erişirken hata ile karşılaşıldı.',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.theme2Dark,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                      return Center(
                        child: Text(
                          'Hiç yorum yok',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.theme2Dark,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var commend = snapshot.data![index];
                          return GuideCommentCard(
                              commentCardView: commend, userId: _userId);
                        },
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: _userDetail != null,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouterConstants.guideCommentPage,
                            arguments: _postCardView)
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: const Text('Yorum Ekle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
