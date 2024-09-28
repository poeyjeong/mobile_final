// comment.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;

  const CommentList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
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
    );
  }
}

class CommentInputWidget extends StatefulWidget {
  final Post post;
  final Function(Comment) onCommentAdded;

  const CommentInputWidget(
      {super.key, required this.post, required this.onCommentAdded});

  @override
  _CommentInputWidgetState createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'แสดงความคิดเห็น',
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            final comment = Comment(
                postId: widget.post.id,
                author: "Plum",
                content: _commentController.text, String: null);
            widget.onCommentAdded(comment);
            _commentController.clear();
          },
        )
      ],
    );
  }
}
