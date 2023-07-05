import 'package:flutter/material.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/user/user_project/user_project_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';

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
      userProject.setProject(project);
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
          title: const Text('Yeni Proje Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: projectController,
                decoration: const InputDecoration(
                  labelText: 'Proje Adı',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Proje Açıklaması',
                ),
              ),
              TextField(
                controller: linkController,
                decoration: const InputDecoration(
                  labelText: 'Proje Linki (isteğe bağlı)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                addProject();
                Navigator.of(context).pop();
              },
              child: const Text('Ekle'),
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
          title: const Text('Projeyi Sil'),
          content: const Text('Bu projeyi silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await UserProjectRepository().delete(project);

                  setState(() {});

                  print(
                      'Project deleted from Firebase: ${project.getProject() ??
                          "Unknown project"}');
                } catch (error) {
                  print('Failed to delete project from Firebase: $error');
                }
                Navigator.of(context).pop();
              },
              child: const Text('Sil'),
            ),
          ],
          backgroundColor: ColorConstants.theme1DarkBlue,
        );
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projeler'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserProject>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Projelerinizi şu an listeyemiyoruz.'),
                  );
                } else {
                  if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                    return const Center(
                      child: Text(
                          'Proje kaydınız bulunamadı. Eklemeye ne dersiniz?'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final project = snapshot.data![index];
                        return ListTile(
                          title: Text(project.getProject() ?? ''),
                          subtitle: Text(project.getDescription() ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteProject(project),
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
      floatingActionButton: FloatingActionButton(
        onPressed: showAddProjectPopup,
        child: const Icon(Icons.add),
      ),
    );
  }
}