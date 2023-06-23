import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserHelper {
  late FirebaseAuth _auth;

  UserHelper() {
    _auth = FirebaseAuth.instance;
  }
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<User?> login(String username, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      debugPrint("++" + userCredential.toString());
      return userCredential.user;
    } catch (e) {
      debugPrint("--" + e.toString());

      String errorMessage = "";

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'E-posta adresi bulunamadı.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Yanlış şifre girdiniz.';
        } else {
          errorMessage = 'Giriş yapılırken bir hata oluştu.';
        }
      } else {
        errorMessage = 'Giriş yapılırken bir hata oluştu.';
      }

      throw Exception(errorMessage);
    }
  }

  void createUser(String username, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: username, password: password);

      debugPrint("++" + userCredential.toString());

      sendEmailVerification(userCredential.user!);
    } catch (e) {
      debugPrint("--" + e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  void sendEmailVerification(User user) async {
    try {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        debugPrint("Kullanıcı maili onaylıdır.");
      }
    } catch (e) {
      debugPrint("--" + e.toString());
    }
  }

  void signOut() {
    FirebaseAuth _auth = FirebaseAuth.instance;

    if (GoogleSignIn().currentUser != null) {
      GoogleSignIn().disconnect();
      debugPrint("++ Googldan çıkış yapıldı");
    } else {
      debugPrint("-- Google hesabı ile giriş bulunamadı");
    }
    if (_auth.currentUser != null) {
      _auth.signOut();
      debugPrint("++" + "Çıkış yapıldı.");
    } else {
      debugPrint("--" + "Giriş yapılmış kullanıcı bulunamadı.");
    }
  }
Future<bool> checkUser() async {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
  Future<void> register(
      String name,
      String surname,
      String email,
      String password,
      String confirmPassword,
      String role
      ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'ConfirmPassword': confirmPassword,
        'role': role ,
      });

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Additional logic, such as storing user details in a database, can be added here
    } catch (e) {
      // Handle registration errors
      print('Registration failed: $e');
      throw e;
    }
  }
}