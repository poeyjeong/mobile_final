import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_final/models/config.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/comment.dart';
import 'package:mobile_final/widgets/post_delete.dart';
import 'package:mobile_final/widgets/post_stat.dart';
import 'package:http/http.dart' as http;

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  Future<void> _addComment(Comment comment) async {
    var url = Uri.http(Configure.server, "/posts/${comment.postId}");
    try {
      print("Adding comment to: $url");
      // Fetch the current post data
      var postResp = await http.get(url);

      if (postResp.statusCode == 200) {
        // Parse the existing post
        var post = Post.fromJson(jsonDecode(postResp.body));

        // Create a new comment object with author "Plum"
        var newComment = Comment(
          author: 'Plum',
          content: comment.content,
          postId: widget.post.id,
          String: null,
        );

        print("New comment being added: $newComment");
        post.comments.add(newComment);

        // Send updated post back to the server
        var resp = await http.put(
          url,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: utf8.encode(jsonEncode(post.toJson())),
        );

        if (resp.statusCode == 200) {
          print("Comment added successfully");
          setState(() {
            widget.post.comments = post.comments;
          });
        } else {
          print("Failed to update post with new comment: ${resp.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to update post")),
          );
        }
      } else {
        print("Post not found");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("โพสต์ไม่พบ")),
        );
      }
    } catch (e) {
      print("Error adding comment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.post.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            PostStats(post: widget.post),
            const Divider(),
            CommentList(comments: widget.post.comments),
            CommentInputWidget(
              post: widget.post,
              onCommentAdded: (comment) {
                _addComment(comment);
              },
            ),
            PostDelete(post: widget.post),
          ],
        ),
      ),
    );
  }
}
