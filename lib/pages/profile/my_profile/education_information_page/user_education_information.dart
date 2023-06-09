import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:intl/intl.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../core/constant/router_constants.dart';
import '../../../../core/enumeration/extensions/ExLanguage.dart';
import '../../../../core/models/users/user_education/user_education_model.dart';
import '../../../../core/utils/user_info_helper.dart';
import '../../../../repository/user/user_education/user_education_repository.dart';

class UserEducationInformationPage extends StatefulWidget {
  const UserEducationInformationPage({Key? key}) : super(key: key);

  @override
  State<UserEducationInformationPage> createState() => _UserEducationInformationPageState();
}

class _UserEducationInformationPageState extends State<UserEducationInformationPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final dateFormat = DateFormat('dd.MM.yyyy');
  TextEditingController schoolController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController activitiesSocietiesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController enlanguageController = TextEditingController();

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
        startDateController.text = dateFormat.format(startDate);
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
        endDateController.text = dateFormat.format(endDate);
      });
    }
  }

  void addEducationInformation() async {
    String school = schoolController.text.trim();
    String department = departmentController.text.trim();
    String startDateText = startDateController.text.trim();
    String endDateText = endDateController.text.trim();
    String grade = gradeController.text.trim();
    String activitiesSocieties = activitiesSocietiesController.text.trim();
    String description = descriptionController.text.trim();
    String link=linkController.text.trim();
    String language = enlanguageController.text.trim();
    String error="";

    if (school.isEmpty || startDateText.isEmpty || description.isEmpty) {
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

      UserEducation userEducationInformation = UserEducation();
      userEducationInformation.setUserId(userId!);
      userEducationInformation.setSchoolName(school);
      userEducationInformation.setDepartment(department);
      userEducationInformation.setStartDate(startDate);
      if(endDateText.isNotEmpty) {
          userEducationInformation.setEndDate(endDate); }
      userEducationInformation.setGrade(grade);
      userEducationInformation.setActivitiesSocienties(activitiesSocieties);
      userEducationInformation.setDescription(description);
      userEducationInformation.setLink(link);
      userEducationInformation.setEnLanguage(ExLanguage.getEnum(language));

      try {
        await UserEducationInformationRepository().add(userEducationInformation);

        setState(() {
          schoolController.clear();
          departmentController.clear();
          startDateController.clear();
          endDateController.clear();
          gradeController.clear();
          activitiesSocietiesController.clear();
          descriptionController.clear();
          linkController.clear();
          enlanguageController.clear();
        });

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Başarı',
                style: GoogleFonts.nunito(
                  color: ColorConstants.itemWhite,),),
              content: Text('Eğitim bilgisi başarıyla eklendi.',
                style: GoogleFonts.nunito(
                  color: ColorConstants.success,),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam',
                    style: GoogleFonts.nunito(
                      color: ColorConstants.itemWhite,),),
                ),
              ],
              backgroundColor: ColorConstants.theme1DarkBlue,
            );
          },
        );

        print('EducationInformation added to Firebase: $userEducationInformation');
      } catch (error) {
        print('Failed to add educationInformation to Firebase: $error');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.itemWhite, // AppBar arka plan rengi
        title: Text('Eğitim Bilgileri',
          style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: ColorConstants.theme1DarkBlue, // Kalem ikonu rengi
            ),
            onPressed: () {
              Navigator.pushNamed(context,RouterConstants.userEducationInformationList);
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
                  labelText: 'Okul Adı',
                  labelStyle: GoogleFonts.nunito(
                    color: (schoolController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (schoolController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: schoolController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Departman (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(
                    color: (departmentController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (departmentController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: departmentController,
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
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (endDateController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: showDatePickerDialog2,
                  color: ColorConstants.theme1DarkBlue,
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
                  labelText: 'Sınıf (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(
                    color: (gradeController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (gradeController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: gradeController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Aktiviteler/Sosyal Faaliyetler (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(
                    color: (activitiesSocietiesController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (activitiesSocietiesController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: activitiesSocietiesController,
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
                  labelText: 'Bağlantı (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(
                    color: (linkController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (linkController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dil Bilgisi (isteğe bağlı)',
                  labelStyle: GoogleFonts.nunito(
                    color: (enlanguageController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (enlanguageController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: enlanguageController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
          const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addEducationInformation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.theme1DarkBlue, // Arka plan rengi
              ),
              child: Text(
                'Ekle',
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
