import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/models/users/user_education/user_education_model.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../repository/user/user_education/user_education_repository.dart';

class UserEducationInformationList extends StatefulWidget {

  const UserEducationInformationList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserEducationInformationListState createState() =>
      _UserEducationInformationListState();
}


class _UserEducationInformationListState
    extends State<UserEducationInformationList> {
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
  void _deleteEducationInformation(UserEducation educationInformation) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eğitim Bilgisini Sil',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite),),
          content: Text(
              'Bu eğitim bilgisini silmek istediğinizden emin misiniz?',
          style: GoogleFonts.nunito(color: ColorConstants.itemWhite),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal',
                  style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await UserEducationInformationRepository()
                      .delete(educationInformation);

                  setState(() {});

                  print(
                      'EducationInformation deleted from Firebase: $educationInformation');
                } catch (error) {
                  print(
                      'Failed to delete educationInformation from Firebase: $error');
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Sil'),
            ),
          ],
          backgroundColor: ColorConstants.theme1DarkBlue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eğitim Bilgileri',
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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: ColorConstants.theme1DarkBlue, // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(context,RouterConstants.userEducationInformationPage);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserEducation>>(
        future: UserEducationInformationRepository()
            .getUserEducationInformationListByUserId(userId?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Eğitim bilgilerinizi şu an listeleyemiyoruz.',
                    style: GoogleFonts.nunito(),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/logo/guideUpLogo.png',
                      width: 62,
                      height: 62,
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Image.asset(
                        'assets/logo/guideUpLogo.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouterConstants.userEducationInformationPage);
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            ColorConstants.theme1DarkBlue),
                        elevation: MaterialStateProperty.all<double>(8.0),
                        // Gölge efekti
                        overlayColor: MaterialStateProperty.all<Color>(
                            ColorConstants.theme2DarkOpacity20),

                      ),
                      child: Text(
                        'Eğitim bilgisi kaydınız bulunamadı. Eklemeye ne dersiniz?',
                        style: GoogleFonts.nunito(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final educationInformation = snapshot.data![index];
                  return  Card(
                      color: ColorConstants.theme1DarkBlue, // Eklenen tablo rengi
                      elevation: 2, // Card'ın gölgelendirme seviyesi
                      margin: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Okul: ${educationInformation.getSchoolName() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (educationInformation.getDepartment()?.isNotEmpty ==
                            true)
                          Text(
                              'Departman: ${educationInformation.getDepartment()}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                        Text(
                            'Başlangıç Tarihi: ${educationInformation.getStartDate() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (educationInformation.getEndDate() != null)
                          Text(
                              'Bitiş Tarihi: ${educationInformation.getEndDate() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                        Text('Sınıf: ${educationInformation.getGrade() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (educationInformation
                                .getActivitiesSocienties()
                                ?.isNotEmpty ==
                            true)
                          Text(
                              'Aktiviteler/Sosyal Faaliyetler: ${educationInformation.getActivitiesSocienties() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                        Text(
                            'Açıklama: ${educationInformation.getDescription() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (educationInformation.getLink()?.isNotEmpty == true)
                          Text(
                              'Bağlantı: ${educationInformation.getLink() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteEducationInformation(educationInformation),color: ColorConstants
                        .buttonPurple, // Silme butonu rengi
                    ),
                  ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
