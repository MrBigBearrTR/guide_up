import 'package:flutter/material.dart';
import 'package:guide_up/core/models/post/post_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/post/post_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final PostRepository _postRepository = PostRepository();
  final UserDetailRepository _userDetailRepository = UserDetailRepository();

  List<Post> posts = [];
  User? currentUser;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchPosts();
  }

  Future<void> fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
  }

  Future<void> fetchPosts() async {
    if (currentUser != null) {
      List<Post> fetchedPosts =
      await _postRepository.getUserPostListByUserId(currentUser!.uid);
      setState(() {
        posts = fetchedPosts;
      });
    }
  }

  Future<void> addPost(String topic, String content) async {
    if (currentUser != null) {
      Post newPost = Post();
      newPost.setUserId(currentUser!.uid);
      newPost.setTopic(topic);
      newPost.setContent(content);

      await _postRepository.add(newPost);
      fetchPosts();
    }
  }

  Future<void> editPost(Post post) async {
    if (currentUser != null && post.getUserId() == currentUser!.uid) {
      // Kullanıcı kendi postunu düzenleyebilir
      // Düzenleme işlemi burada gerçekleştirilebilir
      // Örneğin, düzenleme sayfasına yönlendirilebilir
      print('Post düzenleme işlemi: ${post.getTopic()}');
    }
  }

  Future<void> deletePost(Post post) async {
    if (currentUser != null && post.getUserId() == currentUser!.uid) {
      // Kullanıcı kendi postunu silebilir
      await _postRepository.deletePost(post.getId()!);
      fetchPosts();
      print('Post silme işlemi: ${post.getTopic()}');
    }
  }

  Future<UserDetail?> getUserDetail(String userId) async {
    UserDetail? userDetail =
    await _userDetailRepository.getUserByUserId(userId);
    return userDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Page'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          Post post = posts[index];
          return FutureBuilder<UserDetail?>(
            future: getUserDetail(post.getUserId()!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(
                  title: Text('Loading...'),
                );
              }
              if (snapshot.hasData) {
                UserDetail? userDetail = snapshot.data;
                return ListTile(
                  title: Text(post.getTopic() ?? ''),
                  subtitle: Text(post.getContent() ?? ''),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userDetail?.profileImage ?? ''),
                  ),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        editPost(post);
                      } else if (value == 'delete') {
                        deletePost(post);
                      }
                    },
                  ),
                );
              }
              return ListTile(
                title: Text('Error'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentUser != null) {
            showDialog(
              context: context,
              builder: (context) => AddPostPage(
                onAddPost: addPost,
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Login Required'),
                content: Text('You need to login to add a post.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      // Perform login operation here
                      fetchUser();
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  final Function(String, String) onAddPost;

  AddPostPage({required this.onAddPost});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController topicController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addPost() {
    String topic = topicController.text.trim();
    String content = contentController.text.trim();

    if (topic.isNotEmpty && content.isNotEmpty) {
      widget.onAddPost(topic, content);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter topic and content.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: topicController,
            decoration: InputDecoration(
              labelText: 'Topic',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: contentController,
            decoration: InputDecoration(
              labelText: 'Content',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: addPost,
          child: Text('Add'),
        ),
      ],
    );
  }
}
