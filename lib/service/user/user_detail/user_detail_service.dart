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

  Future<UserDetail?> getUserByUserId(String userId) async {

    return _userDetailRepository.getUserByUserId(userId);
  }
}