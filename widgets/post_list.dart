// post_list.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/post_stat.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final bool isHistoryPage; // เอาไว้บอกว่า อยู่ในหน้า History ไหม

  const PostList({
    super.key,
    required this.posts,
    required this.isHistoryPage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: PostStats(post: post),
          trailing: isHistoryPage
            ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // ฟังก์ชันแก้ไขเฉพาะใน HistoryPage
                  },
                )
              : null, // ถ้าไม่ใช่ HistoryPage จะไม่มีปุ่มแก้ไข
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
