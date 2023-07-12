import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/constant/router_constants.dart';
import '../../../ui/material/custom_material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Varsayılan olarak açık tema
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Koyu tema ayarı
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const GeneralSettings(),
    );
  }
}

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool _isPasswordChanged = false;
  bool _isDarkThemeEnabled = false; // Koyu tema durumu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Genel Ayarlar',
          style: GoogleFonts.nunito(
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
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
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              _buildPasswordSection(),
              const SizedBox(height: 16.0),
              _buildLanguageSection(),
              const SizedBox(height: 16.0),
              _buildPhoneNumberSection(),
              const SizedBox(height: 16.0),
              _buildThemeSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Şifre Yenile',
          style: GoogleFonts.nunito(
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Mevcut şifre',
            floatingLabelStyle: GoogleFonts.nunito(
              color: ColorConstants.appcolor3, // Metin rengi
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.theme1CloudBlue), // Kutunun çevresi rengi
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.appcolor3), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: const Icon(
              Icons.lock_outlined,
              color: ColorConstants.theme1BrightCloudBlue, // Icon rengi
            ),
            filled: true,
            fillColor: ColorConstants.theme1CloudBlue, // Kutunun iç dolgu rengi
            labelStyle: GoogleFonts.nunito(
              color: ColorConstants.itemWhite, // Metin rengi
            ),
          ),
          cursorColor: ColorConstants.theme2White, // İmleç rengi
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Yeni şifre',
            floatingLabelStyle: GoogleFonts.nunito(
              color: ColorConstants.appcolor3, // Metin rengi
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.theme1CloudBlue), // Kutunun çevresi rengi
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.appcolor3), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: const Icon(
              Icons.lock,
              color: ColorConstants.theme1BrightCloudBlue, // Icon rengi
            ),
            filled: true,
            fillColor: ColorConstants.theme1CloudBlue, // Kutunun iç dolgu rengi
            labelStyle: GoogleFonts.nunito(
              color: ColorConstants.itemWhite, // Metin rengi
            ),
          ),
          cursorColor: ColorConstants.theme2White, // İmleç rengi
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Şifreyi tekrar yaz',
            floatingLabelStyle: GoogleFonts.nunito(
              color: ColorConstants.appcolor3, // Metin rengi
    ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.theme1CloudBlue), // Kutunun çevresi rengi
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.appcolor3), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: const Icon(
              Icons.lock_outlined,
              color: ColorConstants.theme1BrightCloudBlue, // Icon rengi
            ),
            filled: true,
            fillColor: ColorConstants.theme1CloudBlue, // Kutunun iç dolgu rengi
            labelStyle: GoogleFonts.nunito(
              color: ColorConstants.itemWhite, // Metin rengi
            ),
          ),
          cursorColor: ColorConstants.theme2White, // İmleç rengi
        ),
        const SizedBox(height: 1.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                // Şifremi Unuttum butonuna basıldığında yapılacak işlemler
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.theme1DarkBlue), // Buton metin rengi
              ),
              child: Text('Şifremi Unuttum',
                style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, RouterConstants.mentorGuideUpRevenuePage);
                setState(() {
                  _isPasswordChanged = true;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.theme2Orange), // Buton arkaplan rengi
                foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.itemWhite), // Buton yazı rengi
              ),
              child: Text('Şifreyi Yenile',
                style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
            ),

          ],
        ),
        const SizedBox(height: 8.0),
        if (_isPasswordChanged)
          Text(
            'Şifre değiştirme başarılı!',
            style: GoogleFonts.nunito(
                color: ColorConstants.success),
          ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dil Değiştir',
          style: GoogleFonts.nunito(
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButton<String>(
          value: 'Türkçe', // Varsayılan dil seçeneği
          onChanged: (String? newValue) {
            // Dil seçildiğinde yapılacak işlemler
          },
          items: <String>['Türkçe', 'İngilizce']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Telefon Numarası',
          style: GoogleFonts.nunito(
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Telefon Numarası Gir',
            floatingLabelStyle: GoogleFonts.nunito(
              color: ColorConstants.appcolor3, // Metin rengi
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.theme1CloudBlue), // Kutunun çevresi rengi
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.appcolor3), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: const Icon(
              Icons.phone,
              color: ColorConstants.theme1BrightCloudBlue, // Icon rengi
            ),
            filled: true,
            fillColor: ColorConstants.theme1CloudBlue, // Kutunun iç dolgu rengi
            labelStyle: GoogleFonts.nunito(
              color: ColorConstants.itemWhite, // Metin rengi
            ),
          ),
          cursorColor: ColorConstants.theme2White, // İmleç rengi
        ),


      ],
    );
  }

  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tema Ayarları',
          style: GoogleFonts.nunito(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        SwitchListTile(
          title: Text('Koyu Tema',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          value: _isDarkThemeEnabled,
          onChanged: (bool newValue) {
            setState(() {
              _isDarkThemeEnabled = newValue;
            });
          },
          secondary: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconTheme(
              data: IconThemeData(
                color: _isDarkThemeEnabled ? ColorConstants.theme1DarkBlue : ColorConstants.theme1CloudBlue, // Icon rengi
              ),
              child: const Icon(Icons.brightness_4),
            ),
          ),
          activeColor: ColorConstants.theme2Orange, // Koyu tema etkinleştirildiğindeki renk
          activeTrackColor: ColorConstants.theme1DarkBlue, // Koyu tema etkinleştirildiğindeki renk
          inactiveThumbColor: ColorConstants.theme2Orange, // Koyu tema devre dışı bırakıldığında başlığın rengi
          inactiveTrackColor: ColorConstants.theme1CloudBlue, // Koyu tema devre dışı bırakıldığında iz sürücü rengi
        ),

      ],
    );
  }
}
