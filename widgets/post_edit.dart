import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_final/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';

class PostEditPage extends StatefulWidget {
  final Post post;

  const PostEditPage({super.key, required this.post});

  @override
  _PostEditPageState createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
  }

  Future<void> _updatePost() async {
    final url = Uri.parse('http://${Configure.server}/posts/${widget.post.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({
        'title': _titleController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/history');
    } else {
      print('Failed to update post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขโพสต์'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อโพสต์',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePost,
              child: const Text('แก้ไขโพสต์'),
            ),
          ],
        ),
      ),
    );
  }
}
