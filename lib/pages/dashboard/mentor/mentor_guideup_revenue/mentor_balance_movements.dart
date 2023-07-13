import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/utils/secure_storage_helper.dart';

class MentorBalanceMovements extends StatefulWidget {

  const MentorBalanceMovements({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MentorBalanceMovementsState createState() =>
      _MentorBalanceMovementsState();
}


class _MentorBalanceMovementsState
    extends State<MentorBalanceMovements> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    if (userId == null) {
      String? tempUserId = await SecureStorageHelper().getUserId();
      if (tempUserId != null) {
        setState(() {
          userId = tempUserId;
        });
      } else {
        // Kullanıcı oturum açmamışsa veya kimlik doğrulama kullanmıyorsanız,
        // userId değerini uygun şekilde ayarlamanız gerekecektir.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakiye harakketleri',
          style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.itemBlack, // Geri buton rengi
          ),
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.mentorGuideUpRevenuePage);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 1.0,
              color: ColorConstants.itemBlack,
            ),
            SizedBox(height: 16.0),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '21, Ara 2022, 2101',
                      style: GoogleFonts.nunito(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'TR39 00001 0090 1024 6113 0050 01',
                      style: GoogleFonts.nunito(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Ali Yalçın',
                      style: GoogleFonts.nunito(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    child: Text(
                      '4505 \$',
                      style: GoogleFonts.nunito(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
