import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class LicensesAndCertificatesArrangementPage extends StatefulWidget {
  final String url;
  final Function(String) onUpdate;
  final VoidCallback onDelete;

  const LicensesAndCertificatesArrangementPage({Key? key,
    required this.url,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LicensesAndCertificatesArrangementPageState createState() =>
      _LicensesAndCertificatesArrangementPageState();
}

class _LicensesAndCertificatesArrangementPageState
    extends State<LicensesAndCertificatesArrangementPage> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.text = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lisans ve Sertifika Düzenle",
            style: GoogleFonts.nunito()),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "URL:",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _urlController,
                cursorColor: ColorConstants.warningDark,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorConstants.warningDark,),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String updatedUrl = _urlController.text.trim();
                      widget.onUpdate(updatedUrl);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.warningDark,
                    ),
                    child: Text("Güncelle",
                      style: GoogleFonts.nunito(
                        color: ColorConstants.itemWhite, // Metin rengi
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Silmek istediğinize emin misiniz?",
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text("Evet",
                                  style: GoogleFonts.nunito(
                                    color: ColorConstants.warningDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  widget.onDelete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text("Hayır",
                                  style: GoogleFonts.nunito(
                                    color: ColorConstants.warningDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            backgroundColor: ColorConstants.theme1DarkBlue,
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.dangerDark,
                    ),
                    child: Text("Sil",
                      style: GoogleFonts.nunito(
                        color: ColorConstants.itemWhite, // Metin rengi
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
