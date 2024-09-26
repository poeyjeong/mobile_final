// app_bar.dart
import 'package:flutter/material.dart';
import 'package:group_assign/view/history.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 102, 19, 211),
      title: const Text(
        "Hello Plum",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      ],
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryPage(posts: []), // Pass an empty list for now
              )
          ); // Navigate to history page
        }
      },
    );
  }
}
