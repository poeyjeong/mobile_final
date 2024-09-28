// app_bar.dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 102, 19, 211),
      title: const Text(
        "Hello Plum :)",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue, // สีของปุ่มที่ถูกเลือก
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/history');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}
