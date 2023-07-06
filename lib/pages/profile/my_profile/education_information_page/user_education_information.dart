import 'package:flutter/material.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../core/enumeration/extensions/ExLanguage.dart';
import '../../../../core/models/users/user_education/user_education_model.dart';
import '../../../../repository/user/user_education/user_education_repository.dart';

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
        userId = tempUserId;
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
        print('EducationInformation added to Firebase: $userEducationInformation');
      } catch (error) {
        print('Failed to add educationInformation to Firebase: $error');
      }
    }
  }


  void deleteEducationInformation(UserEducation educationInformation) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eğitim Bilgisini Sil'),
          content: const Text('Bu eğitim bilgisini silmek istediğinizden emin misiniz?'),
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
                  await UserEducationInformationRepository().delete(educationInformation);

                  setState(() {});

                  print('EducationInformation deleted from Firebase: $educationInformation');
                } catch (error) {
                  print('Failed to delete educationInformation from Firebase: $error');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eğitim Bilgileri'),
      ),
      body: Column(
      children: [
      Expanded(
            child: FutureBuilder<List<UserEducation>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Eğitim bilgilerinizi şu an listeleyemiyoruz.'),
                  );
                } else {
                  if (snapshot.data != null && snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Eğitim bilgisi kaydınız bulunamadı. Eklemeye ne dersiniz?'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final educationInformation = snapshot.data![index];
                        return ListTile(
                          title: Text('${educationInformation.getFirstName()} ${educationInformation.getLastName()}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Okul: ${educationInformation.getSchoolName()}'),
                              if (educationInformation.getDepartment()!.isNotEmpty)
                                Text('Departman: ${educationInformation.getDepartment()}'),
                              Text('Başlangıç Tarihi: ${educationInformation.getStartDate().toString()}'),
                              if (educationInformation.getEndDate() != null)
                                Text('Bitiş Tarihi: ${educationInformation.getEndDate().toString()}'),
                              Text('Sınıf: ${educationInformation.getGrade()}'),
                              if (educationInformation.getActivitiesSocienties()!.isNotEmpty)
                                Text('Aktiviteler/Sosyal Faaliyetler: ${educationInformation.getActivitiesSocienties()}'),
                              Text('Açıklama: ${educationInformation.getDescription()}'),
                              if (educationInformation.getLink()!.isNotEmpty)
                                Text('Bağlantı: ${educationInformation.getLink()}'),
                              Text('Dil Bilgisi: ${educationInformation.getEnLanguage()}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteEducationInformation(educationInformation),
                          ),
                        );
                      },
                    );
                  }
                }
              },
              future: UserEducationInformationRepository().getUserEducationInformationListByUserId(userId ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
              TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: 'Ad',
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'Soyad',
            ),
          ),
                TextField(
                  controller: schoolController,
                  decoration: const InputDecoration(
                    hintText: 'Okul Adı',
                  ),
                ),
                TextField(
                  controller: departmentController,
                  decoration: const InputDecoration(
                    hintText: 'Departman (isteğe bağlı)',
                  ),
                ),
                TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                    hintText: 'Başlangıç Tarihi',
                  ),
                ),
                TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                    hintText: 'Bitiş Tarihi (isteğe bağlı)',
                  ),
                ),
                TextField(
                  controller: gradeController,
                  decoration: const InputDecoration(
                    hintText: 'Sınıf',
                  ),
                ),
                TextField(
                  controller: activitiesSocietiesController,
                  decoration: const InputDecoration(
                    hintText: 'Aktiviteler/Sosyal Faaliyetler (isteğe bağlı)',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Açıklama',
                  ),
                ),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    hintText: 'Bağlantı (isteğe bağlı)',
                  ),
                ),
                TextField(
                  controller: enlanguageController,
                  decoration: const InputDecoration(
                    hintText: 'Dil Bilgisi',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: addEducationInformation,
                  child: const Text('Ekle'),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
