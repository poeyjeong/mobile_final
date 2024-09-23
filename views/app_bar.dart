// app_bar.dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 102, 19, 211),
      title: const Text(
        "Hello Plum",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
