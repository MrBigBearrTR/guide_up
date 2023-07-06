import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../ui/material/custom_material.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyProjectsState createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();
  TextEditingController projectLinkController = TextEditingController();

  List<Project> projects = [];

  void addProject() {
    String projectName = projectNameController.text;
    String projectDescription = projectDescriptionController.text;
    String? projectLink = projectLinkController.text.isNotEmpty
        ? projectLinkController.text
        : null; // İsteğe bağlı olarak link eklemesi

    if (projectName.isNotEmpty && projectDescription.isNotEmpty) {
      Project project = Project(
        name: projectName,
        description: projectDescription,
        link: projectLink,
      );
      setState(() {
        projects.add(project);
      });
      projectNameController.clear();
      projectDescriptionController.clear();
      projectLinkController.clear();
    }
  }

  void removeProject(Project project) {
    setState(() {
      projects.remove(project);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projelerim'),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () {
            Navigator.pop(context);},
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
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (BuildContext context, int index) {
            final project = projects[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                color: ColorConstants.theme1PowderSkinOpacity, // card arka plan rengi
                child: ListTile(
                  title: Text(project.name),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeProject(project),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Yeni Proje Ekle',
                  style: GoogleFonts.nunito(
                    color: ColorConstants.itemWhite, // Yazı rengi
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: projectNameController,
                      cursorColor: ColorConstants.warningDark,
                      style: GoogleFonts.nunito(), // Yazı tipi
                      decoration: const InputDecoration(
                        labelText: 'Proje Adı',
                        labelStyle: TextStyle(
                          color: ColorConstants.theme2White, // Yazı rengi
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.warningDark, // Alt çizgi rengi
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: projectDescriptionController,
                      cursorColor: ColorConstants.warningDark,
                      style: GoogleFonts.nunito(), // Yazı tipi
                      decoration: const InputDecoration(
                        labelText: 'Proje Açıklaması',
                        labelStyle: TextStyle(
                          color: ColorConstants.theme2White, // Yazı rengi
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.warningDark, // Alt çizgi rengi
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: projectLinkController,
                      cursorColor: ColorConstants.warningDark,
                      style: GoogleFonts.nunito(), // Yazı tipi
                      decoration: const InputDecoration(
                        labelText: 'Proje Linki (isteğe bağlı)',
                        labelStyle: TextStyle(
                          color: ColorConstants.theme2White, // Yazı rengi
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.warningDark, // Alt çizgi rengi
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('İptal',
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.itemWhite, // Metin rengi
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addProject();
                      Navigator.pop(context);
                    },
                    child: Text('Ekle',
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.theme2Dark, // Metin rengi
                      ),
                    ),
                  ),
                ],
                backgroundColor: ColorConstants.theme1DarkBlue, // Arka plan rengi
              );
            },
          );
        },
        backgroundColor: ColorConstants.warningDark, // Arka plan rengi
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Project {
  final String name;
  final String description;
  final String? link; // İsteğe bağlı link

  Project({required this.name, required this.description, this.link});
}
