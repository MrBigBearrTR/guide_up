import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../core/enumeration/extensions/ExLanguage.dart';
import '../../../../core/models/users/user_education/user_education_model.dart';
import '../../../../repository/user/user_education/user_education_repository.dart';
import 'user_education_information_list.dart';

class UserEducationInformationPage extends StatefulWidget {
  const UserEducationInformationPage({Key? key}) : super(key: key);

  @override
  State<UserEducationInformationPage> createState() => _UserEducationInformationPageState();
}

class _UserEducationInformationPageState extends State<UserEducationInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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

  void addEducationInformation() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String school = schoolController.text.trim();
    String department = departmentController.text.trim();
    String startDate = startDateController.text.trim();
    String endDate = endDateController.text.trim();
    String grade = gradeController.text.trim();
    String activitiesSocieties = activitiesSocietiesController.text.trim();
    String description = descriptionController.text.trim();
    String link = linkController.text.trim();
    String language = enlanguageController.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        school.isNotEmpty &&
        startDate.isNotEmpty &&
        grade.isNotEmpty &&
        description.isNotEmpty) {
      UserEducation userEducationInformation = UserEducation();
      userEducationInformation.setUserId(userId!);
      userEducationInformation.setFirstName(firstName);
      userEducationInformation.setLastName(lastName);
      userEducationInformation.setSchoolName(school);
      userEducationInformation.setDepartment(department);
      userEducationInformation.setStartDate(DateTime.parse(startDate));
      userEducationInformation.setEndDate(DateTime.parse(endDate));
      userEducationInformation.setGrade(grade);
      userEducationInformation.setActivitiesSocienties(activitiesSocieties);
      userEducationInformation.setDescription(description);
      userEducationInformation.setLink(link);
      userEducationInformation.setEnLanguage(ExLanguage.getEnum(language));

      try {
        await UserEducationInformationRepository().add(userEducationInformation);

        setState(() {
          firstNameController.clear();
          lastNameController.clear();
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
                style: GoogleFonts.nunito(),),
              content: Text('Eğitim bilgisi başarıyla eklendi.',
                style: GoogleFonts.nunito(),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam',
                    style: GoogleFonts.nunito(),),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserEducationInformationList(userId: userId),
                ),
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
                  labelText: 'Ad',
                  labelStyle: GoogleFonts.nunito(
                    color: (firstNameController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (firstNameController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: firstNameController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Soyad',
                  labelStyle: GoogleFonts.nunito(
                    color: (lastNameController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (lastNameController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: lastNameController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
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
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (startDateController.value.text.isNotEmpty)
                          ? ColorConstants.theme1DarkBlue
                          : ColorConstants.warningDark,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
                ),
                controller: endDateController,
                cursorColor: ColorConstants.theme1DarkBlue,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Sınıf',
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
                  labelText: 'Dil Bilgisi',
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
