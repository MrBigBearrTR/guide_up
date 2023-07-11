import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/mentor/card_pages/mentor_card.dart';
import 'package:guide_up/service/user/user_service.dart';
import 'package:guide_up/service/user/user_token_service.dart';

import '../../core/constant/navigation_constants.dart';
import '../../core/utils/user_info_helper.dart';
import '../../service/mentor/mentor_service.dart';

final List<String> imgList = [
  'https://images1.welcomesoftware.com/Zz0xYWZiMThkNjI1NDYxMWVkODJkZjdhNjM2MmRjMGQ2OA==?width=800&q=80',
];
final List<String> eventList = [
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
];

class HomeScreen extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> navigationKey;

  const HomeScreen({Key? key, required this.navigationKey}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(navigationKey);
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<CurvedNavigationBarState> navigationKey;
  UserDetail? userDetail;

  _HomeScreenState(this.navigationKey);

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
      UserTokenService().setToken(userDetail!.getUserId()!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.theme1White,
        automaticallyImplyLeading: false,
        title: const Text(
          'G u i d e  U p',
          style: TextStyle(
            color: ColorConstants.appcolor1,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            color: ColorConstants.appcolor1,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            icon: const Icon(Icons.notifications),
            color: ColorConstants.appcolor1,
          ),
          GestureDetector(
            onTap: () async {
              if (await UserService().checkUser()) {
                Navigator.pushNamed(context, RouterConstants.profilePage);
              } else {
                Navigator.pushNamed(context, RouterConstants.loginPage);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: ColorConstants.theme2Orange,
                backgroundImage: UserInfoHelper.getProfilePicture(userDetail),
              ),
            ),
          ),
        ],
      ),
      body: Container(
          color: ColorConstants.theme1White,
          //decoration: CustomMaterial.backgroundBoxDecoration,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: imgList
                          .map(
                            (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(item, fit: BoxFit.contain),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: 250,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'En Sevilen Mentorlar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () {
                            final navigationState = navigationKey.currentState!;
                            navigationState
                                .setPage(NavigationConstants.searchPageIndex);
                          },
                          child: const Text(
                            'Hepsini Gör',
                            style: TextStyle(
                              color: ColorConstants.info,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 200,
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
                                return MentorCard(mentor: mentor);
                              },
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                            );
                          }
                        },
                        future: MentorService().getTopMentorList(5),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Yaklaşan Etkinlikler',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    CarouselSlider(
                      items: eventList
                          .map(
                            (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(item, fit: BoxFit.contain),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: 250,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Senin için Önerilenler',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
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
                                return MentorCard(mentor: mentor);
                              },
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                            );
                          }
                        },
                        future: MentorService().getTopMentorList(5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
