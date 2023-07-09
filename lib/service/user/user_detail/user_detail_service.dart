import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_up/core/constant/secure_strorage_constant.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/upload/upload_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';

import '../../../core/models/mentor/mentor_model.dart';
import '../../../repository/mentor/mentor_repository.dart';

class UserDetailService {
  late UploadRepository _uploadRepository;
  late UserDetailRepository _userDetailRepository;
  late MentorRepository _mentorRepository;

  UserDetailService() {
    _uploadRepository = UploadRepository();
    _userDetailRepository = UserDetailRepository();
    _mentorRepository = MentorRepository();
  }

  Future<UserDetail?> updateUserPhotoByPathAndUserDetail(
      String filePath, UserDetail userDetail) async {
    var uploadUrl = await _uploadRepository.addProfilePictureByUserId(
        filePath, userDetail.getUserId()!);
    if (uploadUrl.isNotEmpty) {
      userDetail.setPhoto(uploadUrl);
      userDetail = await _userDetailRepository.update(userDetail);

      Mentor? mentor =
          await _mentorRepository.getMentorByUserId(userDetail.getUserId()!);
      if (mentor != null) {
        mentor.setPhoto(uploadUrl);
        await _mentorRepository.update(mentor);
      }

      return userDetail;
    }

    return null;
  }

  Future<UserDetail> add(UserDetail userDetail) async {
    var detail = await _userDetailRepository.add(userDetail);
    const FlutterSecureStorage().write(
        key: SecureStrogeConstants.USER_DETAIL_KEY, value: detail.toJson());

    return detail;
  }

  Future<UserDetail> update(UserDetail userDetail) async {
    var detail = await _userDetailRepository.update(userDetail);
    const FlutterSecureStorage().write(
        key: SecureStrogeConstants.USER_DETAIL_KEY, value: detail.toJson());

    return detail;
  }



  Future<UserDetail?> getUserByUserId(String userId) async {
    return _userDetailRepository.getUserByUserId(userId);
  }
}
