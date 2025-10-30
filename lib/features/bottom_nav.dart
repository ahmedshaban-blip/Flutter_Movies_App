import 'package:flutter/material.dart';
import 'package:movie_app/features/favorite/presentation/pages/favorite_page.dart';
import 'package:movie_app/features/home/presentation/pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> pages = [HomePage(), FavoritePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1a1a2e),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIconTheme: const IconThemeData(color: Colors.indigo),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.cyanAccent),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favorite ',
          ),
        ],
      ),
    );
  }
}
