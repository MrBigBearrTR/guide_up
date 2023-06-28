import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:intl/intl.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this line

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

    DateTime? parsedBirthday;
    try {
      parsedBirthday = DateFormat('yyyy-MM-dd').parse(birthday);
    } catch (e) {
      print('Invalid date format: $e');
    }
    if (parsedBirthday != null) {
      userDetail.setBirthday(parsedBirthday);
    } else {
      print('Invalid date format, unable to parse the birthday');
      return;
    }

    userDetail.setAbout(about);
    userDetail.setPhoto(photo);
    userDetail.setPhone(phone);

    try {
      UserDetail registeredDetail = await UserHelper().saveUserDetail(userDetail);
      print('Detay kaydedildi: $registeredDetail');

      // Navigate to the home page
      Navigator.pop(context);
    } catch (error) {
      print('Kaydetme başarısız: $error');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register with Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
              ),
              TextField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday'),
              ),
              TextField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'About'),
              ),
              TextField(
                controller: _photoController,
                decoration: const InputDecoration(labelText: 'Photo'),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _submitUserDetail(context),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
