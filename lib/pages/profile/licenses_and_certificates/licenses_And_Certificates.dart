import 'package:flutter/material.dart';
import ' license_And_Certificate_Add.dart';
import ' licenses_And_Certificates_Arrangement.dart';
import '../../../ui/material/custom_material.dart';

class LicensesAndCertificatesPage extends StatefulWidget {
  const LicensesAndCertificatesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LicensesAndCertificatesPageState createState() =>
      _LicensesAndCertificatesPageState();
}

class _LicensesAndCertificatesPageState
    extends State<LicensesAndCertificatesPage> {
  List<String> licensesAndCertificatesList = []; // Sertifikalar ve lisanslar listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lisanslar ve Sertifikalar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LicenseAndCertificateAddPage(
                    onAdd: (String url) {
                      setState(() {
                        licensesAndCertificatesList.add(url);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: licensesAndCertificatesList.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Image.asset(
                  'assets/logo/guideUpLogo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LicenseAndCertificateAddPage(
                            onAdd: (String url) {
                              setState(() {
                                licensesAndCertificatesList.add(url);
                              });
                            },
                          ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 0),
                  child: const Text(
                    "Lisans veya Sertifika Ekleyin",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0E90EC),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: licensesAndCertificatesList.length,
          itemBuilder: (context, index) {
            final url = licensesAndCertificatesList[index];

            return ListTile(
              title: Text(url),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LicensesAndCertificatesArrangementPage(
                                url: url,
                                onUpdate: (String updatedUrl) {
                                  setState(() {
                                    licensesAndCertificatesList[index] =
                                        updatedUrl;
                                  });
                                },
                                onDelete: () {
                                  setState(() {
                                    licensesAndCertificatesList
                                        .removeAt(index);
                                  });
                                },
                              ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                "Silmek istediğinize emin misiniz?"),
                            actions: [
                              TextButton(
                                child: const Text("Evet"),
                                onPressed: () {
                                  setState(() {
                                    licensesAndCertificatesList
                                        .removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Hayır"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
