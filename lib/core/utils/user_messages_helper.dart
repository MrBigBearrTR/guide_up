import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:guide_up/core/models/users/user_token.dart';
import 'package:guide_up/repository/user/user_token_repository.dart';
import 'package:http/http.dart' as http;

class UserMessagesHelper {
  Future<void> sendPushMessage(
      String userId, String title, String content, {String? clickContent}) async {
    UserToken? userToken =
        await UserTokenRepository().getUserTokenByUserId(userId);
    String token = "";
    if (userToken != null) {
      token = userToken.getToken()!;

      try {
        await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAA_drauK8:APA91bG7RGC-XvZz79cVfoVSSpYljK2NF_mPxq097QU38AF-lav9S55ldxYj1vrrH8dztGk1d1hFxvh_nARAmbFbm2Qu_bKVv5mhy91yUhyauUnb1DXmaphr_AHeOgLSJavUg1b02OtP'
            },
            body: jsonEncode(<String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'title': title,
                'body': (clickContent??""),
              },
              'notification': <String, dynamic>{
                'android_channel_id': 'guide_up',
                'title': title,
                'body': content,
              },
              'to': token,
            }));
      } catch (e) {
        if (kDebugMode) {
          debugPrint("Error push message notification!");
        }
      }
    }
  }
}
