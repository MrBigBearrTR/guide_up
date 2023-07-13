import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/service/mentor/mentor_service.dart';
import 'package:guide_up/ui/material/custom_material.dart';
import '../../../mentor/card_pages/mentor_card.dart';

class MentorFollowerPages extends StatefulWidget {
  const MentorFollowerPages({Key? key}) : super(key: key);

  @override
  State<MentorFollowerPages> createState() => _MentorFollowerPagesState();
}

class _MentorFollowerPagesState extends State<MentorFollowerPages> {
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
        title: Text(
          'My Dashboard',
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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: ColorConstants.itemBlack, // Varsayılan arka plan rengi
                backgroundImage: UserInfoHelper.getProfilePicture(userDetail),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              userDetail != null ? (" ${userDetail!.getName() ?? ""} ${userDetail!.getSurname() ?? ""}") : "",
              style: GoogleFonts.nunito(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: ColorConstants.itemBlack,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: CustomMaterial.backgroundBoxDecoration,
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
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.map<Widget>((mentor) {
                          return MentorCard(mentor: mentor);
                        }).toList(),
                      );
                    }
                  },
                  future: MentorService().getTopMentorList(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
