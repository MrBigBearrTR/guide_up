import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/mentor/mentor_favourite_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/mentee/mentee_repository.dart';
import 'package:guide_up/repository/mentor/mentor_commend_repository.dart';
import 'package:guide_up/repository/mentor/mentor_favourite_repository.dart';
import 'package:guide_up/service/mentee/mentee_service.dart';

import '../../../core/utils/user_helper.dart';
import '../../../core/utils/user_info_helper.dart';

enum EnCardType { view, mentee, comment, payment }

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({super.key});

  @override
  State<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends State<MentorDashboard> {
  UserDetail? userDetail;
  Future<int>? mentorCountFuture;

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
      mentorCountFuture = MenteeRepository()
          .getMenteeListCountByUserId(userDetail!.getUserId()!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: ColorConstants.appcolor1,
            fontSize: 25,
          ),
        ),
        backgroundColor: ColorConstants.theme1White,
      ),
      backgroundColor: ColorConstants.theme1White,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Mentee'nin profil fotoğrafı
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstants.theme2DarkBlue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            UserInfoHelper.getProfilePicture(userDetail),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          userDetail != null
                              ? (" ${userDetail!.getName() ?? ""} ${userDetail!.getSurname() ?? ""}")
                              : "",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: ColorConstants.appcolor4,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${UserHelper().auth.currentUser!.email}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorConstants.appcolor4,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    const Text('İstatistikler', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Süre(Duration)

                        ...createAnalysisCard(
                            "Görüntülenme", EnCardType.view, context),

                        // Favoriler
                        ...createAnalysisCard(
                            "Menteelerim", EnCardType.mentee, context),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Yorumlar
                        ...createAnalysisCard(
                            "Yorumlar", EnCardType.comment, context),

                        // Ödemeler
                        ...createAnalysisCard(
                            "Ödemeler", EnCardType.payment, context),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Kazançlar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                width: 330,
                height: 75,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam Kazanç',
                      style: TextStyle(
                          color: ColorConstants.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    // Veri eklenmeli
                    Text('4055.56 TL', style: TextStyle(fontSize: 17),),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Görüntülenmeler
              Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                width: 330,
                height: 75,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam Görüntülenme',
                      style: TextStyle(
                          color: ColorConstants.warningDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    // Veri eklenmeli
                    Text('290K', style: TextStyle(fontSize: 17),),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Puanlamalar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                width: 330,
                height: 75,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam Puanlama',
                      style: TextStyle(
                          color: ColorConstants.info,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    // Veri eklenmeli
                    Text('1125', style: TextStyle(fontSize: 17),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getUserId() {
    if (userDetail != null) {
      return userDetail!.getUserId()!;
    } else {
      return "";
    }
  }

  List<Widget> createAnalysisCard(
      String title, EnCardType cardType, BuildContext context) {
    return [
      getAvatar(cardType, context),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getFutureCount(cardType),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Veriler henüz yüklenmediyse, bekleme göster
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Hata oluştuysa, hata mesajını göster
                return Text('Hata: ${snapshot.error}');
              } else {
                // Veriler hazırsa, sayıyı göster
                final dynamic count = snapshot.data ?? 0;
                return Text(
                  '  $count',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              '$title',
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Future<dynamic> getFutureCount(EnCardType cardType) async {
    if (cardType == EnCardType.view) {
      return MenteeRepository().getMenteeListCountByUserId(getUserId());
    } else if (cardType == EnCardType.comment) {
      return MentorCommendRepository()
          .getMentorCommendListCountByUserId(getUserId());
    } else if (cardType == EnCardType.mentee) {
      return MentorFavouriteRepository()
          .getMentorFavouriteListCountByUserId(getUserId());
    } else if (cardType == EnCardType.payment) {
      return MenteeService().getTotalPriceByUserId(getUserId());
    }

    return 0;
  }

  Widget getAvatar(EnCardType cardType, BuildContext context) {
    switch (cardType) {
      case EnCardType.view:
        return CircleAvatar(
          backgroundColor: ColorConstants.theme2White,
          child: InkWell(
            // onTap: () {
            //   Navigator.pushNamed(context, RouterConstants.myMentors);
            // },
            child: const Icon(
              Icons.timeline,
              color: ColorConstants.success,
            ),
          ),
        );
      case EnCardType.mentee:
        return CircleAvatar(
          backgroundColor: ColorConstants.theme2White,
          child: InkWell(
            // onTap: () {
            //   Navigator.pushNamed(
            //       context, RouterConstants.menteeFavouriteMentorPage);
            // },
            child: const Icon(
              Icons.person,
              color: ColorConstants.warningDark,
            ),
          ),
        );
      case EnCardType.comment:
        return CircleAvatar(
          backgroundColor: ColorConstants.theme2White,
          child: InkWell(
            // onTap: () {
            //   Navigator.pushNamed(context, RouterConstants.myCommends);
            // },
            child: const Icon(
              Icons.chat,
              color: ColorConstants.theme1Mustard,
            ),
          ),
        );
      case EnCardType.payment:
        return CircleAvatar(
          backgroundColor: ColorConstants.theme2White,
          child: InkWell(
            // onTap: () {
            //   Navigator.pushNamed(context, RouterConstants.myPayments);
            // },
            child: const Icon(
              Icons.currency_lira,
              color: ColorConstants.infoDark,
            ),
          ),
        );
    }
  }
}
