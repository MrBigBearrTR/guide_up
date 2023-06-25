import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant/secure_strorage_constant.dart';
import '../models/users/user_detail/user_detail_model.dart';

class SecureStorageHelper {
  var secureStorage = const FlutterSecureStorage();

  Future<UserDetail?> getUserDetail() async {
    String? detailJson =
        await secureStorage.read(key: SecureStrogeConstants.USER_DETAIL_KEY);
    if (detailJson != null) {
      UserDetail detail = UserDetail().fromJson(detailJson);
      return detail;
    } else {
      return null;
    }
  }

  Future<String?> getUserId() async {
    UserDetail? detail = await getUserDetail();
    if (detail != null) {
      return detail.getUserId();
    } else {
      return null;
    }
  }

  Future<bool> isFirstEnter() async {
    return !(await secureStorage.containsKey(
        key: SecureStrogeConstants.FIRST_SIGIN_KEY));
  }
}
