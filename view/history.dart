// history.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/view/app_bar.dart';
import 'package:mobile_final/widgets/post_list.dart';
import 'package:mobile_final/models/config.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required List<Post> posts});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('http://${Configure.server}/posts'));

    if (response.statusCode == 200) {
      final List<Post> posts = postsFromJson(response.body);
      setState(() {
        _posts = posts.where((post) => post.author == 'plum').toList();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PostList(posts: _posts, showOnlyPlumPosts: true),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}
