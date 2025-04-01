import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Pure business logic, no UI awareness
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up with Email & Password
  Future<String> signUp(String email, String password,String name, BuildContext context) async {
  try {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
        });

        print("User successfully stored in Firestore: ${user.uid}");

        // Show UI alert when successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User ${user.email} stored successfully!")),
        );

        return "Success";
      } catch (e) {
        print("Firestore Error: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Firestore Error: $e")),
        );

        return "Firestore Error: $e";
      }
    }
    return "User is null";
  } catch (e) {
    print("Sign Up Error: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sign Up Error: $e")),
    );

    return "Sign Up Error: $e";
  }
}

  // Sign Out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Placeholder for linking social media (to be implemented)
  Future<void> linkSocialMedia(String platform) async {
    print("Linking to $platform (To be implemented)");
  }

  Future<String> signIn(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Sucess";
    } on FirebaseAuthException catch(e){
          print("FirebaseAuthException: Code = ${e.code}, Message = ${e.message}"); // Debugging
      if(e.code=="user-not-found"){
        return "No user found with this email";
      }else if (e.code =="wrong-password"){
        return "Incorrect password";
      }else if (e.code =="invalid-email"){
        return "Invalid email format";
      }else if (e.code =="user-disabled"){
        return "This account has been disabled";
      }else{
        return "Login error: ${e.message}";
      }
    }catch(e){
      return "An unexpected error occurred";
    }
  }
}
