import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/router_constants.dart';

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
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.myProfileAccountPage);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset('assets/img/GuideUpLogo.png', // Logo resminin yolunu buraya ekleyin
              width: 62,
              height: 62,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Eğitim Ekle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Okul',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Okul Adı',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bölüm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Bölüm Adı',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Başlangıç Tarihi',
              style: TextStyle(
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
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bitiş Tarihi',
              style: TextStyle(
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
                  decoration: const InputDecoration(
                    hintText: 'Bitiş Tarihi',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Proje Linki',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Proje Linki',
              ),
              onChanged: (value) {
                setState(() {
                  projectLink = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Not',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Not',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kaydet butonuna basıldığında işlemi yap
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF212832), // Arkaplan rengi
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFEEEEEE), // Yazı rengi
                ),
              ),
              child: const Text('Kaydet'),
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
