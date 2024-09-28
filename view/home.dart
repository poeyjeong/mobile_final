// home_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/view/app_bar.dart';
import 'package:mobile_final/widgets/post_list.dart';
import 'package:mobile_final/models/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> _posts = [];
  bool _isLoading = true;

  Future<void> _fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://${Configure.server}/posts'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<Post> posts = postsFromJson(response.body);
        setState(() {
          _posts = posts;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Failed to load posts');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _handlePostDeleted() {
    _fetchPosts(); // Refresh post หลังกดลบ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Posts")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PostList(posts: _posts, isHistoryPage: false, onPostDeleted: _handlePostDeleted), // Pass the callback
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
