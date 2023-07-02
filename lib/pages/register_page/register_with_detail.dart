import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/pages/home/home_screen_page.dart';
import 'package:guide_up/pages/login/login_page.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/utils/user_helper.dart';

class RegisterWithDetail extends StatefulWidget {
  final UserModel userModel;

  const RegisterWithDetail({Key? key, required this.userModel}) : super(key: key);

  @override
  State<RegisterWithDetail> createState() => _RegisterWithDetailState();
}

class _RegisterWithDetailState extends State<RegisterWithDetail> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _birthdayController;
  late TextEditingController _aboutController;
  late TextEditingController _photoController;
  late TextEditingController _phoneController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _birthdayController = TextEditingController();
    _aboutController = TextEditingController();
    _photoController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _birthdayController.dispose();
    _aboutController.dispose();
    _photoController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitUserDetail(BuildContext context) async {
    List<String> unfilledFields = [];

    if (_nameController.text.isEmpty) {
      unfilledFields.add("İsim");
    }
    if (_surnameController.text.isEmpty) {
      unfilledFields.add("Soyisim");
    }
    if (_birthdayController.text.isEmpty) {
      unfilledFields.add("Doğum Tarihi");
    }
    if (_aboutController.text.isEmpty) {
      unfilledFields.add("Hakkımda");
    }
    if (_photoController.text.isEmpty) {
      unfilledFields.add("Resim Ekle");
    }
    if (_phoneController.text.isEmpty) {
      unfilledFields.add("Telefon Numarası");
    }

    if (unfilledFields.isNotEmpty) {
      String unfilledFieldsMessage = "Lütfen aşağıdaki alanları doldurun: " +
          unfilledFields.join(", ");

      _showSnackBar(unfilledFieldsMessage);
      return;
    }

    String name = _nameController.text;
    String surname = _surnameController.text;
    String birthday = _birthdayController.text;
    String about = _aboutController.text;
    String photo = _photoController.text;
    String phone = _phoneController.text;

    UserDetail userDetail = UserDetail();
    userDetail.setUserId(widget.userModel.getId()!);
    userDetail.setName(name);
    userDetail.setSurname(surname);




    userDetail.setAbout(about);
    userDetail.setPhoto(photo);
    userDetail.setPhone(phone);

    try {
      UserDetail registeredDetail = await UserHelper().saveUserDetail(userDetail);

      // Simulated delay for 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Redirect to the home page when the save operation is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      print('Error occurred while saving user detail: $e');
      _showSnackBar('An error occurred while saving user detail');
    }
  }
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _photoController.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topCenter,
            colors: [
              ColorConstants.appcolor2,
              ColorConstants.appcolor2,
              ColorConstants.appcolor1,
              ColorConstants.appcolor1,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'G u i d e U p ',
                          style: TextStyle(
                            height: 14,
                            fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.itemWhite,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/logo/guideUpLogo.png',
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.appcolor2,
                      ColorConstants.appcolor3
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 2000,
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          ' KAYIT OLUN ',
                          style: TextStyle(
                            color: ColorConstants.appcolor4,
                            fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.person_add),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _nameController,
                                  obscureText: false,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "İsim ",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.person),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _surnameController,
                                  obscureText: false,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Soyİsim  ",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.tab),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _aboutController,
                                  obscureText: false,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Hakkımda   ",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.phone),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _phoneController,
                                  obscureText: false,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Telefon Numarası  ",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.photo),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _pickImage(),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _photoController,
                                    obscureText: false,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: "Resim Ekle   ",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.date_range),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _birthdayController,
                                    obscureText: false,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: "Doğum Tarihi  ",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () => _submitUserDetail(context),
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.deepOrange,
                            elevation: 18,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepOrange,
                                  Colors.orange,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: 400,
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text(
                                'Kayıt Ol',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
