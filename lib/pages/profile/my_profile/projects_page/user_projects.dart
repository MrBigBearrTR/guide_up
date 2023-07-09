import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/user/user_project/user_project_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';
import '../../../../ui/material/custom_material.dart';

class UserProjectPage extends StatefulWidget {
  const UserProjectPage({Key? key}) : super(key: key);

  @override
  State<UserProjectPage> createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  TextEditingController projectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  String? userId;
  bool isAddingProject = false;

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
        // Kullanıcı oturum açmamışsa veya kimlik doğrulama kullanmıyorsa,
        // userId değerini uygun şekilde ayarlamanız gerekecektir.
      }
    }
  }

  void addProject() async {
    String project = projectController.text.trim();
    String description = descriptionController.text.trim();
    String link = linkController.text.trim();

    if (project.isNotEmpty && description.isNotEmpty) {
      UserProject userProject = UserProject();
      userProject.setUserId(userId!);
      userProject.setProjectTitle(project);
      userProject.setDescription(description);
      userProject.setLink(link);

      try {
        await UserProjectRepository().add(userProject);

        setState(() {
          projectController.clear();
          descriptionController.clear();
          linkController.clear();
        });
        print('Project added to Firebase: $project');
      } catch (error) {
        print('Failed to add project to Firebase: $error');
      }
    }
  }

  void showAddProjectPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Yeni Proje Ekle',
            style: GoogleFonts.nunito(color: ColorConstants.itemWhite), // Yazı rengini beyaz yapar
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: projectController,
                decoration: InputDecoration(
                  labelText: 'Proje Adı',
                  labelStyle: GoogleFonts.nunito(color: ColorConstants.itemWhite), // Yazı rengini beyaz yapar
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange), // Yatay çizgi rengi
                  ),
                ),
                cursorColor: ColorConstants.theme2Orange, // İmleç rengi
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Proje Açıklaması',
                  labelStyle: GoogleFonts.nunito(color: ColorConstants.itemWhite), // Yazı rengini beyaz yapar
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange), // Yatay çizgi rengi
                  ),
                ),
                cursorColor: ColorConstants.theme2Orange, // İmleç rengi
              ),
              TextField(
                controller: linkController,
                decoration: InputDecoration(
                  labelText: 'Proje Linki (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(color: ColorConstants.itemWhite), // Yazı rengini beyaz yapar
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.theme2Orange), // Yatay çizgi rengi
                  ),
                ),
                cursorColor: ColorConstants.theme2Orange, // İmleç rengi
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'İptal',
                style: GoogleFonts.nunito(color: ColorConstants.itemWhite), // Yazı rengini beyaz yapar
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addProject();
                Navigator.of(context).pop();
              },
              child: Text(
                'Ekle',
                style: GoogleFonts.nunito(color: ColorConstants.info), // Yazı rengini mavi yapar
              ),
            ),
          ],
          backgroundColor: ColorConstants.theme1DarkBlue,
        );
      },
    );
  }


  void deleteProject(UserProject project) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Projeyi Sil',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
          content: Text('Bu projeyi silmek istediğinizden emin misiniz?',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal',
                  style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await UserProjectRepository().delete(project);

                  setState(() {});

                  print(
                      'Project deleted from Firebase: ${project.getProjectTitle() ??
                          "Unknown project"}');
                } catch (error) {
                  print('Failed to delete project from Firebase: $error');
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Text('Sil',
                  style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
            ),
          ],
          backgroundColor: ColorConstants.theme1DarkBlue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeler',
          style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/logo/guideUpLogo.png', // Logo resminin yolunu buraya ekleyin
              width: 62,
              height: 62,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        padding: const EdgeInsets.all(16.0),
        child:  Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserProject>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Projelerinizi şu an listeyemiyoruz.',
                      style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),),
                  );
                } else {
                  if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                    return Center(
                      child: Text(
                          'Proje kaydınız bulunamadı. Eklemeye ne dersiniz?',
                        style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final project = snapshot.data![index];
                        return Card(
                          color: ColorConstants.theme1DarkBlue, // Eklenen Proje tablo rengi
                          elevation: 2, // Card'ın gölgelendirme seviyesi
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                          title: Text(
                            project.getProjectTitle() ?? '',
                          style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.theme2Orange, // Proje metni rengi
                        ),
                        ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteProject(project),
                            color: ColorConstants.theme2Orange, // Silme butonu rengi
                          ),
                        ),
                        );
                      },
                    );
                  }
                }
              },
              future: UserProjectRepository().getUserProjectListByUserId(
                  userId ?? ''),
            ),
          ),
        ],
      ),
    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.theme1DarkBlue, // Buton kutusu arka plan rengi
          onPressed: showAddProjectPopup,
          child: const Icon(
            Icons.add,
            color: ColorConstants.itemWhite,
          ),
        ),
    );
  }
}