import 'package:flutter/material.dart';

import 'package:guide_up/pages/mentor/card_pages/mentor_card.dart';
import 'package:guide_up/repository/mentor/mentor_favourite_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_detail/user_detail_model.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../core/utils/user_helper.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';

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
   String getUserId() {
    if (userDetail != null) {
      return userDetail!.getUserId()!;
    } else {
      return "";
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
        child: ListView(
          children: [
            Column(
              children: [
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorConstants.appcolor4,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Favori mentorları şu an listeyemiyoruz.'),
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
                        future: MentorFavouriteRepository()
                        .getMentorFavouriteListByUserId(getUserId()),
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