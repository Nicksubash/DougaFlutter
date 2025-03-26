import 'package:flutter/material.dart';
import './HomeScreen/home_screen.dart';
import './HomeScreen/welcome_screen.dart';
import 'package:douga2/AuthScreen/login_screen.dart';
import 'package:douga2/AuthScreen/signup_screen.dart';
import './widgets/main_navigation.dart';

// Main Application entry point
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Douga',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => MainNavigation(),
      },
    );
  }
}