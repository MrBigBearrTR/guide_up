import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserHelper {
  late FirebaseAuth _auth;

  UserHelper() {
    _auth = FirebaseAuth.instance;
  }

  Future<User?> login(String username, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      debugPrint("++"+userCredential.toString());
      return userCredential.user;
    } catch (e) {
      debugPrint("--"+e.toString());
      return null;
    }
  }

  void createUser(String username, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: username, password: password);

      debugPrint("++"+userCredential.toString());

      sendEmailVerification(userCredential.user!);
    } catch (e) {
      debugPrint("--"+e.toString());
    }
  }

  void sendEmailVerification(User user) async {
    try {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        debugPrint("Kullanıcı maili onaylıdır.");
      }
    } catch (e) {
      debugPrint("--"+e.toString());
    }
  }

  void signOut() {
    if(GoogleSignIn().currentUser!=null){
      GoogleSignIn().disconnect();
      debugPrint("++ Googldan çıkış yapıldı");
    }else{
      debugPrint("-- Google hesabı ile giriş bulunamadı");
    }
    if (_auth.currentUser != null) {
      _auth.signOut();
      debugPrint("++"+"Çıkış yapıldı.");
    } else {
      debugPrint("--"+"Giriş yapılmış kullanıcı bulunamadı.");
    }
  }
}
