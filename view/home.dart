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
    final response = await http.get(Uri.parse('http://${Configure.server}/posts'));

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
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PostList(posts: _posts),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
