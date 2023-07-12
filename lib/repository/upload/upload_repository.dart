import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:guide_up/core/constant/firestore_collectioon_constant.dart';

class UploadRepository {

  Future<String> addProfilePictureByUserId(
      String filePath, String userId) async {

    var profileRef = FirebaseStorage.instance
        .ref(FirestoreCollectionConstant.uploadProfilePicturesPath + userId);

    profileRef.putFile(File(filePath));
    return profileRef.getDownloadURL();
  }

  Future<String> addPostPictureByUserId(
      String filePath, String postId) async {

    var profileRef = FirebaseStorage.instance
        .ref(FirestoreCollectionConstant.uploadPostPicturesPath + postId);

    profileRef.putFile(File(filePath));
    return profileRef.getDownloadURL();
  }
}
