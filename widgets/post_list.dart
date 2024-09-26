import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/post_stat.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final bool showOnlyPlumPosts;

  const PostList({super.key, required this.posts, required this.showOnlyPlumPosts});

  @override
  Widget build(BuildContext context) {
    final filteredPosts = showOnlyPlumPosts
        ? posts.where((post) => post.author == 'Plum').toList()
        : posts;

    return ListView.separated(
      itemCount: filteredPosts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: PostStats(post: post),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/postdetails',
              arguments: {'post': post},
            );
          },
        );
      },
    );
  }
}
