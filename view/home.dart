import 'package:flutter/material.dart';
import 'package:group_assign/view/history.dart';
import 'package:http/http.dart' as http;
import 'package:group_assign/models/post_model.dart';
import 'package:group_assign/widgets/post_list.dart';
import 'package:group_assign/models/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 19, 211),
        title: const Text(
          "Hello Plum",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PostList(
              posts: _posts, showOnlyPlumPosts: false), // Update this line
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/post');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context) => HistoryPage(posts: _posts)
                  )
            ); // Navigate to history page
          }
        },
      ),
    );
  }
}
