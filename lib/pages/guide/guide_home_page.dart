import 'package:flutter/material.dart';
import 'package:guide_up/core/models/post/post_model.dart';
import 'package:guide_up/repository/post/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final PostRepository _postRepository = PostRepository();

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
          return ListTile(
            title: Text(post.getTopic() ?? ''),
            subtitle: Text(post.getContent() ?? ''),
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
