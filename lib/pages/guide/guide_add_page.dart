import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/models/post/post_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/post/post_repository.dart';
import 'package:guide_up/service/post/post_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constant/color_constants.dart';

class GuideAddPage extends StatefulWidget {
  const GuideAddPage({Key? key}) : super(key: key);

  @override
  State<GuideAddPage> createState() => _GuideAddPageState();
}

class _GuideAddPageState extends State<GuideAddPage> {
  late TextEditingController _topicController;
  late TextEditingController _contentController;
  final _formKey = GlobalKey<FormState>();
  File? _guidePicture;
  UserDetail? userDetail;
  Post? post;

  PostRepository? postRepository;

  @override
  void initState() {
    super.initState();
    _topicController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _topicController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void createPost(BuildContext context) async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail != null) {
      String topic = _topicController.text;
      String content = _contentController.text;
      post ??= Post();
      post!.setTopic(topic);
      post!.setContent(content);
      if (_guidePicture != null) {
        post!.setPhoto(_guidePicture!.path);
      }
      post!.setUserId(detail.getUserId()!);

      await PostService().add(post!);
      Navigator.pop(context);
    }
  }

  pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,

    );
    if (pickedImage != null) {
      setState(() {
        _guidePicture = File(pickedImage.path);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Guide 'in",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: ColorConstants.darkBack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: ColorConstants.textwhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Başlık Giriniz ',
                    labelStyle: GoogleFonts.nunito(
                      color: (_topicController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_topicController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  controller: _topicController,
                  cursorColor: ColorConstants.theme1DarkBlue,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Metin Giriniz',
                      labelStyle: GoogleFonts.nunito(
                        color: (_contentController.value.text.isNotEmpty)
                            ? ColorConstants.theme1DarkBlue
                            : ColorConstants.warningDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (_contentController.value.text.isNotEmpty)
                              ? ColorConstants.theme1DarkBlue
                              : ColorConstants.warningDark,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20)),
                  maxLines: 5,
                  minLines: 2,
                  controller: _contentController,
                  cursorColor: ColorConstants.theme1DarkBlue,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: pickProfileImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: getImage(),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                SizedBox(
                  // width: 460,
                  child: ElevatedButton(
                    onPressed: () {
                      createPost(context);
                    },
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
                          'Guide Ekle',
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
      ),
    );
  }

  ImageProvider<Object> getImage() {
    if (post == null) {
      if (_guidePicture != null) {
        return FileImage(_guidePicture!);
      } else {
        return const AssetImage("assets/img/Guide_photo_add.png");
      }
    } else {
      return NetworkImage(post!.getPhoto()!);
    }
  }
}
