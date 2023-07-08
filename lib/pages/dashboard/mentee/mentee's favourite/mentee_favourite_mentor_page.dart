import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_detail/user_detail_model.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../core/utils/user_helper.dart';

class _MenteeFavouriteMentorPageState extends StatefulWidget {
  const _MenteeFavouriteMentorPageState({super.key});

  @override
  State<_MenteeFavouriteMentorPageState> createState() =>
      _MenteeFavouriteMentorPageStateState();
}

class _MenteeFavouriteMentorPageStateState
    extends State<_MenteeFavouriteMentorPageState> {
  UserDetail? userDetail;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      userDetail = detail;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${userDetail != null ? (" ${userDetail!.getName()!} Dashboard") : "Mentee Dashboard"}',
          style: const TextStyle(
            color: ColorConstants.appcolor1,
            fontSize: 25,
          ),
        ),
        backgroundColor: ColorConstants.theme1White,
      ),
      backgroundColor: ColorConstants.theme1White,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                // Mentee'nin profil fotoğrafı
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/img/unknown_user.png'),
                ),
                // Mentee'nin isim-soyisim bilgileri
                Text(
                  '${userDetail != null ? (" ${userDetail!.getName()!} ${userDetail!.getSurname()!}") : "User"}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text('${UserHelper().auth.currentUser!.email}'),
                const SizedBox(height: 40),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
