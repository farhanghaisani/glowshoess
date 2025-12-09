import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reactive variables
  final email = ''.obs;
  final password = ''.obs;

  // Setters
  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  // Login function
  Future<User?> loginWithEmailPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value.trim(),
      );

      final user = userCredential.user;

      // Save login status
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
      return null;
    }
  }

  // Logout function
  Future<void> logout() async {
    await _auth.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}
