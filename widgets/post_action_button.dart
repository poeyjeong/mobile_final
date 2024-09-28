import 'package:flutter/material.dart';

class PostActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PostActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(218, 137, 146, 1.0), // Change button color
        foregroundColor: Colors.white, // Change text color to white
      ),
      child: const Text('Post'),
    );
  }
}
