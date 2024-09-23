import 'package:flutter/material.dart';
import 'package:group_assign/models/post_model.dart';
import 'package:group_assign/widgets/post_list.dart';

class HistoryPage extends StatelessWidget {
  final List<Post> posts; // Your posts from data.json

  const HistoryPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Posts"),
      ),
      body: PostList(posts: posts, showOnlyPlumPosts: true), // Show only Plum's posts
    );
  }
}
