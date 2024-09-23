import 'package:flutter/material.dart';
import 'package:group_assign/models/post_model.dart';

class PostStats extends StatelessWidget {
  final Post post;

  const PostStats({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, size: 16),
        Text(' ${post.likes} | '),
        const Icon(Icons.thumb_down, size: 16),
        Text(' ${post.dislikes} | '),
        const Icon(Icons.comment, size: 16),
        Text(' ${post.comments.length}'),
      ],
    );
  }
}
