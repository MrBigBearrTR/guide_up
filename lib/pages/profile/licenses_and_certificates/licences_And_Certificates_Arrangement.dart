import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class LicensesAndCertificatesArrangementPage extends StatefulWidget {
  final Map<String, String> data;
  final Function(Map<String, String>) onUpdate;
  final VoidCallback onDelete;

  const LicensesAndCertificatesArrangementPage({
    Key? key,
    required this.data,
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
  final _formKey = GlobalKey<FormState>();
  late String _updatedName;
  late String _updatedOrganization;
  late String _updatedIssueDate;
  late String _updatedExpiryDate;
  late String _updatedQualificationId;
  late String _updatedQualificationUrl;

  @override
  void initState() {
    super.initState();
    _updatedName = widget.data['name'] ?? '';
    _updatedOrganization = widget.data['organization'] ?? '';
    _updatedIssueDate = widget.data['issueDate'] ?? '';
    _updatedExpiryDate = widget.data['expiryDate'] ?? '';
    _updatedQualificationId = widget.data['qualificationId'] ?? '';
    _updatedQualificationUrl = widget.data['qualificationUrl'] ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onUpdate({
        'name': _updatedName,
        'organization': _updatedOrganization,
        'issueDate': _updatedIssueDate,
        'expiryDate': _updatedExpiryDate,
        'qualificationId': _updatedQualificationId,
        'qualificationUrl': _updatedQualificationUrl,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lisans veya Sertifika Düzenleme'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.data['name'],
                decoration: InputDecoration(
                  labelText: 'Lisans veya Sertifika Adı',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lisans veya Sertifika Adı boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _updatedName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.data['organization'],
                decoration: InputDecoration(
                  labelText: 'Veren Organizasyon',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veren Organizasyon alanı boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _updatedOrganization = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.data['issueDate'],
                decoration: InputDecoration(
                  labelText: 'Veriliş Tarihi',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veriliş Tarihi boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _updatedIssueDate = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.data['expiryDate'],
                decoration: InputDecoration(
                  labelText: 'Son Kullanma Tarihi',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: null, // Zorunluluk kontrolünü devre dışı bırakır
                onSaved: (value) {
                  _updatedExpiryDate = value!;
                },
              ),

              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.data['qualificationId'],
                decoration: InputDecoration(
                  labelText: 'Yetkilendirme ID',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  return null; // Boş değer için hata mesajı döndürme
                },
                onSaved: (value) {
                  _updatedQualificationId = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.data['qualificationUrl'],
                decoration: InputDecoration(
                  labelText: 'Yetkilendirme URL',
                  labelStyle: GoogleFonts.nunito(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.theme1DarkBlue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  return null; // Boş değer için hata mesajı döndürme
                },
                onSaved: (value) {
                  _updatedQualificationUrl = value!;
                },
              ),

              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstants.itemWhite,
                  backgroundColor: ColorConstants.theme2DarkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Güncelle',
                    style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Silmek istediğinize emin misiniz?',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.onDelete();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Evet',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.warningDark,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Hayır',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.warningDark,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        backgroundColor: ColorConstants.theme1DarkBlue,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstants.itemWhite,
                  backgroundColor: ColorConstants.dangerDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Sil',
                    style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}