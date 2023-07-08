import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/pages/dashboard/mentee/mentee_commend_card.dart';
import 'package:guide_up/repository/mentee/mentee_repository.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/mentor/mentor_commend_repository.dart';
import 'package:guide_up/service/mentee/mentee_service.dart';

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
                const SizedBox(height: 8),
                // Mentee'nin isim-soyisim bilgileri
                Text(
                  '${userDetail != null ? (" ${userDetail!.getName()!} ${userDetail!.getSurname()!}") : "User"}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text('${UserHelper().auth.currentUser!.email}'),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                          // Süre(Duration)
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouterConstants.myMentors);
                              },
                              child: Icon(
                                Icons.timeline,
                                color: ColorConstants.success,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // FutureBuilder<int>(
                              //   future: MenteeRepository().getMenteeListCountByUserId(userId),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<int> snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       // Veriler henüz yüklenmediyse, bekleme göster
                              //       return CircularProgressIndicator();
                              //     } else if (snapshot.hasError) {
                              //       // Hata oluştuysa, hata mesajını göster
                              //       return Text('Hata: ${snapshot.error}');
                              //     } else {
                              //       // Veriler hazırsa, sayıyı göster
                              //       final int menteeCount = snapshot.data ?? 0;
                              //       return Text('Mentor Sayısı: $menteeCount');
                              //     }
                              //   },
                              // ),
                              // Text(
                              //   '${}',
                              //   style: TextStyle(
                              //       fontSize: 17, fontWeight: FontWeight.bold),
                              // ), //Burası veriden alınmalı.
                              Text('  Benim Mentorlarım'),
                            ],
                          ),
                          SizedBox(width: 40),
                          // Favoriler
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouterConstants.mentorFavourite);
                              },
                              child: Icon(
                                Icons.person,
                                color: ColorConstants.warningDark,
                              ),
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
                          // Yorumlar
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouterConstants.myCommends);
                              },
                              child: Icon(
                                Icons.chat,
                                color: ColorConstants.theme1Mustard,
                              ),
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
                          // Ödemeler
                          CircleAvatar(
                            backgroundColor: ColorConstants.theme2White,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouterConstants.myPayments);
                              },
                              child: Icon(
                                Icons.currency_lira,
                                color: ColorConstants.infoDark,
                              ),
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
                const SizedBox(height: 40),
                const Text(
                  'Yorumlarım',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                      height: 200,
                      child: Expanded(
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Mentorları şu an listeyemiyoruz.'),
                              );
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final mentor = snapshot.data![index];
                                  return MenteeCommendCard(mentor: mentor);
                                },
                                //itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                              );
                            }
                          },
                          future: MentorCommendRepository().getMentorCommendListByUserId(userId),
                        ),
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

/*
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 50),
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/img/unknown_user.png'),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 220,
                            child: const Expanded(
                              child: Text(
                                ' Yazılım alanındaki deneyimleriniz ile çok daha iyi yerler geleceğime inanıyorum.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Expanded(
                              child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
*/