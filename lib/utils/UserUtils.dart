import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUtils {
  // Fetch user profile information (username, email, etc.)
  static Future<Map<String, dynamic>> getUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch the user data from Firestore using the user's UID
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        } else {
          throw "User data not found";
        }
      }
      throw "No user is signed in";
    } catch (e) {
      throw "Error fetching user data: $e";
    }
  }
}
