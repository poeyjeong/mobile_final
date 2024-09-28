import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_final/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/widgets/post_action_button.dart';

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
    final response = await http.get(url); // Fetch existing post data from server

    if (response.statusCode == 200) {
      final Map<String, dynamic> existingPost = jsonDecode(response.body);

      // Create a new Map with updated title
      final updatedPost = {
        'id': existingPost['id'],
        'title': _titleController.text,
        'author': existingPost['author'],
        'comments': existingPost['comments'],
        'likes': existingPost['likes'],
        'dislikes': existingPost['dislikes'],
      };

      final updateResponse = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(updatedPost),
      );

      if (updateResponse.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/history');
      } else {
        print('Failed to update post');
      }
    } else {
      print('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // Change back button to cross
          onPressed: () => Navigator.pop(context), // Go back on press
        ),
        title: const Text(''), // Empty title to remove default title
        backgroundColor: Colors.purple[200], // Set AppBar background color
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PostActionButton(onPressed: _updatePost), // Update Post button
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
                fillColor: Colors.white, // Set TextField background color
                hintText: 'แก้ไขชื่อโพสต์ของคุณที่นี่',
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
