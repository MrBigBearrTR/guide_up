import 'package:flutter/material.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genel Ayarlar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Geri butonuna basıldığında yapılacak işlemler
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Genel Ayarlar',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
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
            labelText: 'Mevcut Şifre Gir',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Yeni Şifre Gir',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Şifremi Unuttum butonuna basıldığında yapılacak işlemler
            },
            child: const Text('Şifremi Unuttum'),
          ),
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
          items: <String>['Türkçe', 'Almanca', 'Diğer']
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
            border: OutlineInputBorder(),
          ),
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
          value: false, // Tema ayarının başlangıç durumu
          onChanged: (bool newValue) {
            // Tema ayarı değiştirildiğinde yapılacak işlemler
          },
        ),
      ],
    );
  }
}
