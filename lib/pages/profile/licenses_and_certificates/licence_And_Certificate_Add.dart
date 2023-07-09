import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class LicenseAndCertificateAddPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const LicenseAndCertificateAddPage({Key? key, required this.onAdd}) : super(key: key);

  @override
  _LicenseAndCertificateAddPageState createState() => _LicenseAndCertificateAddPageState();
}

class _LicenseAndCertificateAddPageState extends State<LicenseAndCertificateAddPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'name': '',
    'organization': '',
    'issueDate': '',
    'expiryDate': '',
    'qualificationId': '',
    'qualificationUrl': '',
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAdd(_formData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lisans veya Sertifika Ekle'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
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
                  _formData['name'] = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kuruluş',
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
                    return 'Kuruluş alanı boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['organization'] = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
                  _formData['issueDate'] = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Son Kullanma Tarihi boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['expiryDate'] = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
                  if (value!.isEmpty) {
                    return 'Yetkilendirme ID boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['qualificationId'] = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
                  if (value!.isEmpty) {
                    return 'Yetkilendirme URL boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['qualificationUrl'] = value!;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstants.theme2Orange,
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
                    'Ekle',
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
