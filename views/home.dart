import 'package:flutter/material.dart';
import 'dart:convert'; // สำหรับ decode JSON
import '../models/posts.dart';
// import '';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts =
      []; //เก็บรายการของ postdetails ที่ใช้ในการเก็บโพสต์ที่ดึงมาจาก JSON
  // String? authorName;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(posts: []),
    HistoryPage(),
  ];

  @override
  void initState() {
    super.initState();
    loadPosts(); // ดึง Post ตอนเริ่ม
  }

  void loadPosts() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    final jsonResult = json.decode(data); // Decode JSON
    setState(() {
      posts = Postdetails.fromJson(jsonResult).posts ?? []; // Use Postdetails
      _pages[0] =
          HomePage(posts: posts); // Update HomePage with the fetched posts
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: <Widget>[
            Text("Hello"),
            Text(" Plum", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
      body: posts.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching posts
          : _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Dummy HomePage widget
class HomePage extends StatelessWidget {
  final List<Post> posts;

  const HomePage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display posts in 2 columns
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return BlogTile(
          title: posts[index].title ?? '',
          likes: posts[index].likes ?? 0,
          dislikes: posts[index].dislikes ?? 0,
          comments: posts[index].comments?.length ?? 0,
        );
      },
    );
  }
}

// Dummy HistoryPage widget
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('History Page Content'));
  }
}

class BlogTile extends StatelessWidget {
  final String title;
  final int likes, dislikes, comments;

  const BlogTile({
    super.key,
    required this.title,
    required this.likes,
    required this.dislikes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Likes: $likes"),
                Text("Dislikes: $dislikes"),
                Text("Comments: $comments"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
