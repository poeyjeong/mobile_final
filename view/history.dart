import 'package:flutter/material.dart';
import 'package:group_assign/models/post_model.dart';
import 'package:group_assign/widgets/post_list.dart';

class HistoryPage extends StatelessWidget {
  final List<Post> posts;

  const HistoryPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final plumPosts = posts.where((post) => post.author == 'Plum').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Posts"),
      ),
      body: PostList(posts: plumPosts, showOnlyPlumPosts: false),
    );
  }
}
