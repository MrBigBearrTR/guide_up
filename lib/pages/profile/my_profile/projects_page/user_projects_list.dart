import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';
import '../../../../repository/user/user_project/user_project_repository.dart';

class UserProjectList extends StatefulWidget {
  final String? userId;

  const UserProjectList({Key? key, required this.userId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProjectListState createState() =>
      _UserProjectListState();
}

class _UserProjectListState
    extends State<UserProjectList> {
  void _deleteProject(UserProject project) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Proje Bilgisini Sil'),
          content: const Text(
              'Bu projeyi silmek istediğinizden emin misiniz?'),
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
                  await UserProjectRepository()
                      .delete(project);

                  setState(() {});

                  print(
                      'Project deleted from Firebase: $project');
                } catch (error) {
                  print(
                      'Failed to delete project from Firebase: $error');
                }
                // ignore: use_build_context_synchronously
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projeler'),
      ),
      body: FutureBuilder<List<UserProject>>(
        future: UserProjectRepository()
            .getUserProjectListByUserId(widget.userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Projelerinizi şu an listeleyemiyoruz.'),
            );
          } else {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Proje Adı: ${project.getProjectTitle() ?? ""}'),
                        if (project.getDescription()?.isNotEmpty ==
                            true)
                          Text(
                              'Açıklama: ${project.getDescription()}'),
                        if (project.getLink()?.isNotEmpty == true)
                          Text(
                              'Bağlantı: ${project.getLink() ?? ""}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteProject(project),
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
