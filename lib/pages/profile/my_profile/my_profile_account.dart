import 'package:flutter/material.dart';
import 'package:guide_up/core/enumeration/enums/EnLinkType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLinkType.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/service/user/user_detail/user_detail_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/constant/router_constants.dart';
import '../../../core/models/users/user_detail/user_detail_model.dart';
import '../../../core/models/users/user_detail/user_links_model.dart';
import '../../../core/models/users/user_model.dart';
import '../../../core/utils/control_helper.dart';
import '../../../core/utils/secure_storage_helper.dart';
import '../../../repository/user/user_detail/user_links_repository.dart';
import '../../../repository/user/user_repository.dart';
import '../../../ui/material/custom_material.dart';
import '../licenses_and_certificates/licenses_And_Certificates.dart';

class MyProfileAccount extends StatefulWidget {
  const MyProfileAccount({Key? key}) : super(key: key);

  @override
  State<MyProfileAccount> createState() => _MyProfileAccountState();
}

class _MyProfileAccountState extends State<MyProfileAccount> {
  UserDetail? userDetail;
  UserModel? userModel;
  List<UserLinks> userLinks = [];
  String profileImagePath = "";
  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat('dd.MM.yyyy');
  List<Map<String, String>> otherLinks = [];
  List<String> educationInfo = [];
  List<String> experienceInfo = [];
  List<String> projectInfo = [];
  List<String> skillsInfo = [];

  final _aboutController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  late final _birthdayController;

  @override
  void initState() {
    super.initState();
    _birthdayController = TextEditingController(
      text: dateFormat.format(selectedDate),
    );

    getUserModels();
  }

  void getUserModels() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      userDetail = detail;
      UserModel? model =
          await UserRepository().getUserByUserId(detail.getUserId()!);
      if (model == null) {
        userModel = null;
      } else {
        List<UserLinks> links = await UserLinksRepository()
            .getUserLinksByUserId(detail.getUserId()!);
        setState(() {
          userLinks = links;
          userModel = model;
          setValues();
        });
      }
    }
  }

  Future<void> pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 500, maxHeight: 500);
    if (pickedImage != null) {
      profileImagePath = pickedImage.path;
      userDetail = await UserDetailService()
          .updateUserPhotoByPathAndUserDetail(profileImagePath, userDetail!);
      setState(() {});
    }
    setState(() {});
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
        _birthdayController.text = dateFormat.format(selectedDate);
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
                  labelStyle: TextStyle(color: ColorConstants.theme2Orange),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
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
                  labelStyle: TextStyle(color: ColorConstants.theme2Orange),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  link = value;
                },
              ),
            ],
          ),
          backgroundColor: ColorConstants.theme2DarkBlue,
          // Arka plan rengi olarak kullanıldı

          actions: [
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && link.isNotEmpty) {
                  UserLinks links = UserLinks();
                  links.setLink(link);
                  links.setEnLinkType(EnLinkType.personelPage);
                  if (userDetail != null) {
                    links.setUserId(userDetail!.getUserId()!);
                  }
                  UserLinksRepository().add(links);
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.theme2DarkBlue),
              child: const Text(
                "Tamam",
                style:
                    TextStyle(color: ColorConstants.theme2Orange // Metin rengi
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
    return Scaffold(
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Padding(
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
                          backgroundColor: ColorConstants.theme2Orange,
                          // Arka plan rengi
                          backgroundImage:
                              UserInfoHelper.getProfilePicture(userDetail),
                          child: UserInfoHelper.isProfileNotEmpty(userDetail)
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hakkımda',
                      labelStyle: TextStyle(
                        color: (_aboutController.value.text.isNotEmpty)
                            ? const Color(0xFF07617C)
                            : const Color(0xFFFF8800),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_aboutController.value.text.isNotEmpty)
                              ? const Color(0xFF07617C)
                              : const Color(0xFFFF8800),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _aboutController,
                    cursorColor: const Color(0xFF07617C),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'İsim',
                      labelStyle: TextStyle(
                        color: (_nameController.value.text.isNotEmpty)
                            ? const Color(0xFFFF8800)
                            : const Color(0xFF07617C),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_nameController.value.text.isNotEmpty)
                              ? const Color(0xFFFF8800)
                              : const Color(0xFF07617C),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: const Color(0xFF07617C),
                    controller: _nameController,
                    onChanged: (value) {
                      setState(() {});
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
                        color: (_lastnameController.value.text.isNotEmpty)
                            ? const Color(0xFF07617C)
                            : const Color(0xFFFF8800),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_lastnameController.value.text.isNotEmpty)
                              ? const Color(0xFF07617C)
                              : const Color(0xFFFF8800),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: const Color(0xFF07617C),
                    controller: _lastnameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      labelStyle: TextStyle(
                        color: (_usernameController.value.text.isNotEmpty)
                            ? const Color(0xFF07617C)
                            : const Color(0xFFFF8800),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_usernameController.value.text.isNotEmpty)
                              ? const Color(0xFFFF8800)
                              : const Color(0xFF07617C),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: const Color(0xFF07617C),
                    controller: _usernameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Doğum Tarihi',
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
                    controller: _birthdayController,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      labelStyle: TextStyle(
                        color: (_emailController.value.text.isNotEmpty)
                            ? const Color(0xFF07617C)
                            : const Color(0xFFFF8800),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_emailController.value.text.isNotEmpty)
                              ? const Color(0xFF07617C)
                              : const Color(0xFFFF8800),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: const Color(0xFF07617C),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Veriler alınırken bir hata oluştu.'),
                        );
                      } else {
                        return SizedBox(
                          height: (snapshot.data!.length) * 85,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final link = snapshot.data![index];
                              return ListTile(
                                title: Text(link.getLink()!),
                                subtitle: Text(
                                    link.getEnLinkType()!.getDisplayName()),
                                leading: const Icon(Icons.link),
                              );
                            },
                            itemCount: snapshot.data!.length,
                            padding: const EdgeInsets.all(0),
                          ),
                        );
                      }
                    },
                    future: UserLinksRepository().getUserLinksByUserId(
                        userDetail != null ? (userDetail!.getUserId()!) : "1"),
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
                  Container(
                    width: 430,
                    height: 60,
                    color: const Color(0xFFEEEEEE),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Eğitim Bilgileri",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouterConstants.educationInformation);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Kalem butonuna tıklandığında yapılacak işlemler
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0.0),
                  Container(
                    width: 430,
                    height: 60,
                    color: const Color(0xFFEEEEEE),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Projelerim",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouterConstants.myProjects);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Kalem butonuna tıklandığında yapılacak işlemler
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0.0),
                  Container(
                    width: 430,
                    height: 60,
                    color: const Color(0xFFEEEEEE),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Yetenekler",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouterConstants.abilities);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Kalem butonuna tıklandığında yapılacak işlemler
                          },
                        ),
                      ],
                    ),
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
                            color: const Color(0xFFFE5722),
                            // İstediğiniz kenar çizgisi rengi
                            width: 2.0, // İstediğiniz kenar çizgisi kalınlığı
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LicensesAndCertificatesPage()),
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
                    foregroundColor: const Color(0xFFEF6C00),
                    backgroundColor: const Color(0xFF2C4059),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFFEF6C00),
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
                        'assets/logo/guideUpLogo.png',
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
      ),
    );
  }

  void setValues() {
    _aboutController.text =
        ControlHelper.checkInputValue(userDetail!.getAbout());
    _nameController.text = ControlHelper.checkInputValue(userDetail!.getName());
    _lastnameController.text =
        ControlHelper.checkInputValue(userDetail!.getSurname());
    _emailController.text =
        ControlHelper.checkInputValue(userModel!.getEmail());
    _usernameController.text =
        ControlHelper.checkInputValue(userModel!.getUsername());
    if (userDetail!.getBirthday() != null) {
      selectedDate = userDetail!.getBirthday()!;
      _birthdayController.text = ControlHelper.checkInputValue(
          dateFormat.format(userDetail!.getBirthday()!));
    }
  }
}
