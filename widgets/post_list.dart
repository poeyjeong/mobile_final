import 'package:flutter/material.dart';
import 'package:group_assign/models/post_model.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({super.key, required this.posts, required bool showOnlyPlumPosts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Likes: ${post.likes}'),
              Text('Dislikes: ${post.dislikes}'),
              Text('Comments: ${post.comments.length}'),
            ],
          ),
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
