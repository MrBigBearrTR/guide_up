import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../core/constant/color_constants.dart';
import '../../core/constant/router_constants.dart';
import '../../core/models/users/user_detail/user_detail_model.dart';
import '../../core/models/users/user_detail/user_links_model.dart';
import '../../core/models/users/user_model.dart';
import '../../core/utils/secure_storage_helper.dart';
import '../../pages/profile/licenses_and_certificates/licenses_And_Certificates.dart';
import '../../repository/user/user_detail/user_links_repository.dart';
import '../../repository/user/user_repository.dart';
import 'kayan_Appbar_Deneme.dart';



class MeProfileAccount extends StatefulWidget {
  const MeProfileAccount({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MeProfileAccountState createState() => _MeProfileAccountState();
}


class _MeProfileAccountState extends State<MeProfileAccount> {
  UserDetail? userDetail;
  UserModel? userModel;
  List<UserLinks> userLinks =[];
   String profileImagePath = "";
   DateTime selectedDate = DateTime.now();
  // String _email = "";
  // String linkedinLink = "";
  // String githubLink = "";
  // String mediumLink = "";
  // String websiteLink = "";
  // String socialMediaLink = "";
  List<Map<String, String>> otherLinks = [];
  List<String> educationInfo = [];
  List<String> experienceInfo = [];
  List<String> projectInfo = [];
  List<String> skillsInfo = [];
  @override
  void initState() {
    super.initState();
    getUserModels();
  }

  void getUserModels() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      userDetail = detail;
      UserModel? model = await UserRepository().getUserByUserId(detail.getUserId()!);
      if (model == null) {
        userModel = null;
      } else {
        List<UserLinks> links = await UserLinksRepository().getUserLinksByUserId(detail.getUserId()!);
        setState(() {
          userLinks = links;
          userModel = model;
        });
      }
    }
  }



  Future<void> pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
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
              color: ColorConstants.theme2Orange,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange),
                  ),
                  labelText: "Başlık",
                  labelStyle: TextStyle(
                      color: ColorConstants.theme2Orange
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange),
                  ),
                  labelText: "Link",
                  labelStyle: TextStyle(
                      color: ColorConstants.theme2Orange
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  link = value;
                },
              ),
            ],
          ),
          backgroundColor: ColorConstants.theme2DarkBlue, // Arka plan rengi olarak kullanıldı

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
                backgroundColor: ColorConstants.theme2DarkBlue
              ),
              child: const Text(
                "Tamam",
                style: TextStyle(
                    color: ColorConstants.theme2Orange // Metin rengi
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
                      color: Color(0xFF2C394C),
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
                      backgroundColor: ColorConstants.theme2Orange, // Arka plan rengi
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
                        'İsim:${userDetail != null ? (" ${userDetail!.getName()!} ") : ""}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Soyisim:${userDetail != null ? (" ${userDetail!.getSurname()!} ") : ""}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Kullanıcı ID:${userDetail != null ? (" ${userDetail!.getUserId()!} ") : ""}',
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
                    labelText: 'Hakkımda${userDetail != null ? (" ${userDetail!.getAbout()!} ") : ""}',
                    labelStyle: TextStyle(
                    color: (userDetail != null && userDetail!.getAbout()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                  ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (userDetail != null && userDetail!.getAbout()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userDetail?.setAbout(value);
                    });
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: (userDetail != null && userDetail!.getName()?.isNotEmpty == true) ? '' : 'İsim',                    labelStyle: TextStyle(
                      color: (userDetail != null && userDetail!.getName()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (userDetail != null && userDetail!.getName()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userDetail?.setName(value);
                    });
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: (userDetail != null && userDetail!.getSurname()?.isNotEmpty == true) ? '' : 'Soyisim',
                    labelStyle: TextStyle(
                      color: (userDetail != null && userDetail!.getSurname()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (userDetail != null && userDetail!.getSurname()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userDetail?.setSurname(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: (userDetail != null && userDetail!.getUserId()?.isNotEmpty == true) ? '' : 'Kullanıcı ID',
                    labelStyle: TextStyle(
                      color: (userDetail != null && userDetail!.getUserId()?.isNotEmpty == true) ? const Color(0xFFFF8800) : const Color(0xFF07617C),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (userDetail != null && userDetail!.getUserId()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userDetail?.setUserId(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: (userDetail != null && userDetail!.getBirthday() != null)
                        ? 'Doğum Tarihi ${userDetail!.getBirthday()}'
                        : 'Doğum Tarihi',
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
                    // ignore: unnecessary_null_comparison
                    text: selectedDate != null ? dateFormat.format(selectedDate) : '',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: (userModel != null && userModel!.getEmail()?.isNotEmpty == true) ? '' : 'E-posta',
                    labelStyle: TextStyle(
                      color: (userModel != null && userModel!.getEmail()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (userModel != null && userModel!.getEmail()?.isNotEmpty == true) ? const Color(0xFF07617C) : const Color(0xFFFF8800),
                      ),
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  cursorColor: const Color(0xFF07617C),
                  onChanged: (value) {
                    setState(() {
                      userModel?.setEmail(value);
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
                            MaterialPageRoute(builder: (context) => const LicensesAndCertificatesPage()),
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
                    Navigator.pushNamed(context, RouterConstants.profilePage);
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFEF6C00),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 0,
              child: Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF80000),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KayanAppbarDenemePage(),
                      ),
                    );},
                  child: const Icon(
                    Icons.ad_units,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 7,
                  right: -15,
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/img/GuideUpLogo.png',
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

