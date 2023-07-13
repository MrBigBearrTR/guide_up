import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../core/constant/router_constants.dart';
import '../../../core/models/users/user_license_and_certificate/user_license_and_certificate_model.dart';
import '../../../core/utils/secure_storage_helper.dart';
import '../../../repository/user/user_licence_and_certificate/user_licence_and_certificate_repository.dart';

class LicensesAndCertificatesPage extends StatefulWidget {

  const LicensesAndCertificatesPage({Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LicensesAndCertificatesPageState createState() => _LicensesAndCertificatesPageState();
}

class _LicensesAndCertificatesPageState extends State<LicensesAndCertificatesPage> {
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
  void _deleteLicensesAndCertificates(
      UserLicenseAndCertificate licenseAndCertificate) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sil',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
          content: Text('silmek istediğinizden emin misiniz?',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
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
                  await UserLicenseAndCertificateRepository()
                      .delete(licenseAndCertificate);

                  setState(() {});

                  print(
                      'LicenseAndCertificate deleted from Firebase: $licenseAndCertificate');
                } catch (error) {
                  print(
                      'Failed to delete licenseAndCertificate from Firebase: $error');
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Text('Sil',
                  style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
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
        title: Text(
          'Lisanslar ve sertifikalar',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.theme1DarkBlue, // Geri buton rengi
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
              Navigator.pushNamed(
                context,
                RouterConstants.licenseAndCertificateAddPage
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserLicenseAndCertificate>>(
        future: UserLicenseAndCertificateRepository()
            .getUserLicenseAndCertificateListByUserId(userId ?? ""),
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
                  Text('Lisans ve sertifikalarınızı şu an listeleyemiyoruz.',
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
                            context, RouterConstants.licenseAndCertificateAddPage);
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.theme1DarkBlue),
                        elevation: MaterialStateProperty.all<double>(8.0), // Gölge efekti
                        overlayColor: MaterialStateProperty.all<Color>(ColorConstants.theme2DarkOpacity20),

                      ),
                      child: const Text(
                        'Lisans ve sertifika kaydınız bulunamadı.\nEklemeye ne dersiniz?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final licenseAndCertificate = snapshot.data![index];
                  return Card(
                      color: ColorConstants.theme1DarkBlue, // Eklenen tablo rengi
                      elevation: 2, // Card'ın gölgelendirme seviyesi
                      margin: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Lisans veya sertifika adı: ${licenseAndCertificate.getLicenseName() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (licenseAndCertificate
                                .getOrganization()
                                ?.isNotEmpty ==
                            true)
                          Text(
                              'Veren organizasyon: ${licenseAndCertificate.getOrganization()}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                        Text(
                            'Veriliş tarihi: ${licenseAndCertificate.getStartDate() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (licenseAndCertificate.getEndDate() != null)
                          Text(
                              'Sona erme tarihi: ${licenseAndCertificate.getEndDate() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                        if (licenseAndCertificate
                            .getAuthorizationId()
                            ?.isNotEmpty ==
                            true)
                        Text(
                            'Yetkilendirme ID: ${licenseAndCertificate.getAuthorizationId() ?? ""}',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),),
                        if (licenseAndCertificate
                                .getAuthorizationUrl()
                                ?.isNotEmpty ==
                            true)
                          Text(
                              'Yetkilendirme URL: ${licenseAndCertificate.getAuthorizationUrl() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteLicensesAndCertificates(licenseAndCertificate),color: ColorConstants
                        .theme2Orange, // Silme butonu rengi
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
