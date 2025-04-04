import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 
import 'Screens/welcome_screen.dart';
import 'package:douga2/AuthScreen/firebaseAuth/signup_screen.dart';
import 'navigation/main_navigation.dart';
import './providers/auth_provider.dart' as myAuth;
import './providers/auth_check_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBgOZBGDhzl-hwgGQYKjIccbeCTshiYzHY",
      authDomain: "flutter-web-connection-ccf9c.firebaseapp.com",
      projectId: "flutter-web-connection-ccf9c",
      storageBucket: "flutter-web-connection-ccf9c.appspot.com",
      messagingSenderId: "888892998490",
      appId: "1:888892998490:web:c6d3d8b55f20c60781a963",
      measurementId: "G-Z1HCDGMT02",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => myAuth.AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Douga',
        theme: ThemeData(
          primaryColor: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthCheckScreen(),
          '/signup': (context) => const SignupScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/home': (context) => const MainNavigation(),
        },
      ),
    );
  }
}