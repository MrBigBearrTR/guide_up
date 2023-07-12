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
class PostDetailPage extends StatefulWidget {
  final PostCardView postCardView;

  const PostDetailPage({required this.postCardView});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ('${widget.postCardView.topic}'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              ('${widget.postCardView.content}'),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            if (widget.postCardView.photo != null)
              Image.network(
                widget.postCardView.photo!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              'Comments:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index]),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToCommentPage(context);
              },
              child: Text('Add Comment'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToCommentPage(BuildContext context) async {
    final comment = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => CommentPage()),
    );

    if (comment != null && comment.isNotEmpty) {
      setState(() {
        comments.add(comment);
      });
    }
  }
}

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Enter your comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _postComment(context);
              },
              child: Text('Post Comment'),
            ),
          ],
        ),
      ),
    );
  }

  void _postComment(BuildContext context) {
    String comment = commentController.text;
    if (comment.isNotEmpty) {
      Navigator.pop(context, comment);
    }
  }
}
