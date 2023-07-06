import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../../core/utils/user_helper.dart';

class MenteeDashboardMainPage extends StatefulWidget {
  const MenteeDashboardMainPage({super.key});

  @override
  State<MenteeDashboardMainPage> createState() =>
      _MenteeDashboardMainPageState();
}

class _MenteeDashboardMainPageState extends State<MenteeDashboardMainPage> {
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
          style: TextStyle(
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
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/img/unknown_user.png'),
                ),
                SizedBox(height: 8),
                Text(
                  '${userDetail != null ? (" ${userDetail!.getName()!} ${userDetail!.getSurname()!}") : "User"}',
                  style: TextStyle(fontSize: 20),
                ),
                Text('${UserHelper().auth.currentUser!.email}'),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  width: 330,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.itemWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('İstatistikler', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //1.
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: Icon(
                              Icons.timeline,
                              color: ColorConstants.success,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  28 Saat',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ), //Burası veriden alınmalı.
                              Text('  Süre'),
                            ],
                          ),
                          SizedBox(width: 40),
                          //2.
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: Icon(
                              Icons.person,
                              color: ColorConstants.warningDark,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  150',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ), //Burası veriden alınmalı.
                              Text('  Favoriler'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //3.
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: Icon(
                              Icons.chat,
                              color: ColorConstants.theme1Mustard,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  5',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ), //Burası veriden alınmalı.
                              Text('  Yorumlar'),
                            ],
                          ),
                          SizedBox(width: 40),
                          //4.
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: Icon(
                              Icons.currency_lira,
                              color: ColorConstants.infoDark,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  50 TL',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ), //Burası veriden alınmalı.
                              Text('  Ödemeler'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Yorumlarım',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.itemWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: ColorConstants.warning,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: ColorConstants.warning,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: ColorConstants.warning,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: ColorConstants.warning,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/img/unknown_user.png'),
                          ),
                          Container(
                            width: 220,
                            child: Expanded(
                              child: Text(
                                'Yazılım alanındaki deneyimleriniz ile şu an çok daha iyi yerler geleceğime inanıyorum.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}