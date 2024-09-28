import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/config.dart';
import 'package:mobile_final/widgets/post_action_button.dart';

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
      'author': 'Plum',
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
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white), // Set close icon color to white
          onPressed: () => Navigator.pop(context), // Go back on press
        ),
        title: const Text(''), // Empty title to remove default title
        backgroundColor: const Color.fromRGBO(0, 105, 20, 1.0), // Set AppBar background color
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PostActionButton(onPressed: _createPost), // New Post button
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Set body background color to white
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLines: 3, // Allow multiline input
              decoration: const InputDecoration(
                border: InputBorder.none, // Remove border
                filled: true, // Fill color
                fillColor: Colors.white, // Set TextField background color to white
                hintText: 'ถ้าคุณมีปัญหาหรือเรื่องที่อยากจะพูดคุยกับเพื่อนๆ\nอย่าลังเลที่จะพูดออกมา :)',
                hintStyle: TextStyle(color: Colors.grey), // Hint style
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
