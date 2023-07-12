import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/dto/post/post_card_view.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/pages/guide/card/gude_card.dart';
import 'package:guide_up/service/post/post_service.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../core/constant/color_constants.dart';
import '../../core/utils/secure_storage_helper.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  State<GuideHomePage> createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {
  bool _isLogIn = false;
  String _userId = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getUserDetail();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset ==
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Guide",
          style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                  color: ColorConstants.theme2Dark,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Guidleri şu an listeyemiyoruz.'),
              );
            } else {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final postCardView = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the detailed view when the post is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostDetailPage(postCardView: postCardView),
                          ),
                        );
                      },
                      child: GuideCard(
                        postCardView: postCardView,
                        userId: _userId,
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                  controller: _scrollController,
                );
              } else {
                return const Center(
                  child: Text('Hiç Guide Bulunamadı :('),
                );
              }
            }
          },
          future: PostService().getList(_userId, 0),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isLogIn,
        child: FloatingActionButton(
          backgroundColor: ColorConstants.theme1DarkBlue,
          // Buton kutusu arka plan rengi
          tooltip: "Guide Ekle",
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.guideAdd);
          },
          child: const Icon(
            Icons.add,
            color: ColorConstants.itemWhite,
          ),
        ),
      ),
    );
  }

  void getUserDetail() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      _userId = detail.getUserId()!;
      _isLogIn = true;
      setState(() {});
    }
  }
}

class PostDetailPage extends StatelessWidget {
  final PostCardView postCardView;

  const PostDetailPage({required this.postCardView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue, // Background color for the title section
                child: Text(
                  ('${postCardView.topic}'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color for the title
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.orange,
                // Background color for the content section
                child: Text(
                  (' ${postCardView.content}'),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Text color for the content
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (postCardView.photo != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  postCardView.photo!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
