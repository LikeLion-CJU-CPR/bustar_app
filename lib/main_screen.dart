import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart'; // 경로 변경
import 'screens/point/dashboard_screen.dart';
import 'screens/my_info/my_info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 보여줄 페이지 리스트
  static const List<Widget> _pages = <Widget>[
    RouteSearchScreen(), // ✨ HomeScreen -> RouteSearchScreen으로 교체
    PointScreen(),
    MyInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          border: Border(top: BorderSide(color: Colors.grey[300]!)),
        ),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rate_rounded),
              label: '내 별사탕',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF6CB77E),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
