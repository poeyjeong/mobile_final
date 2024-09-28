// post_delete.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/config.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostDelete extends StatelessWidget {
  final Post post;

  const PostDelete({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final url = Uri.http(Configure.server, "/posts/${post.id}");
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          Navigator.pushNamed(context, '/history');
        } else {
          print("Failed to delete post: ${response.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to delete post")),
          );
        }
      },
    );
  }
}
