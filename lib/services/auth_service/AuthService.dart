import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    print("Started Creating New User ");
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user's ID
      final String userId = userCredential.user!.uid;

      // Perform any additional actions, e.g., store user data, navigate to a different screen
      print('User created successfully: $userId');
      return userId;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another user.');
      } else {
        print("Error");
        print(e.code);
      }
    } catch (e) {
      print(e); // Handle other exceptions
    }
    return null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("eeeeeee $e codeeee ${e.code}");
      if (e.code == "network-request-failed") {
      } else if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {}
    }
  }

  Future<bool> resetPassword(String email) async {
    print("Email is $email");

    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      print("Password reset email sent successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException errors
      print("FirebaseAuthException - Code: ${e.code}, Message: ${e.message}");
      if (e.code == 'user-not-found') {
        // Handle user not found error
        print('User not found. Please check the email address.');
      } else {
        // Handle other errors as needed
        print('Error sending password reset email: $e');
      }

      return false;
    } catch (e) {
      // Handle other exceptions
      print('Error sending password reset email: $e');
      return false;
    }
  }
}
