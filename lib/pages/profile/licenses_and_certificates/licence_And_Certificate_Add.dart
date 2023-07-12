import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/constant/router_constants.dart';
import '../../../core/models/users/user_license_and_certificate/user_license_and_certificate_model.dart';
import '../../../core/utils/secure_storage_helper.dart';
import '../../../repository/user/user_licence_and_certificate/user_licence_and_certificate_repository.dart';

class LicenseAndCertificateAddPage extends StatefulWidget {
  const LicenseAndCertificateAddPage({Key? key}) : super(key: key);

  @override
  State<LicenseAndCertificateAddPage> createState() =>
      _LicenseAndCertificateAddPageState();
}

class _LicenseAndCertificateAddPageState
    extends State<LicenseAndCertificateAddPage> {
  TextEditingController licenseNameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController authorizationIdController = TextEditingController();
  TextEditingController authorizationUrlController = TextEditingController();

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

  void addLicenseAndCertificate() async {
    String licenseName = licenseNameController.text.trim();
    String organization = organizationController.text.trim();
    String issueDate = issueDateController.text.trim();
    //String expiryDate = expiryDateController.text.trim();
    String authorizationId = authorizationIdController.text.trim();
    String authorizationUrl = authorizationUrlController.text.trim();

    if (licenseName.isEmpty || organization.isEmpty || issueDate.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Uyarı',
              style: GoogleFonts.nunito(
                color: ColorConstants.dangerDark,
              ),
            ),
            content: Text(
              'Adı, Başlangıç Tarihi ve Veren organizasyon alanları boş bırakılamaz.',
              style: GoogleFonts.nunito(
                color: ColorConstants.itemWhite,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.nunito(
                    color: ColorConstants.itemWhite,
                  ),
                ),
              ),
            ],
            backgroundColor: ColorConstants.theme1DarkBlue,
          );
        },
      );
      return;
    }
    UserLicenseAndCertificate userLicenseAndCertificate =
        UserLicenseAndCertificate();
    userLicenseAndCertificate.setUserId(userId!);
    userLicenseAndCertificate.setLicenseName(licenseName);
    userLicenseAndCertificate.setOrganization(organization);
    //TODO KEREMİO BAKACAK
    // userLicenseAndCertificate.setIssueDate(issueDate);
    // userLicenseAndCertificate.setExpiryDate(expiryDate);
    userLicenseAndCertificate.setAuthorizationId(authorizationId);
    userLicenseAndCertificate.setAuthorizationUrl(authorizationUrl);

    try {
      await UserLicenseAndCertificateRepository()
          .add(userLicenseAndCertificate);

      setState(() {
        licenseNameController.clear();
        organizationController.clear();
        //TODO KEREMİO BAKACAK
        //issueDateController.clear();
        //expiryDateController.clear();
        authorizationIdController.clear();
        authorizationUrlController.clear();
      });

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Başarılı',
              style: GoogleFonts.nunito(
                color: ColorConstants.itemWhite,
              ),
            ),
            content: Text(
              'Eğitim bilgisi başarıyla eklendi.',
              style: GoogleFonts.nunito(
                color: ColorConstants.success,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.nunito(
                    color: ColorConstants.itemWhite,
                  ),
                ),
              ),
            ],
            backgroundColor: ColorConstants.theme1DarkBlue,
          );
        },
      );

      print(
          'LicenseAndCertificate added to Firebase: $userLicenseAndCertificate');
    } catch (error) {
      print('Failed to add licenseAndCertificate to Firebase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.itemWhite, // AppBar arka plan rengi
        title: Text(
          'Lisans ve sertifika',
          style: GoogleFonts.nunito(
            // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: ColorConstants.theme1DarkBlue, // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouterConstants.licensesAndCertificatesPage,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Adı',
                labelStyle: GoogleFonts.nunito(
                  color: (licenseNameController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (licenseNameController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: licenseNameController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Veren Organizasyon',
                labelStyle: GoogleFonts.nunito(
                  color: (organizationController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (organizationController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: organizationController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Başlangıç Tarihi',
                labelStyle: GoogleFonts.nunito(
                  color: (issueDateController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (issueDateController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: issueDateController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Bitiş Tarihi (isteğe bağlı)',
                labelStyle: GoogleFonts.nunito(
                  color: (expiryDateController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (expiryDateController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: expiryDateController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Yeterlilik kimliği (isteğe bağlı)',
                labelStyle: GoogleFonts.nunito(
                  color: (authorizationIdController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (authorizationIdController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: authorizationIdController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Yeterlilik URL'si (isteğe bağlı)",
                labelStyle: GoogleFonts.nunito(
                  color: (authorizationUrlController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (authorizationUrlController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: authorizationUrlController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addLicenseAndCertificate();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    ColorConstants.theme1DarkBlue, // Arka plan rengi
              ),
              child: Text(
                'Ekle',
                style: GoogleFonts.nunito(
                  color: ColorConstants.itemWhite, // Yazı rengi
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
