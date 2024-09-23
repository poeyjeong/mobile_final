import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,),
            SizedBox(height: 10),
            Text('Likes: ${post.likes}, Dislikes: ${post.dislikes}'),
            SizedBox(height: 10),
            Text('Comments:'),
            Expanded(
              child: ListView.builder(
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return ListTile(
                    title: Text(comment.author),
                    subtitle: Text(comment.content),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
