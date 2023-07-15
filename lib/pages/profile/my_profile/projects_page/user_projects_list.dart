import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/repository/user/user_experience/user_experience_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../core/utils/user_info_helper.dart';
import '../../../../repository/user/user_project/user_project_repository.dart';

class UserProjectList extends StatefulWidget {
  const UserProjectList({Key? key}) : super(key: key);

  @override
  State<UserProjectList> createState() => _UserProjectListState();
}

class _UserProjectListState extends State<UserProjectList> {
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

  void _deleteProject(UserProject project) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Proje Bilgisini Sil',
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
                      'Project added to Firebase: ${project.getProjectTitle() ?? "Unknown project"}');
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
        title: Text(
          'Projeler',
          style: GoogleFonts.nunito(
            // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.theme1DarkBlue, // Geri buton rengi
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: ColorConstants.theme1DarkBlue, // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.userProjectPage)
                  .then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserProject>>(
        future:
            UserProjectRepository().getUserProjectListByUserId(userId ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Projelerinizi şu an listeleyemiyoruz.',
                    style: GoogleFonts.nunito(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/logo/guideUpLogo.png',
                      width: 62,
                      height: 62,
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Image.asset(
                        'assets/logo/guideUpLogo.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                                context, RouterConstants.userProjectPage)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            ColorConstants.theme1DarkBlue),
                        elevation: MaterialStateProperty.all<double>(8.0),
                        // Gölge efekti
                        overlayColor: MaterialStateProperty.all<Color>(
                            ColorConstants.theme2DarkOpacity20),
                      ),
                      child: Text(
                        'Proje kaydınız bulunamadı. Eklemeye ne dersiniz?',
                        style: GoogleFonts.nunito(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final project = snapshot.data![index];
                  return Card(
                    color: ColorConstants.theme1DarkBlue, // Eklenen tablo rengi
                    elevation: 2, // Card'ın gölgelendirme seviyesi
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proje Adı: ${project.getProjectTitle() ?? ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),
                          ),
                          if (project.getExperienceId() != null)
                            FutureBuilder(
                              future: UserExperienceRepository()
                                  .get(project.getExperienceId()!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    'Deneyim: ${snapshot.data!.getJobTitle() ?? ""}',
                                    style: GoogleFonts.nunito(
                                      color: ColorConstants.itemWhite,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'Deneyim: ',
                                    style: GoogleFonts.nunito(
                                      color: ColorConstants.itemWhite,
                                    ),
                                  );
                                }
                              },
                            ),
                          if (project.getExperienceId() == null)
                            Text(
                              'Deneyim: ',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite,
                              ),
                            ),
                          if (project.getDescription()?.isNotEmpty == true)
                            Text(
                              'Açıklama: ${project.getDescription()}',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite,
                              ),
                            ),
                          Text(
                            'Başlangıç Tarihi: ${project.getStartDate() != null ? UserInfoHelper.dateFormat.format(project.getStartDate()!) : ""}',
                            style: GoogleFonts.nunito(
                              color: ColorConstants.itemWhite,
                            ),
                          ),
                          if (project.getEndDate() != null)
                            Text(
                              'Bitiş Tarihi: ${project.getEndDate() != null ? UserInfoHelper.dateFormat.format(project.getEndDate()!) : ""}',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite,
                              ),
                            ),
                          if (project.getLink()?.isNotEmpty == true)
                            Text(
                              'Bağlantı: ${project.getLink() ?? ""}',
                              style: GoogleFonts.nunito(
                                color: ColorConstants.itemWhite,
                              ),
                            ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteProject(project), color: ColorConstants
                          .buttonPurple, // Silme butonu rengi
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
