// history.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/view/app_bar.dart';
import 'package:mobile_final/models/config.dart';
import 'package:mobile_final/widgets/post_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Post> _posts = [];
  bool _isLoading = true;

  Future<void> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('http://${Configure.server}/posts'));

    if (response.statusCode == 200) {
      final List<Post> posts = postsFromJson(response.body);
      final plumPosts = posts.where((post) => post.author == 'Plum').toList();
      setState(() {
        _posts = plumPosts;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // ดึงข้อมูลโพสต์เมื่อเพจเริ่มต้น
  }

  void _handlePostDeleted() {
    _fetchPosts(); // Refresh the posts after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PostList(
              posts: _posts,
              isHistoryPage: true,
              onPostDeleted: _handlePostDeleted), // Pass the callback
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}
