import 'package:flutter/material.dart';
import './HomeScreen/home_screen.dart';
import './HomeScreen/welcome_screen.dart';
import 'package:douga2/AuthScreen/login_screen.dart';
import 'package:douga2/AuthScreen/signup_screen.dart';
import './widgets/main_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        '/': (context) => AuthCheckScreen(),
        '/signup': (context) => SignupScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => MainNavigation(),
      },
    );
  }
}

class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in
    final user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // If user is logged in, navigate to the home screen
      return MainNavigation();
    } else {
      // If not logged in, show the login screen
      return LoginScreen();
    }
  }
}
