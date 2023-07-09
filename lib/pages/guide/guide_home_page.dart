import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String topic;
  final String content;
  int likes;
  List<String> comments;

  Post({
    required this.id,
    required this.userId,
    required this.topic,
    required this.content,
    this.likes = 0,
    this.comments = const [],
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      userId: map['userId'],
      topic: map['topic'],
      content: map['content'],
      likes: map['likes'] ?? 0,
      comments: List<String>.from(map['comments'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'topic': topic,
      'content': content,
      'likes': likes,
      'comments': comments,
    };
  }
}

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchUser().then((_) {
      fetchPosts();
    });
  }

  Future<void> fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
  }

  Future<void> fetchPosts() async {
    if (currentUser != null) {
      QuerySnapshot<Map<String, dynamic>> postSnapshot =
      await _firestore.collection('posts').get();

      List<Post> fetchedPosts = postSnapshot.docs
          .map((doc) => Post.fromMap(doc.data()))
          .toList();

      setState(() {
        posts = fetchedPosts;
      });
    }
  }

  Future<void> addPost(String topic, String content) async {
    if (currentUser != null) {
      DocumentReference postRef = await _firestore.collection('posts').add({
        'userId': currentUser!.uid,
        'topic': topic,
        'content': content,
        'likes': 0,
        'comments': [],
      });

      setState(() {
        Post newPost = Post(
          id: postRef.id,
          userId: currentUser!.uid,
          topic: topic,
          content: content,
          likes: 0,
          comments: [],
        );
        posts.add(newPost);
      });
    }
  }

  Future<void> deletePost(String postId) async {
    if (currentUser != null) {
      await _firestore.collection('posts').doc(postId).delete();
      setState(() {
        posts.removeWhere((post) => post.id == postId);
      });
    }
  }

  Future<void> likePost(Post post) async {
    if (currentUser != null) {
      DocumentReference postRef = _firestore.collection('posts').doc(post.id);
      int updatedLikes = post.likes + 1;

      await postRef.update({'likes': updatedLikes});

      setState(() {
        post.likes = updatedLikes;
      });
    }
  }

  Future<void> addComment(Post post, String comment) async {
    if (currentUser != null) {
      DocumentReference postRef = _firestore.collection('posts').doc(post.id);
      List<String> updatedComments = List.from(post.comments);
      updatedComments.add(comment);

      await postRef.update({'comments': updatedComments});

      setState(() {
        post.comments = updatedComments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Page'),
      ),
      body: posts.isEmpty
          ? Center(
        child: Text('No posts available.'),
      )
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          Post post = posts[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.topic,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(post.content),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.blue,
                          onPressed: () => likePost(post),
                        ),
                        Text(
                          '${post.likes}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      color: Colors.blue,
                      onPressed: () => _showCommentsDialog(post),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                if (post.comments.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      ...post.comments.map(
                            (comment) => ListTile(
                          title: Text(comment),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
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

  void _showCommentsDialog(Post post) {
    showDialog(
      context: context,
      builder: (context) => AddCommentDialog(
        post: post,
        onAddComment: addComment,
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

class AddCommentDialog extends StatefulWidget {
  final Post post;
  final Function(Post, String) onAddComment;

  AddCommentDialog({required this.post, required this.onAddComment});

  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  TextEditingController commentController = TextEditingController();

  void addComment() {
    String comment = commentController.text.trim();

    if (comment.isNotEmpty) {
      widget.onAddComment(widget.post, comment);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a comment.'),
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
      title: Text('Add Comment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: commentController,
            decoration: InputDecoration(
              labelText: 'Comment',
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
          onPressed: addComment,
          child: Text('Add'),
        ),
      ],
    );
  }
}
