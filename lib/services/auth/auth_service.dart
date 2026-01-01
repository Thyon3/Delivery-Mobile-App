import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get the instance of the Authservies
  final FirebaseAuth _authService = FirebaseAuth.instance;

  //get the current user

  User? getCurrenUser() {
    return _authService.currentUser;
  }

  // sign in

  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    //try to sign in the user
    try {
      UserCredential userCredential = await _authService
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw Exception(e.code);
      } else {
        throw Exception('An unknown error occurred');
      }
    }
  }

  // sing up

  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    // try to sign up the user
    try {
      UserCredential userCredential = await _authService
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw Exception(e.code);
      } else {
        throw Exception('An unknown error occurred');
      }
    }
  }

  // sign out

  Future<void> signOut() async {
    return await _authService.signOut();
  }
}
