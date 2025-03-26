import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/firebaseService/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<User?> signUp(String email, String password) async {
    _user = await _authService.signUp(email, password);
    notifyListeners();
  }

  Future<User?> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
