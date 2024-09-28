import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/post_edit.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PostEditPage(post: Post.fromJson({}));
  }
}
