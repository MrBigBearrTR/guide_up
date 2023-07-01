import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Varsayılan olarak açık tema
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Koyu tema ayarı
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
        title: const Text(
          'Genel Ayarlar',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
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
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Şifre Yenile',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Mevcut şifre',
            floatingLabelStyle: TextStyle(
              color: Color(0xFF212832), // Metin rengi
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF98C2D0)), // Kutunun çevresi rengi
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF212832)), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Color(0xFFDAE4EC), // Icon rengi
            ),
            filled: true,
            fillColor: Color(0xFF98C2D0), // Kutunun iç dolgu rengi
            labelStyle: TextStyle(
              color: Color(0xFFFFFFFF), // Metin rengi
            ),
          ),
          cursorColor: Color(0xFFEEEEEE), // İmleç rengi
        ),
        const SizedBox(height: 8.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Yeni şifre',
            floatingLabelStyle: TextStyle(
              color: Color(0xFF212832), // Metin rengi
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF98C2D0)), // Kutunun çevresi rengi
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF212832)), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xFFDAE4EC), // Icon rengi
            ),
            filled: true,
            fillColor: Color(0xFF98C2D0), // Kutunun iç dolgu rengi
            labelStyle: TextStyle(
              color: Color(0xFFFFFFFF), // Metin rengi
            ),
          ),
          cursorColor: Color(0xFFEEEEEE), // İmleç rengi
        ),
        const SizedBox(height: 8.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Şifreyi tekrar yaz',
            floatingLabelStyle: TextStyle(
              color: Color(0xFF212832), // Metin rengi
    ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF98C2D0)), // Kutunun çevresi rengi
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF212832)), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Color(0xFFDAE4EC), // Icon rengi
            ),
            filled: true,
            fillColor: Color(0xFF98C2D0), // Kutunun iç dolgu rengi
            labelStyle: TextStyle(
              color: Color(0xFFFFFFFF), // Metin rengi
            ),
          ),
          cursorColor: Color(0xFFEEEEEE), // İmleç rengi
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
                foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF07617C)), // Buton metin rengi
              ),
              child: const Text('Şifremi Unuttum'),
            ),
            ElevatedButton(
              onPressed: () {
                // Şifreyi değiştirmeyi onayla butonuna basıldığında yapılacak işlemler
                setState(() {
                  _isPasswordChanged = true;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFE5722)), // Buton arkaplan rengi
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Buton yazı rengi
              ),
              child: const Text('Şifreyi Yenile'),
            ),

          ],
        ),
        const SizedBox(height: 8.0),
        if (_isPasswordChanged)
          const Text(
            'Şifre değiştirme başarılı!',
            style: TextStyle(color: Colors.green),
          ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dil Değiştir',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Telefon Numarası',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Telefon Numarası Gir',
            floatingLabelStyle: TextStyle(
              color: Color(0xFF212832), // Metin rengi
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF98C2D0)), // Kutunun çevresi rengi
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF212832)), // Odaklandığında kutunun çevresi rengi
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: Color(0xFFDAE4EC), // Icon rengi
            ),
            filled: true,
            fillColor: Color(0xFF98C2D0), // Kutunun iç dolgu rengi
            labelStyle: TextStyle(
              color: Color(0xFFFFFFFF), // Metin rengi
            ),
          ),
          cursorColor: Color(0xFFEEEEEE), // İmleç rengi
        ),


      ],
    );
  }

  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tema Ayarları',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        SwitchListTile(
          title: const Text('Koyu Tema'),
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
                color: _isDarkThemeEnabled ? const Color(0xFF07617C) : const Color(0xFF98C2D0), // Icon rengi
              ),
              child: const Icon(Icons.brightness_4),
            ),
          ),
          activeColor: const Color(0xFFFE5722), // Koyu tema etkinleştirildiğindeki renk
          activeTrackColor: const Color(0xFF07617C), // Koyu tema etkinleştirildiğindeki renk
          inactiveThumbColor: const Color(0xFFFE5722), // Koyu tema devre dışı bırakıldığında başlığın rengi
          inactiveTrackColor: const Color(0xFF98C2D0), // Koyu tema devre dışı bırakıldığında iz sürücü rengi
        ),

      ],
    );
  }
}
