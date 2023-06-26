import 'package:flutter/material.dart';

class LicenseAndCertificateAddPage extends StatefulWidget {
  final Function(String) onAdd;

  const LicenseAndCertificateAddPage({super.key, required this.onAdd});

  @override
  // ignore: library_private_types_in_public_api
  _LicenseAndCertificateAddPageState createState() =>
      _LicenseAndCertificateAddPageState();
}

class _LicenseAndCertificateAddPageState
    extends State<LicenseAndCertificateAddPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _turController = TextEditingController();
  final TextEditingController _yeterlilikKimligiController = TextEditingController();
  final TextEditingController _verenOrganizasyonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lisans ve Sertifika Ekle"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tür:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _turController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Veren Organizasyon:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _verenOrganizasyonController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Yeterlilik kimliği:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _yeterlilikKimligiController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "URL:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String ad = _turController.text.trim();
                  String verenOrganizasyon =
                  _verenOrganizasyonController.text.trim();
                  String yeterlilikKimligi =
                  _yeterlilikKimligiController.text.trim();
                  String url = _urlController.text.trim();

                  if (ad.isNotEmpty &&
                      verenOrganizasyon.isNotEmpty &&
                      yeterlilikKimligi.isNotEmpty &&
                      url.isNotEmpty) {
                    String bilgiler = "$ad\n$verenOrganizasyon\n$yeterlilikKimligi\n$url";
                    widget.onAdd(bilgiler);
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Hata"),
                          content: const Text("Tüm alanları doldurun."),
                          actions: [
                            TextButton(
                              child: const Text("Tamam"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C4059),
                ),
                child: const Text("Ekle",
                  style: TextStyle(
                    color: Color(0xFFEF6C00), // Metin rengi
                  ),),

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
    _verenOrganizasyonController.dispose();
    _yeterlilikKimligiController.dispose();
    _turController.dispose();
    super.dispose();
  }
}
