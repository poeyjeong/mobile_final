import 'package:flutter/material.dart';
import 'package:group_assign/models/post_model.dart';
import 'package:group_assign/view/history.dart';
import 'package:group_assign/view/home.dart';
import 'package:group_assign/view/post.dart';
import 'package:group_assign/widgets/post_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anonymous Posts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/post': (context) => const NewPostPage(),
        '/postdetails': (context) => PostDetailsPage(),
        // '/history': (context) => const HistoryPage(posts: _posts),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          final args = settings.arguments as List<Post>;
          return MaterialPageRoute(
            builder: (context) => HistoryPage(posts: args),
          );
        }
        return null; // Return null if the route is not found
      },
    );
  }
}
