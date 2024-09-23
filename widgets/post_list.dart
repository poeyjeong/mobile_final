import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_assign/models/post_model.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final bool showOnlyPlumPosts;

  const PostList({
    super.key,
    required this.posts,
    required this.showOnlyPlumPosts,
  });

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
          subtitle: Row(
            children: [
              const Icon(Icons.thumb_up, size: 16),
              Text(' ${post.likes} | '),
              const Icon(Icons.thumb_down, size: 16),
              Text(' ${post.dislikes} | '),
              const Icon(Icons.comment, size: 16),
              Text(' ${post.comments.length}'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/post_detail',
              arguments: post,
            );
          },
        );
      },
    );
  }
}
