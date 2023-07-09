import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_education/user_education_model.dart';
import '../../../../repository/user/user_education/user_education_repository.dart';

class UserEducationInformationList extends StatefulWidget {
  final String? userId;

  const UserEducationInformationList({Key? key, required this.userId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserEducationInformationListState createState() =>
      _UserEducationInformationListState();
}

class _UserEducationInformationListState
    extends State<UserEducationInformationList> {
  void _deleteEducationInformation(UserEducation educationInformation) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eğitim Bilgisini Sil'),
          content: const Text(
              'Bu eğitim bilgisini silmek istediğinizden emin misiniz?'),
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
                  await UserEducationInformationRepository()
                      .delete(educationInformation);

                  setState(() {});

                  print(
                      'EducationInformation deleted from Firebase: $educationInformation');
                } catch (error) {
                  print(
                      'Failed to delete educationInformation from Firebase: $error');
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
        title: const Text('Eğitim Bilgileri'),
      ),
      body: FutureBuilder<List<UserEducation>>(
        future: UserEducationInformationRepository()
            .getUserEducationInformationListByUserId(widget.userId!),
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
                child: Text(
                    'Eğitim bilgisi kaydınız bulunamadı. Eklemeye ne dersiniz?'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final educationInformation = snapshot.data![index];
                  return ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Okul: ${educationInformation.getSchoolName() ?? ""}'),
                        if (educationInformation.getDepartment()?.isNotEmpty ==
                            true)
                          Text(
                              'Departman: ${educationInformation.getDepartment()}'),
                        Text(
                            'Başlangıç Tarihi: ${educationInformation.getStartDate() ?? ""}'),
                        if (educationInformation.getEndDate() != null)
                          Text(
                              'Bitiş Tarihi: ${educationInformation.getEndDate() ?? ""}'),
                        Text('Sınıf: ${educationInformation.getGrade() ?? ""}'),
                        if (educationInformation
                                .getActivitiesSocienties()
                                ?.isNotEmpty ==
                            true)
                          Text(
                              'Aktiviteler/Sosyal Faaliyetler: ${educationInformation.getActivitiesSocienties() ?? ""}'),
                        Text(
                            'Açıklama: ${educationInformation.getDescription() ?? ""}'),
                        if (educationInformation.getLink()?.isNotEmpty == true)
                          Text(
                              'Bağlantı: ${educationInformation.getLink() ?? ""}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteEducationInformation(educationInformation),
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
