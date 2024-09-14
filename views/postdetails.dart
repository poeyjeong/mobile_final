// แทนหน้า ArticalModel
// Class postdetails.dart มีหน้าที่จัดการแสดงผล UI

import 'package:flutter/material.dart';

class UIpostdetails extends StatelessWidget {
  final Map<String, dynamic> post;

  const UIpostdetails({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle Post action
            },
            child: const Text(
              "Post",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    "ถ้าคุณมีปัญหาหรือเรื่องที่อยากจะพูดคุยกับเพื่อนๆ อย่าลังเลที่จะพูดออกมา :)",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Author: ${post['author']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text("Likes: ${post['likes']}",
                    style: const TextStyle(fontSize: 16, color: Colors.green)),
                const SizedBox(width: 20),
                Text("Dislikes: ${post['dislikes']}",
                    style: const TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Comments:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: post['comments'].length,
                itemBuilder: (context, index) {
                  final comment = post['comments'][index];
                  return ListTile(
                    title: Text(comment['author'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(comment['content']),
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
