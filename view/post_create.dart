// post_create.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/config.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _titleController = TextEditingController();

  Future<void> _createPost() async {
    final url = Uri.parse('http://${Configure.server}/posts');
    
    final newPost = {
      'title': _titleController.text,
      'author': 'Plum', // Set author or get it dynamically
      'comments': [],
      'likes': 0,
      'dislikes': 0,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(newPost),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/history');
    } else {
      print('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สร้างโพสต์ใหม่'),
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
              onPressed: _createPost,
              child: const Text('สร้างโพสต์'),
            ),
          ],
        ),
      ),
    );
  }
}
