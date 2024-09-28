// post_action_button.dart
import 'package:flutter/material.dart';

class PostActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PostActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Post'),
    );
  }
}
