import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/mentee/mentee_repository.dart';

import '../../../../core/models/mentor/mentor_model.dart';
import '../../../../repository/mentor/mentor_repository.dart';
import '../../../mentee/mentee_card_pages/mentee_card.dart';

class MentorFollowerPages extends StatefulWidget {
  const MentorFollowerPages({Key? key}) : super(key: key);

  @override
  State<MentorFollowerPages> createState() => _MentorFollowerPagesState();
}

class _MentorFollowerPagesState extends State<MentorFollowerPages> {
  UserDetail? userDetail;
  Mentor? mentor;

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
      mentor = await MentorRepository().getMentorByUserId(detail.getUserId()!);
      setState(() {});
    }
  }

  String getMentorId() {
    if (mentor != null && mentor!.getId() != null) {
      return mentor!.getId()!;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menteelerim',
          style: GoogleFonts.nunito(
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.itemBlack, // Geri buton rengi
          ),
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.generalSettingsPage);
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/logo/guideUpLogo.png', // Logo
              width: 62,
              height: 62,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                color: Colors.transparent, // Arka plan rengi olarak transparent
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                          var mentee = snapshot.data![index];
                          return MenteeCard(mentee: mentee);
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                  },
                  future:
                  MenteeRepository().getMenteeListByMentorId(getMentorId()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
