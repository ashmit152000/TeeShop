import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String _token = '';
  String _userId = '';
  bool isVerified = false;

  bool getToken() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (_userId != '') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyMail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
    if (user != null && user.emailVerified) {
      isVerified = true;
    }
    notifyListeners();
  }

  bool isVerifiedMail() {
    if (isVerified == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signIn(@required String email, @required String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Sign in here');
      print(userCredential);
      _userId = userCredential.user!.uid.toString();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signup(@required String email, @required String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _userId = userCredential.user!.uid;
      notifyListeners();
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _userId = '';
    notifyListeners();
  }
}
