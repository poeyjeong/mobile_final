// main.dart
import 'package:flutter/material.dart';
import 'package:mobile_final/models/post_model.dart';
import 'package:mobile_final/view/history.dart';
import 'package:mobile_final/view/home.dart';
import 'package:mobile_final/widgets/post_create.dart';
import 'package:mobile_final/widgets/post_detail.dart';
import 'package:mobile_final/widgets/post_edit.dart';

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
      routes: {
        '/': (context) => const HomePage(),
        '/postcreate': (context) => const PostCreatePage(),
        '/postdetails': (context) => _buildPostDetailsPage(context),
        '/postedit': (context) => _buildPostEditPage(context),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          return MaterialPageRoute(builder: (context) => const HistoryPage());
        }
        return null;
      },
    );
  }

  Widget _buildPostDetailsPage(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final post = args['post'] as Post;
    return Scaffold(
      body: PostDetailsPage(post: post),
    );
  }

  Widget _buildPostEditPage(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final post = args['post'] as Post;
    return PostEditPage(post: post);
  }
}
