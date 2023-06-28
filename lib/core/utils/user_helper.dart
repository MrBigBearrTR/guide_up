import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guide_up/core/constant/firestore_collectioon_constant.dart';
import 'package:guide_up/core/constant/secure_strorage_constant.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';

class UserHelper {
  late FirebaseAuth _auth;

  UserHelper() {
    _auth = FirebaseAuth.instance;
  }

  final userCollection = FirebaseFirestore.instance.collection("users");
  var secureStorage = const FlutterSecureStorage();

  Future<User?> login(String username, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      debugPrint("++" + userCredential.toString());

      final user = userCredential.user;
      if (user != null) {
        UserDetail? userDetail =
        await UserDetailRepository().getUserByAuthUid(user.uid);

        if (userDetail != null) {
          const FlutterSecureStorage().write(
              key: SecureStrogeConstants.USER_DETAIL_KEY,
              value: userDetail.toJson());
        }
      }
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
    secureStorage.delete(key: SecureStrogeConstants.USER_DETAIL_KEY);
  }

  Future<bool> checkUser() async {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> registerWithUserModelAndDetail(UserModel userModel) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: userModel.getEmail()!,
        password: userModel.getPassword()!,
      );

      if (credential.user != null) {
        String userUid = credential.user!.uid;
        userModel.setId(userUid);
        final userCollections = FirebaseFirestore.instance.collection(
            FirestoreCollectionConstant.user);
        var userReturn = await userCollections.add(userModel.toMap());

        //userModel.setId(userUid); // User ID'sini UserModel nesnesine atadık

        return userModel;
      } else {
        throw Exception('Kullanıcı oluşturma başarısız oldu.');
      }
    } catch (error) {
      // Hata durumunda uygun bir işlem yapabilirsiniz.
      print('Hata: $error');
      throw error;
    }
  }

  Future<UserDetail> getUserDetail() async {
    UserDetail detail = UserDetail();
    final userDetailCollections = FirebaseFirestore.instance.collection(
        FirestoreCollectionConstant.userDetail);

    String? userId = await SecureStorageHelper().getUserId();
    if (userId != null) {
      var snapshot = await userDetailCollections.where(
          "userId", isEqualTo: userId).get();
      var documents = snapshot.docs;

      // Liste olarak UserDetail verilerini almak için
      List<UserDetail> userDetailList = [];
      for (var doc in documents) {
        UserDetail tempDetail = UserDetail();
        tempDetail.toClass(doc.data());
        userDetailList.add(tempDetail);
      }

      // Tek bir UserDetail verisini almak için
      if (documents.isNotEmpty) {
        detail.toClass(documents.first.data());
      }
    }

    return detail;
  }
  Future<UserDetail> saveUserDetail(UserDetail userDetail) async {
    try {
      final userDetailCollections = FirebaseFirestore.instance.collection('userDetail');

      var userReturn = await userDetailCollections.add(userDetail.toMap());

      userDetail.setId(userReturn.id);
      await userDetailCollections.doc(userReturn.id).update(userDetail.toMap()); //guncellendi
      return userDetail;
    } catch (error) {

      throw error;
    }
  }
}
