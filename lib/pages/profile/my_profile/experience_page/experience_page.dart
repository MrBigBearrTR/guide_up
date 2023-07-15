import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/enumeration/enums/EnEmploymentType.dart';
import 'package:guide_up/core/enumeration/enums/EnLocationType.dart';
import 'package:guide_up/core/enumeration/extensions/ExEmploymentType.dart';
import 'package:guide_up/core/enumeration/extensions/ExLocationType.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_experience/user_experience_model.dart';
import '../../../../core/utils/control_helper.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../core/utils/user_info_helper.dart';
import '../../../../repository/user/user_experience/user_experience_repository.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  UserExperience? userExperience;
  EnEmploymentType? selectedEmploymentType;
  EnLocationType? selectedLocationType;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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
      String? tempUserId = await SecureStorageHelper().getUserId();
      if (tempUserId != null) {
        userId = tempUserId;
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

  void addUserExperience(BuildContext contextMain) async {
    String companyName = companyNameController.text.trim();
    String jobTitle = jobTitleController.text.trim();
    String locationTitle = locationController.text.trim();
    String industryTitle = industryController.text.trim();
    String startDateText = startDateController.text.trim();
    String endDateText = endDateController.text.trim();
    String description = descriptionController.text.trim();
    String link = linkController.text.trim();
    String error = "";

    if (companyName.isEmpty ||
        locationTitle.isEmpty ||
        industryTitle.isEmpty ||
        jobTitle.isEmpty ||
        description.isEmpty ||
        startDateText.isEmpty ||
        selectedEmploymentType == null ||
        selectedLocationType == null) {
      error = "Lütfen Tüm alanları doldurunuz.";
    } else if (link.isNotEmpty && !UserInfoHelper.hasValidUrl(link)) {
      error = "Lütfen URL bilgisini doğru formatta giriniz.";
    }
    if (error.isNotEmpty) {
      showDialog(
        context: contextMain,
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

    UserExperience userExperience = UserExperience();
    userExperience.setUserId(userId!);
    userExperience.setJobTitle(jobTitle);
    userExperience.setCompanyName(companyName);
    userExperience.setLocation(locationTitle);
    userExperience.setEnLocationType(selectedLocationType!);
    userExperience.setEnEmploymentType(selectedEmploymentType!);
    userExperience.setIndustry(industryTitle);
    userExperience.setStartDate(startDate);
    if (endDateText.isNotEmpty) {
      userExperience.setEndDate(endDate);
    }
    userExperience.setDescription(description);
    userExperience.setLink(link);

    try {
      await UserExperienceRepository().add(userExperience);

      setState(() {
        jobTitleController.clear();
        companyNameController.clear();
        locationController.clear();
        industryController.clear();
        startDateController.clear();
        endDateController.clear();
        descriptionController.clear();
        linkController.clear();
        selectedLocationType = null;
        selectedEmploymentType = null;
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
              'Tecrübe başarıyla eklendi.',
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

      print('Experience added to Firebase: $userExperience');
    } catch (error) {
      print('Failed to add experience to Firebase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.itemWhite, // AppBar arka plan rengi
        title: Text(
          'Tecrübe',
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
              Navigator.pop(context);
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
                labelText: 'Başlık',
                labelStyle: GoogleFonts.nunito(
                  color: (jobTitleController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (jobTitleController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: jobTitleController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Firma Adı',
                labelStyle: GoogleFonts.nunito(
                  color: (companyNameController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (companyNameController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: companyNameController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              "istihdam Şekli :",
              style: GoogleFonts.nunito(
                fontSize: 15,
                //fontWeight: FontWeight.bold,
                color: ColorConstants.theme2Orange,
              ),
            ),
            DropdownButton<EnEmploymentType>(
              focusColor: ColorConstants.theme2Orange,
              value: selectedEmploymentType,
              style: GoogleFonts.nunito(color: ColorConstants.theme2Orange),
              dropdownColor: ColorConstants.theme2DarkBlue,
              isExpanded: true,
              onChanged: (EnEmploymentType? value) {
                selectedEmploymentType = value!;
                setState(() {});
              },
              items: EnEmploymentType.values
                  .map<DropdownMenuItem<EnEmploymentType>>(
                      (EnEmploymentType value) {
                return DropdownMenuItem<EnEmploymentType>(
                  value: value,
                  child: Text(value.getDisplayname()),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Konum',
                labelStyle: GoogleFonts.nunito(
                  color: (locationController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (locationController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: locationController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              "Konum Türü :",
              style: GoogleFonts.nunito(
                fontSize: 15,
                //fontWeight: FontWeight.bold,
                color: ColorConstants.theme2Orange,
              ),
            ),
            DropdownButton<EnLocationType>(
              focusColor: ColorConstants.theme2Orange,
              value: selectedLocationType,
              style: GoogleFonts.nunito(color: ColorConstants.theme2Orange),
              dropdownColor: ColorConstants.theme2DarkBlue,
              isExpanded: true,
              onChanged: (EnLocationType? value) {
                selectedLocationType = value!;
                setState(() {});
              },
              items: EnLocationType.values
                  .map<DropdownMenuItem<EnLocationType>>(
                      (EnLocationType value) {
                return DropdownMenuItem<EnLocationType>(
                  value: value,
                  child: Text(value.getDisplayName()),
                );
              }).toList(),
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
                labelText: 'Sektör',
                labelStyle: GoogleFonts.nunito(
                  color: (industryController.value.text.isNotEmpty)
                      ? ColorConstants.theme1DarkBlue
                      : ColorConstants.warningDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (industryController.value.text.isNotEmpty)
                        ? ColorConstants.theme1DarkBlue
                        : ColorConstants.warningDark,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: industryController,
              cursorColor: ColorConstants.theme1DarkBlue,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tecrübe linki (isteğe bağlı)',
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
                addUserExperience(context);
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
    if (userExperience!.getStartDate() != null) {
      startDate = userExperience!.getStartDate()!;
      startDateController.text = ControlHelper.checkInputValue(
          UserInfoHelper.dateFormat.format(userExperience!.getStartDate()!));
    }
    if (userExperience!.getEndDate() != null) {
      endDate = userExperience!.getEndDate()!;
      endDateController.text = ControlHelper.checkInputValue(
          UserInfoHelper.dateFormat.format(userExperience!.getEndDate()!));
    }
  }
}
