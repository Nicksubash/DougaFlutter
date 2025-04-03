import 'package:douga2/Screens/main_navigation/main_navigation.dart';
import 'package:flutter/material.dart';

// lib/routes.dart
class AppRoutes {
  static const String home = '/';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      default:
        return _errorRoute();
    }
  }
  
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('Route not found')),
    )
    );
  }
}