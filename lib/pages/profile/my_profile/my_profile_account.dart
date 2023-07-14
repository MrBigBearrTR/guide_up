import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/enumeration/enums/EnLinkType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLinkType.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/service/user/user_detail/user_detail_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
  final _phoneController = TextEditingController();

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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.theme1DarkBlue,
            ),
            dialogBackgroundColor: ColorConstants.itemWhite,
          ),
          child: child ?? const Text(""),
        );
      },
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
          title: Text(
            "+ Link Ekle",
            style: GoogleFonts.nunito(
              color: ColorConstants.buttonPurple,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.buttonPurple),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.buttonPurple),
                  ),
                  labelText: "Başlık",
                  labelStyle:
                      GoogleFonts.nunito(color: ColorConstants.buttonPurple),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.buttonPurple),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.buttonPurple),
                  ),
                  labelText: "Link",
                  labelStyle:
                      GoogleFonts.nunito(color: ColorConstants.buttonPurple),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  link = value;
                },
              ),
            ],
          ),
          backgroundColor: ColorConstants.background,
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
                  backgroundColor: ColorConstants.background),
              child: Text(
                "Tamam",
                style: GoogleFonts.nunito(
                    color: ColorConstants.buttonPurple // Metin rengi
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
                  Center(
                    child: Text(
                      "Profilim",
                      style: GoogleFonts.nunito(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.appcolor2,
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
                          backgroundColor: ColorConstants.buttonPurple,
                          // Arka plan rengi
                          backgroundImage:
                              UserInfoHelper.getProfilePicture(userDetail),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hakkımda',
                      labelStyle: GoogleFonts.nunito(
                        color: (_aboutController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_aboutController.value.text.isNotEmpty)
                              ? ColorConstants.theme1DarkBlue
                              : ColorConstants.warningDark,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _aboutController,
                    cursorColor: ColorConstants.theme1DarkBlue,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'İsim',
                      labelStyle: GoogleFonts.nunito(
                        color: (_nameController.value.text.isNotEmpty)
                            ? ColorConstants.warningDark
                            : ColorConstants.theme1DarkBlue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_nameController.value.text.isNotEmpty)
                              ? ColorConstants.warningDark
                              : ColorConstants.theme1DarkBlue,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: ColorConstants.theme1DarkBlue,
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
                      labelStyle: GoogleFonts.nunito(
                        color: (_lastnameController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_lastnameController.value.text.isNotEmpty)
                              ? ColorConstants.theme1DarkBlue
                              : ColorConstants.warningDark,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: ColorConstants.theme1DarkBlue,
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
                      labelStyle: GoogleFonts.nunito(
                        color: (_usernameController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_usernameController.value.text.isNotEmpty)
                              ? ColorConstants.warningDark
                              : ColorConstants.theme1DarkBlue,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: ColorConstants.theme1DarkBlue,
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
                      labelStyle: GoogleFonts.nunito(
                        color: ColorConstants.warningDark,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: showDatePickerDialog,
                        color: ColorConstants.theme1DarkBlue,
                      ),
                    ),
                    readOnly: true,
                    controller: _birthdayController,
                  ),
                  const SizedBox(height: 16.0),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Telefon Numarası',  // Telefon numarası alanının etiketi
                      labelStyle: GoogleFonts.nunito(
                        color: (_phoneController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),  // Kenarlık şeklini ayarla
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_phoneController.value.text.isNotEmpty)
                              ? ColorConstants.theme1DarkBlue
                              : ColorConstants.warningDark,
                        ),
                        borderRadius: BorderRadius.circular(8.0),  // Fokuslanmış kenarlık şeklini ayarla
                      ),
                    ),
                    controller: _phoneController,  // Telefon numarası değerini tutmak için bir controller atanır
                    initialCountryCode: 'TR',  // İlk açıldığında görünecek ülke kodu
                    onChanged: (phone) {
                      setState(() {
                        _phoneController.text = phone.completeNumber;  // Telefon numarası değiştiğinde controller'ı güncelle
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'E-posta',
                      labelStyle: GoogleFonts.nunito(
                        color: (_emailController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_emailController.value.text.isNotEmpty)
                              ? ColorConstants.theme1DarkBlue
                              : ColorConstants.warningDark,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    cursorColor: ColorConstants.theme1DarkBlue,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16.0),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Veriler alınırken bir hata oluştu.',
                            style: GoogleFonts.nunito(),
                          ),
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
                        child: Text(
                          "+ Link Ekle",
                          style: GoogleFonts.nunito(
                            color: ColorConstants.buttonPurple,
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
                                color: ColorConstants.background,
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
                                  style: GoogleFonts.nunito(
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
                                        color: ColorConstants.background,
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
                  TextButton(
                    onPressed: () {Navigator.pushNamed(
                        context, RouterConstants.userEducationInformationList);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.theme1PowderSkinOpacity, // Arkaplan rengi
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Kenar yarıçapı
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Eğitim Bilgileri",
                          style: GoogleFonts.nunito(
                            color: ColorConstants.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {Navigator.pushNamed(
                          context, RouterConstants.userProjectList);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.theme1PowderSkinOpacity, // Arkaplan rengi
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Kenar yarıçapı
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Projelerim",
                          style: GoogleFonts.nunito(
                            color: ColorConstants.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {Navigator.pushNamed(
                        context, RouterConstants.userAbilities);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.theme1PowderSkinOpacity, // Arkaplan rengi
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Kenar yarıçapı
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Yetenekler",
                          style: GoogleFonts.nunito(
                            color: ColorConstants.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {Navigator.pushNamed(
                        context, RouterConstants.licensesAndCertificatesPage);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.theme1PowderSkinOpacity, // Arkaplan rengi
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Kenar yarıçapı
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Lisanslar ve sertifikalar",
                          style: GoogleFonts.nunito(
                            color: ColorConstants.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: ElevatedButton(
                  onPressed: () async {
                    userDetail!.setAbout(_aboutController.value.text);
                    userDetail!.setName(_nameController.value.text);
                    userDetail!.setSurname(_lastnameController.value.text);
                    userModel!.setUsername(_usernameController.value.text);
                    userDetail!.setBirthday(selectedDate);
                    userDetail = await UserDetailService().update(userDetail!);
                    userDetail!.setPhone(_phoneController.value.text);

                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConstants.buttonPurple,
                    backgroundColor: ColorConstants.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text("Kaydet",
                      style: GoogleFonts.nunito(),
                    ),
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
                    color: ColorConstants.background,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorConstants.buttonPurple,
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
    _nameController.text =
        ControlHelper.checkInputValue(userDetail!.getName());
    _lastnameController.text =
        ControlHelper.checkInputValue(userDetail!.getSurname());
    _emailController.text =
        ControlHelper.checkInputValue(userModel!.getEmail());
    _phoneController.text =
        ControlHelper.checkInputValue(userDetail!.getPhone());
    _usernameController.text =
        ControlHelper.checkInputValue(userModel!.getUsername());
    if (userDetail!.getBirthday() != null) {
      selectedDate = userDetail!.getBirthday()!;
      _birthdayController.text = ControlHelper.checkInputValue(
          dateFormat.format(userDetail!.getBirthday()!));
    }
  }
}
