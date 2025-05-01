import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Color.fromARGB(255, 69, 6, 241),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          backgroundColor: Color.fromARGB(255, 69, 6, 241),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Add Item",
          backgroundColor: Color.fromARGB(255, 69, 6, 241),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: "Edit Item",
          backgroundColor: Color.fromARGB(255, 69, 6, 241),
        ),
      ],
    );
  }
}
