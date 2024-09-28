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
    final response = await http.get(url); // ดึงข้อมูลโพสต์เดิมจากเซิร์ฟเวอร์

    if (response.statusCode == 200) {
      // แปลงข้อมูลโพสต์ที่ดึงมา
      final Map<String, dynamic> existingPost = jsonDecode(response.body);

      // สร้าง Map ใหม่ที่อัปเดตเฉพาะ title
      final updatedPost = {
        'id': existingPost['id'],
        'title': _titleController.text, // อัปเดตเฉพาะ title ที่เหลือเป็นค่าเดิม
        'author': existingPost['author'],
        'comments': existingPost['comments'],
        'likes': existingPost['likes'],
        'dislikes': existingPost['dislikes'],
      };

      // ส่งข้อมูลที่แก้ไขกลับไปที่เซิร์ฟเวอร์
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
