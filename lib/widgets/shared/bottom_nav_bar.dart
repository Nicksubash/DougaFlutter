import 'package:douga2/providers/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppBottomNavBar  extends StatelessWidget{
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);

    return BottomNavigationBar(
      currentIndex: tabProvider.currentTab,
      onTap: (index){
        tabProvider.setTab(index);
        _navigateTo(context, index);
      },

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon:Icon(Icons.upload), label: "upload"),
        BottomNavigationBarItem(icon:Icon(Icons.person), label: "profile"),
      ],
    );
  }

  void _navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/upload');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }
  
}