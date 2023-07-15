import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/models/users/user_experience/user_experience_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/repository/user/user_experience/user_experience_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/models/users/user_project/user_project_model.dart';
import '../../../../core/utils/control_helper.dart';
import '../../../../repository/user/user_project/user_project_repository.dart';

class UserProjectPage extends StatefulWidget {
  const UserProjectPage({Key? key}) : super(key: key);

  @override
  State<UserProjectPage> createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  UserProject? userProject;
  List<UserExperience> experienceList = [];
  UserExperience? selectedExperience;
  UserExperience emptyExperience = UserExperience();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController projectTitleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
    startDateController = TextEditingController(
      text: UserInfoHelper.dateFormat.format(startDate),
    );
  }

  void getUserId() async {
    if (userId == null) {
      selectedExperience = emptyExperience;
      String? tempUserId = await SecureStorageHelper().getUserId();
      if (tempUserId != null) {
        userId = tempUserId;
        experienceList = await UserExperienceRepository().getList(userId!, 0);
        setState(() {});
      } else {
        // Kullanıcı oturum açmamışsa veya kimlik doğrulama kullanmıyorsanız,
        // userId değerini uygun şekilde ayarlamanız gerekecektir.
      }
    }
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
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
        startDateController.text = UserInfoHelper.dateFormat.format(startDate);
      });
    }
  }

  Future<void> showDatePickerDialog2() async {
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
      initialDate: endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != endDate) {
      setState(() {
        endDate = pickedDate;
        endDateController.text = UserInfoHelper.dateFormat.format(endDate);
      });
    }
  }

  void addUserProject(BuildContext contextMain) async {
    String projectTitle = projectTitleController.text.trim();
    String startDateText = startDateController.text.trim();
    String endDateText = endDateController.text.trim();
    String description = descriptionController.text.trim();
    String link = linkController.text.trim();
    String error="";

    if (projectTitle.isEmpty || description.isEmpty || startDateText.isEmpty) {
      error="deneyim kimliği, Proje adı, başlangıç tarihi  ve açıklama alanları boş bırakılamaz.";
    }else if(link.isNotEmpty && !UserInfoHelper.hasValidUrl(link)){
      error="Lütfen URL bilgisini doğru formatta giriniz.";

    }

    if (error.isNotEmpty) {
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
              error,
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
    if (selectedExperience != null && selectedExperience!.getId() != null) {
      userProject.setExperienceId(selectedExperience!.getId()!);
    }
    userProject.setProjectTitle(projectTitle);
    userProject.setStartDate(startDate);
    if (endDateText.isNotEmpty) {
      userProject.setEndDate(endDate);
    }
    userProject.setDescription(description);
    userProject.setLink(link);

    try {
      await UserProjectRepository().add(userProject);

      setState(() {
        selectedExperience = emptyExperience;
        projectTitleController.clear();
        startDateController.clear();
        endDateController.clear();
        descriptionController.clear();
        linkController.clear();
      });

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context2) {
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
                  Navigator.of(context2).pop();
                  Navigator.of(contextMain).pop();
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
          style: GoogleFonts.nunito(
            // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: ColorConstants.theme1DarkBlue, // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouterConstants.userProjectList,
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
                  color: (projectTitleController.value.text.isNotEmpty)
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
            Text(
              "Deneyim : (isteğe bağlı)",
              style: GoogleFonts.nunito(
                fontSize: 15,
                //fontWeight: FontWeight.bold,
                color: ColorConstants.buttonPurple,
              ),
            ),
            DropdownButton<UserExperience>(
              focusColor: ColorConstants.buttonPurple,
              value: selectedExperience,
              style: GoogleFonts.nunito(color: ColorConstants.buttonPurple),
              dropdownColor: ColorConstants.background,
              isExpanded: true,
              onChanged: (UserExperience? value) {
                selectedExperience = value!;
                setState(() {});
              },
              items: [
                emptyExperience,
                ...experienceList
              ].map<DropdownMenuItem<UserExperience>>((UserExperience value) {
                return DropdownMenuItem<UserExperience>(
                  value: value,
                  child: Text(value.getJobTitle() ?? "Seçiniz.."),
                );
              }).toList(),
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
                labelText: 'Başlangıç Tarihi',
                labelStyle: GoogleFonts.nunito(
                  color: (startDateController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: showDatePickerDialog,
                  color: ColorConstants.theme1DarkBlue,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (startDateController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: true,
              controller: startDateController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Bitiş Tarihi (isteğe bağlı)',
                labelStyle: GoogleFonts.nunito(
                  color: (endDateController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: showDatePickerDialog2,
                  color: ColorConstants.theme1DarkBlue,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (endDateController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: true,
              controller: endDateController,
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
                addUserProject(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    ColorConstants.theme1DarkBlue, // Arka plan rengi
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

  void setValues() {
    if (userProject!.getStartDate() != null) {
      startDate = userProject!.getStartDate()!;
      startDateController.text = ControlHelper.checkInputValue(
          UserInfoHelper.dateFormat.format(userProject!.getStartDate()!));
    }
    if (userProject!.getEndDate() != null) {
      endDate = userProject!.getEndDate()!;
      endDateController.text = ControlHelper.checkInputValue(
          UserInfoHelper.dateFormat.format(userProject!.getEndDate()!));
    }
  }
}
