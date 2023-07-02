import 'package:flutter/material.dart';

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
        title: const Text("Lisans ve Sertifika Düzenle"),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "URL:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String updatedUrl = _urlController.text.trim();
                      widget.onUpdate(updatedUrl);
                      Navigator.pop(context);
                    },
                    child: const Text("Güncelle"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Silmek istediğinize emin misiniz?"),
                            actions: [
                              TextButton(
                                child: const Text("Evet"),
                                onPressed: () {
                                  widget.onDelete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text("Hayır"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Sil"),
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
