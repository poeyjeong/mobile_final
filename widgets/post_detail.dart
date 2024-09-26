import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/post_stat.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  post.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              PostStats(post: post),
              // Display comments
              const Divider(),
              // Display comments
              ListView.builder(
                shrinkWrap: true,
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.person, size: 16),
                            const SizedBox(
                                width: 8), // เว้นช่องว่างระกว่างบรรทัด
                            Expanded(child: Text(comment.content),)
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              )
            ],
          )),
    );
  }
}
