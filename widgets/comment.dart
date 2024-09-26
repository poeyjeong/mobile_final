// comment.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';

class CommentInputWidget extends StatefulWidget {
  final Function(Comment) onCommentAdded;

  const CommentInputWidget({super.key, required this.onCommentAdded});

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
            final comment = Comment(author: 'Plum', content: _commentController.text);
            widget.onCommentAdded(comment);
            _commentController.clear();
          },
        ),
      ],
    );
  }
}
