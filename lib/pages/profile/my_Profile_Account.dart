import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../core/constant/router_constants.dart';
import '../../pages/profile/licenses_and_certificates/licenses_And_Certificates.dart';


class MeProfileAccount extends StatefulWidget {
  const MeProfileAccount({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MeProfileAccountState createState() => _MeProfileAccountState();
}


class _MeProfileAccountState extends State<MeProfileAccount> {
  //late User _userModel;
  //late UserDetail _userDetailModel;
  //late UserLinks _userLinks;
  String _username = "";
  String surname = "";
  String profileImagePath = "";
  String aboutMe = "";
  String userID = "";
  DateTime selectedDate = DateTime.now();
  String _email = "";
  String linkedinLink = "";
  String githubLink = "";
  String mediumLink = "";
  String websiteLink = "";
  String socialMediaLink = "";
  List<Map<String, String>> otherLinks = [];
  List<String> educationInfo = [];
  List<String> experienceInfo = [];
  List<String> projectInfo = [];
  List<String> skillsInfo = [];
  // void initState() {
  //   super.initState();
  //   _userModel = User();
  //   _userDetailModel = UserDetail();
  //   _userLinks = UserLinks();
  // }

  Future pickProfileImage() async {
    final imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        profileImagePath = pickedImage.path;
      }
    });
  }

  Future<void> showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void addOtherLink() {
    String title = "";
    String link = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "+ Link Ekle",
            style: TextStyle(
              color: Color(0xFFEF6C00),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEF6C00)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEF6C00)),
                  ),
                  labelText: "Başlık",
                  labelStyle: TextStyle(
                    color: Color(0xFFEF6C00),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEF6C00)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEF6C00)),
                  ),
                  labelText: "Link",
                  labelStyle: TextStyle(
                    color: Color(0xFFEF6C00),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  link = value;
                },
              ),
            ],
          ),
          backgroundColor: const Color(0xFF2C4059), // Arka plan rengi olarak kullanıldı

          actions: [
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && link.isNotEmpty) {
                  setState(() {
                    otherLinks.add({
                      'title': title,
                      'link': link,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C4059),
              ),
              child: const Text(
                "Tamam",
                style: TextStyle(
                  color: Color(0xFFEF6C00), // Metin rengi
                ),
              ),
            ),

          ],
        );
      },
    );
  }

  void removeOtherLink(int index) {
    setState(() {
      otherLinks.removeAt(index);
    });
  }

  void saveProfile() {
    // Profil bilgilerini kaydetmek için yapılacak işlemler
    if (kDebugMode) {
      print('Profil bilgileri kaydedildi.');
    }
    if (kDebugMode) {
      print('İsim: $_username');
    }
    if (kDebugMode) {
      print('Soyisim: $surname');
    }
    if (kDebugMode) {
      print('Hakkımda: $aboutMe');
    }
    if (kDebugMode) {
      print('Doğum Tarihi: $selectedDate');
    }
    if (kDebugMode) {
      print('E-posta: $_email');
    }
    if (kDebugMode) {
      print('LinkedIn Linki: $linkedinLink');
    }
    if (kDebugMode) {
      print('GitHub Linki: $githubLink');
    }
    if (kDebugMode) {
      print('Medium Linki: $mediumLink');
    }
    if (kDebugMode) {
      print('Website Linki: $websiteLink');
    }
    if (kDebugMode) {
      print('Sosyal Medya Linki: $socialMediaLink');
    }
    if (kDebugMode) {
      print('Diğer Linkler:');
    }
    for (var link in otherLinks) {
      if (kDebugMode) {
        print('- Başlık: ${link['title']}, Link: ${link['link']}');
      }
    }
    if (kDebugMode) {
      print('Eğitim Bilgileri:');
    }
    for (var info in educationInfo) {
      if (kDebugMode) {
        print('- $info');
      }
    }
    if (kDebugMode) {
      print('Tecrübe ve Deneyimler:');
    }
    for (var info in experienceInfo) {
      if (kDebugMode) {
        print('- $info');
      }
    }
    if (kDebugMode) {
      print('Projeler:');
    }
    for (var info in projectInfo) {
      if (kDebugMode) {
        print('- $info');
      }
    }
    if (kDebugMode) {
      print('Yetenekler:');
    }
    for (var info in skillsInfo) {
      if (kDebugMode) {
        print('- $info');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(

          children: [
            ListView(
              children: [
                const Center(
                  child: Text(
                    "Profilim",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: pickProfileImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: const Color(0xFFEF6C00), // Arka plan rengi
                        backgroundImage: profileImagePath.isNotEmpty
                            ? FileImage(File(profileImagePath))
                            : null,
                        child: profileImagePath.isNotEmpty
                            ? null
                            : const Icon(
                          Icons.person,
                          size: 60.0,
                          color: Color(0xFF2C4059), // Siluet rengi
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, -0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        "İsim: $_username",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Soyisim: $surname",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Kullanıcı ID: $userID",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hakkımda',
                    labelStyle: TextStyle(
                      color: aboutMe.isNotEmpty ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: aboutMe.isNotEmpty ? const Color(0xFFFF8800) : const Color(0xFF07617C),),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      aboutMe = value;
                    });
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'isim',
                    labelStyle: TextStyle(
                      color: _username.isNotEmpty ? const Color(0xFFFF8800) : const Color(0xFF07617C),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _username.isNotEmpty ? const Color(0xFF07617C) : const Color(0xFFFF8800),),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Soyisim',
                    labelStyle: TextStyle(
                      color: surname.isNotEmpty ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: surname.isNotEmpty ? const Color(0xFFFF8800) : const Color(0xFF07617C),),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      surname = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı ID',
                    labelStyle: TextStyle(
                      color: userID.isNotEmpty ? const Color(0xFFFF8800) : const Color(0xFF07617C),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: userID.isNotEmpty ? const Color(0xFF07617C) : const Color(0xFFFF8800),),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userID = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Doğum Tarihi",
                    labelStyle: const TextStyle(
                      color: Color(0xFFFF8800),
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: showDatePickerDialog,
                      color: const Color(0xFF07617C),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: dateFormat.format(selectedDate),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    labelStyle: TextStyle(
                      color: _email.isNotEmpty ? const Color(0xFFFF8800) : const Color(0xFF07617C),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _email.isNotEmpty ? const Color(0xFF07617C) : const Color(0xFFFF8800),),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "LinkedIn Linki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'link',
                        labelStyle: const TextStyle(
                          color: Color(0xFFFF8800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF07617C),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "GitHub Linki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'link',
                        labelStyle: const TextStyle(
                          color: Color(0xFF07617C),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFF8800),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Medium Linki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'link',
                        labelStyle: const TextStyle(
                          color: Color(0xFFFF8800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF07617C),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Website Linki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'link',
                        labelStyle: const TextStyle(
                          color: Color(0xFF07617C),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFF8800),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sosyal Medya Linki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'link',
                        labelStyle: const TextStyle(
                          color: Color(0xFF07617C),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFF8800),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0.0),
                    TextButton(
                      onPressed: addOtherLink,
                      child: const Text(
                        "+ Link Ekle",
                        style: TextStyle(
                          color: Color(0xFFEF6C00),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    Column(
                      children: otherLinks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final link = entry.value;

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF2C4059),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                link['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(link['link']!),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      removeOtherLink(index);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF2C4059),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 0.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Eğitim Bilgileri",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'bilgi',
                        labelStyle: const TextStyle(
                          color: Color(0xFFFF8800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF07617C),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                        educationInfo = value.split("\n");
                      },
                      maxLines: null,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tecrübelerim  ve Deneyimlerim",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'bilgi',
                        labelStyle: const TextStyle(
                          color: Color(0xFF07617C),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFF8800),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                        experienceInfo = value.split("\n");
                      },
                      maxLines: null,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Projelerim",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'bilgi',
                        labelStyle: const TextStyle(
                          color: Color(0xFFFF8800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF07617C),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                        projectInfo = value.split("\n");
                      },
                      maxLines: null,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Yetenekler",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'bilgi',
                        labelStyle: const TextStyle(
                          color: Color(0xFF07617C),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFF8800),),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF07617C),
                      onChanged: (value) {
                        skillsInfo = value.split("\n");
                      },
                      maxLines: null,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lisanslar ve sertifikalar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C4059), // İstediğiniz renk
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFFE5722), // İstediğiniz kenar çizgisi rengi
                          width: 2.0, // İstediğiniz kenar çizgisi kalınlığı
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LicensesAndCertificatesPage()),
                          );
                        },
                        child: const Text(
                          'Lisans ve sertifika ekle  ',
                          style: TextStyle(
                            color: Color(0xFFFE5722),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50.0),


              ],
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF6C00), backgroundColor: const Color(0xFF2C4059),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Kaydet"),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              child: Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2C4059),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouterConstants.profilePage);
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFEF6C00),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

