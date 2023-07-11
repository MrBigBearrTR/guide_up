import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';
import '../../../../repository/user/user_project/user_project_repository.dart';

class UserProjectPage extends StatefulWidget {
  const UserProjectPage({Key? key}) : super(key: key);

  @override
  State<UserProjectPage> createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  TextEditingController projectTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    if (userId == null) {
      String? tempUserId = await SecureStorageHelper().getUserId();
      if (tempUserId != null) {
        setState(() {
          userId = tempUserId;
        });
      } else {
        // Kullanıcı oturum açmamışsa veya kimlik doğrulama kullanmıyorsanız,
        // userId değerini uygun şekilde ayarlamanız gerekecektir.
      }
    }
  }

  void addUserProject() async {
    String projectTitle = projectTitleController.text.trim();
    String description = descriptionController.text.trim();
    String link = linkController.text.trim();

    if (projectTitle.isEmpty || description.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Uyarı',
              style: GoogleFonts.nunito(
                color: ColorConstants.dangerDark,
              ),
            ),
            content: Text(
              'Proje adı ve açıklama alanları boş bırakılamaz.',
              style: GoogleFonts.nunito(
                color: ColorConstants.itemWhite,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.nunito(
                    color: ColorConstants.itemWhite,
                  ),
                ),
              ),
            ],
            backgroundColor: ColorConstants.theme1DarkBlue,
          );
        },
      );
      return;
    }

    UserProject userProject = UserProject();
    userProject.setUserId(userId!);
    userProject.setProjectTitle(projectTitle);
    userProject.setDescription(description);
    userProject.setLink(link);

    try {
      await UserProjectRepository().add(userProject);

      setState(() {
        projectTitleController.clear();
        descriptionController.clear();
        linkController.clear();
      });

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Başarılı',
              style: GoogleFonts.nunito(
                color: ColorConstants.itemWhite,
              ),
            ),
            content: Text(
              'Proje başarıyla eklendi.',
              style: GoogleFonts.nunito(
                color: ColorConstants.success,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.nunito(
                    color: ColorConstants.itemWhite,
                  ),
                ),
              ),
            ],
            backgroundColor: ColorConstants.theme1DarkBlue,
          );
        },
      );

      print('Project added to Firebase: $userProject');
    } catch (error) {
      print('Failed to add project to Firebase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.itemWhite, // AppBar arka plan rengi
        title: Text(
          'Proje',
          style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: ColorConstants.theme1DarkBlue,  // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.userProjectList,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Proje Adı',
                labelStyle: GoogleFonts.nunito(
                  color:(projectTitleController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (projectTitleController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: projectTitleController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Açıklama',
                labelStyle: GoogleFonts.nunito(
                  color: (descriptionController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (descriptionController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: descriptionController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Proje linki (isteğe bağlı)',
                labelStyle: GoogleFonts.nunito(
                  color: (linkController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorConstants.theme1DarkBlue,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: linkController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addUserProject();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.theme1DarkBlue, // Arka plan rengi
              ),
              child: Text(
                'Kaydet',
                style: GoogleFonts.nunito(
                  color: ColorConstants.itemWhite, // Yazı rengi
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
