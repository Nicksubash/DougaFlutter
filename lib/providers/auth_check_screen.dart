import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douga2/providers/auth_provider.dart';
import '../AuthScreen/firebaseAuth/login_screen.dart';
import '../widgets/main_navigation.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : authProvider.user != null
            ? const MainNavigation()
            : const LoginScreen();
  }
}