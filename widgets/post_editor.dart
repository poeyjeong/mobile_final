import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_final/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';

class PostEditorPage extends StatefulWidget {
  const PostEditorPage({super.key, required post});

  @override
  _PostEditorPageState createState() => _PostEditorPageState();
}

class _PostEditorPageState extends State<PostEditorPage> {
  final List<Post> _posts = []; // Assume you have some posts to edit
  // Add your editing logic here

  Future<void> _savePosts() async {
    String jsonData = postsToJson(_posts);

    final response = await http.post(
      Uri.parse('http://${Configure.server}/update_posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utf8.encode(jsonData),
    );

    if (response.statusCode == 200) {
      // Handle successful update
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Editor'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _savePosts,
          child: const Text('Save Posts'),
        ),
      ),
    );
  }
}
