import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> deleteUser() async {
    try {
      User? user = await _auth.currentUser;
      if (user != null) {
        await user.delete();
      } else {
        print("No user found to delete");
      }
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}