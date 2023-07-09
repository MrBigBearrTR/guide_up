import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class LicenseAndCertificateAddPage extends StatefulWidget {
  final Function(String) onAdd;

  const LicenseAndCertificateAddPage({Key? key, required this.onAdd}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LicenseAndCertificateAddPageState createState() =>
      _LicenseAndCertificateAddPageState();
}

class _LicenseAndCertificateAddPageState
    extends State<LicenseAndCertificateAddPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _turController = TextEditingController();
  final TextEditingController _yeterlilikKimligiController =
  TextEditingController();
  final TextEditingController _verenOrganizasyonController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lisans ve Sertifika Ekle",
          style: GoogleFonts.nunito(),),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tür:",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _turController,
                  cursorColor: ColorConstants.warningDark,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.warningDark),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Veren Organizasyon:",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _verenOrganizasyonController,
                  cursorColor: ColorConstants.warningDark,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.warningDark),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Yeterlilik kimliği:",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _yeterlilikKimligiController,
                  cursorColor: ColorConstants.warningDark,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.warningDark),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "URL:",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _urlController,
                  cursorColor: ColorConstants.warningDark,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.warningDark),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String ad = _turController.text.trim();
                    String verenOrganizasyon = _verenOrganizasyonController.text.trim();
                    String yeterlilikKimligi = _yeterlilikKimligiController.text.trim();
                    String url = _urlController.text.trim();

                    if (ad.isNotEmpty && verenOrganizasyon.isNotEmpty && yeterlilikKimligi.isNotEmpty && url.isNotEmpty) {
                      String bilgiler = "$ad\n$verenOrganizasyon\n$yeterlilikKimligi\n$url";
                      widget.onAdd(bilgiler);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Hata",
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite, // Yazı rengi
                              ),
                            ),
                            content: Text(
                              "Tüm alanları doldurun.",
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite, // Yazı rengi
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  "Tamam",
                                  style: GoogleFonts.nunito(
                                    color: ColorConstants.warningDark, // Yazı rengi
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            backgroundColor: ColorConstants.theme1DarkBlue, // Popup arka plan rengi
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.warningDark,
                  ),
                  child: Text(
                    "Ekle",
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.itemWhite, // Metin rengi
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _verenOrganizasyonController.dispose();
    _yeterlilikKimligiController.dispose();
    _turController.dispose();
    super.dispose();
  }
}
