import 'package:firebase_auth/firebase_auth.dart';
import 'package:towner_final_round/data/firestore.dart';
import 'package:towner_final_round/repository/authentication_datasource.dart';

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // No error occurred, return null
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Login failed. Error: ${e.message}';
      }
    } catch (e) {
      return 'Login failed. Error: $e';
    }
  }

  @override
  Future<String?> register(
    String email,
    String password,
    String passwordConfirm,
  ) async {
    if (passwordConfirm == password) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
            .then((value) {
          FirestoreDatasource().createUser(email);
        });
        return null; // No error occurred, return null
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        } else {
          return 'Registration failed. Error: ${e.message}';
        }
      } catch (e) {
        return 'Registration failed. Error: $e';
      }
    } else {
      return 'Passwords do not match.';
    }
  }
}
