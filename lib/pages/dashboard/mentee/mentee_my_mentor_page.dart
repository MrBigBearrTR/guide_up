import 'package:flutter/material.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/models/users/user_detail/user_detail_model.dart';
import '../../../core/utils/secure_storage_helper.dart';

class MenteeMyMentorPage extends StatefulWidget {
  const MenteeMyMentorPage({Key? key}) : super(key: key);

  @override
  State<MenteeMyMentorPage> createState() => _MenteeMyMentorPageState();
}

class _MenteeMyMentorPageState extends State<MenteeMyMentorPage> {
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
          'Mentorlarım',
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
            /*  child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                    return MenteeMyMentorCard(mentor: mentor);
                  },
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                );
              }
            },
            future: MentorService().getMenteeListByUserId(getUserId()),
          ),*/
            ),
      ),
    );
  }
}
