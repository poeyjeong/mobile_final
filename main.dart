import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/view/app_bar.dart';
import 'package:mobile_final/view/history.dart';
import 'package:mobile_final/view/home.dart';
import 'package:mobile_final/view/post.dart';
import 'package:mobile_final/widgets/post_detail.dart';

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
      initialRoute: '/',
      builder: (context, child) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), // Set the height of the app bar
            child: MyAppBar(), // ใช้ MyAppBar ในทุกหน้า
          ),
          body: child,
        );
      },
      routes: {
        '/': (context) => const HomePage(),
        '/post': (context) => const NewPostPage(),
        '/postdetails': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final post = args['post'] as Post;
          return Scaffold(
            body: PostDetailsPage(post: post),
          );
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          return MaterialPageRoute(
              builder: (context) => const HistoryPage(posts: []));
        }
        return null;
      },
    );
  }
}
