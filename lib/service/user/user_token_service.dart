import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:guide_up/core/models/users/user_token.dart';
import 'package:guide_up/repository/user/user_token_repository.dart';

class UserTokenService {
  late UserTokenRepository _userTokenRepository;

  UserTokenService() {
    _userTokenRepository = UserTokenRepository();
  }

  setToken(String userId) async {
    UserToken? userToken =
        await _userTokenRepository.getUserTokenByUserId(userId);
    String? token = await FirebaseMessaging.instance.getToken();

    if (userToken != null) {
      userToken.setToken(token ?? "");
      _userTokenRepository.update(userToken);
    } else {
      UserToken userToken = UserToken();
      userToken.setUserId(userId);
      userToken.setToken(token ?? "");
      _userTokenRepository.add(userToken);
    }
  }
}
