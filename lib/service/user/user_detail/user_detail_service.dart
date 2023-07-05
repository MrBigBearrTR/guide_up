import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_up/core/constant/secure_strorage_constant.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/upload/upload_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';

class UserDetailService{

  late UploadRepository _uploadRepository;
  late UserDetailRepository _userDetailRepository;

  UserDetailService(){
    _uploadRepository=UploadRepository();
    _userDetailRepository=UserDetailRepository();
  }

  Future<UserDetail?> updateUserPhotoByPathAndUserDetail(String filePath,UserDetail userDetail) async {

    var uploadUrl=await _uploadRepository.addProfilePictureByUserId(filePath, userDetail.getUserId()!);
    if(uploadUrl.isNotEmpty){
      userDetail.setPhoto(uploadUrl);
      userDetail = await _userDetailRepository.update(userDetail);
      return userDetail;
    }

    return null;
  }
  Future<UserDetail> add (UserDetail userDetail) async {
    var detail = await _userDetailRepository.add(userDetail);
    const FlutterSecureStorage().write(key: SecureStrogeConstants.USER_DETAIL_KEY, value: detail.toJson());

    return detail ;
  }
}