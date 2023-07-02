import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../../../core/constant/color_constants.dart';

class EducationInformation extends StatefulWidget {
  const EducationInformation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EducationInformationState createState() => _EducationInformationState();
}

class _EducationInformationState extends State<EducationInformation> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String? projectLink;

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '',
          style: GoogleFonts.nunito(),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/logo/guideUpLogo.png', // Logo resminin yolunu buraya ekleyin
              width: 62,
              height: 62,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eğitim Ekle',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Okul',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
              cursorColor: ColorConstants.warningDark,
              decoration: const InputDecoration(
                hintText: 'Okul Adı',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.warningDark, // Alt çizgi rengi
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bölüm',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
              cursorColor: ColorConstants.warningDark,
              decoration: const InputDecoration(
                hintText: 'Bölüm Adı',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.warningDark, // Alt çizgi rengi
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Başlangıç Tarihi',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectStartDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    hintText: 'Başlangıç Tarihi',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.warningDark, // Alt çizgi rengi
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bitiş Tarihi',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectEndDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _endDateController,
                  style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
                  decoration: const InputDecoration(
                    hintText: 'Bitiş Tarihi',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.warningDark, // Alt çizgi rengi
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Proje Linki',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
              cursorColor: ColorConstants.warningDark,
              decoration: const InputDecoration(
                hintText: 'Proje Linki',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.warningDark, // Alt çizgi rengi
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  projectLink = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Not',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
              cursorColor: ColorConstants.warningDark,
              decoration: const InputDecoration(
                hintText: 'Not',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.warningDark, // Alt çizgi rengi
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kaydet butonuna basıldığında işlemi yap
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.warningDark, // Arkaplan rengi
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.itemWhite, // Metin rengi
                ),
              ),
              child: Text(
                'Kaydet',
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 216,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime? date) {
              if (date != null) {
                setState(() {
                  _startDateController.text =
                  '${date.day}/${date.month}/${date.year}';
                });
              }
            },
          ),
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _startDateController.text =
        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 216,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime? date) {
              if (date != null) {
                setState(() {
                  _endDateController.text =
                  '${date.day}/${date.month}/${date.year}';
                });
              }
            },
          ),
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _endDateController.text =
        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }
}
