// post_detail.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/comment.dart';
import 'package:mobile_final/widgets/post_stat.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  Future<void> _addComment(String content) async {
    final comment = Comment(author: 'Plum', content: content);
    widget.post.comments.add(comment);
    setState(() {});
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              PostStats(post: widget.post),
              // Display comments
              const Divider(),
              // Display comments
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.post.comments.length,
                  itemBuilder: (context, index) {
                    final comment = widget.post.comments[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              const Icon(Icons.account_circle, size: 16),
                              const SizedBox(
                                  width: 8), // เว้นช่องว่างระกว่างบรรทัด
                              Expanded(
                                child: Text(comment.content),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
              CommentInputWidget(
                onCommentAdded: (comment) {
                  _addComment(comment.content);
                },
              )
            ],
          )),
    );
  }
}
