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

  Future<void> register(String name, String surname, String email,
      String password, String confirmPassword, String role) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'ConfirmPassword': confirmPassword,
        'role': role,
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Handle registration errors
      print('Registration failed: $e');
      throw e;
    }
  }

  Future<UserDetail> registerWithUserModelAndUserDetail(
      UserModel userModel, UserDetail userDetail) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.getEmail()!,
        password: userModel.getPassword()!,
      );

      userModel.setId(credential.user!.uid);

      final userCollections = FirebaseFirestore.instance
          .collection(FirestoreCollectionConstant.user);
      final userDetailCollections = FirebaseFirestore.instance
          .collection(FirestoreCollectionConstant.userDetail);

      var userReturn = await userCollections.add(userModel.toMap());

      userDetail.setUserId(userReturn.id);
      var userDteailReturn =
          await userDetailCollections.add(userDetail.toMap());

      userDetail.setId(userDteailReturn.id);
      userDetailCollections.doc(userDteailReturn.id).update(userDetail.toMap());

      print("==========================================================");
      print(userDetail.toJson());
      print("==========================================================");

      print(FirebaseAuth.instance.currentUser);
      secureStorage.delete(key: SecureStrogeConstants.USER_DETAIL_KEY);
      secureStorage.write(
          key: SecureStrogeConstants.USER_DETAIL_KEY,
          value: userDetail.toJson());
    } catch (e) {
      // Handle registration errors
      print('Registration failed: $e');
      throw e;
    }

    return UserDetail();
  }

  Future<UserDetail> getUserDetail() async {
    UserDetail detail = UserDetail();
    final userDetailCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userDetail);

    String? userId = await SecureStorageHelper().getUserId();
    if (userId != null) {
      var gelen =
          await userDetailCollections.where("userId", isEqualTo: userId).get();
      print(gelen.docs);

      //LİST YAPISI
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it =
          gelen.docs.iterator;
      while (it.moveNext()) {
        QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
        UserDetail tempDetail = UserDetail();
        tempDetail.toClass(snap.data());
        print(tempDetail.getName());
      }

      print("=========================");
      //tek veri
      detail.toClass(gelen.docs.first.data());
      print(detail.getSurname());

      print("--------------------------");
    }

    return UserDetail();
  }

  void registerTest() {
    UserModel userModel = UserModel();
    userModel.setEmail("aliyalcin01@gmail.com");
    userModel.setMentor(false);
    userModel.setPassword("123456789");

    UserDetail userDetail = UserDetail();
    userDetail.setName("Ali");
    userDetail.setSurname("Yalçın");
    userDetail.setPhoto("assets/img/profile/AliYalci");
    userDetail.setAbout("yakışıklı ve de zeki");
    userDetail.setPhone("905438570768");
    userDetail.setBirthday(DateTime.now());

    print("Geldii Başladı==============================");
    print(registerWithUserModelAndUserDetail(userModel, userDetail));
    print("Geldii Bitti==============================");
  }
}
