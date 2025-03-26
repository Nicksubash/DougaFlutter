import 'package:flutter/material.dart';
import '../HomeScreen/home_screen.dart';  
import '../HomeScreen/reel_screen.dart';
import '../HomeScreen/analytics_screen.dart';
import '../HomeScreen/setting_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Corrected the list initialization
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ReelScreen(),
    AnalyticsScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex), // Display selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: 'Reel'), 
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'), 
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        iconSize: 30.0,
      ),
    );
  }
}
