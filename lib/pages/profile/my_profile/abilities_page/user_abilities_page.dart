import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/user/user_abilities/user_abilities_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_abilities/user_abilities_model.dart';
import '../../../../ui/material/custom_material.dart';

class UserAbilitiesPage extends StatefulWidget {
  const UserAbilitiesPage({Key? key}) : super(key: key);

  @override
  State<UserAbilitiesPage> createState() => _UserAbilitiesPageState();
}

class _UserAbilitiesPageState extends State<UserAbilitiesPage> {
  TextEditingController abilityController = TextEditingController();
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

  void addAbility() async {
    String ability = abilityController.text.trim();
    if (ability.isNotEmpty) {
      UserAbilities userAbilities = UserAbilities();
      userAbilities.setUserId(userId!);
      userAbilities.setAbility(ability);

      try {
        await UserAbilitiesRepository().add(userAbilities);

        setState(() {
          abilityController.clear();
        });
        print('Ability added to Firebase: $ability');
      } catch (error) {
        print('Failed to add ability to Firebase: $error');
      }
    }
  }

  void deleteAbility(UserAbilities ability) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeteneği Sil',
              style: GoogleFonts.nunito(color: ColorConstants.itemWhite)),
          content: Text('Bu yeteneği silmek istediğinizden emin misiniz?',
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
                  await UserAbilitiesRepository().delete(ability);

                  setState(() {});

                  print('Ability added to Firebase: ${ability.getAbility() ?? "Unknown ability"}');
                } catch (error) {
                  print('Failed to delete ability from Firebase: $error');
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
        title: Text('Yetenekler',
        style: GoogleFonts.nunito( // Yetenekler yazısının yazı tipi
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: ColorConstants.theme2White, // AppBar arka plan rengi
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
    decoration: CustomMaterial.backgroundBoxDecoration,
    padding: const EdgeInsets.all(16.0),
    child:  Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Yeteneklerinizi şu an listeyemiyoruz.',
                      style: GoogleFonts.nunito(),
                    ),
                  );
                } else {
                  if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                    return Center(
                      child: Text('Yetenek kaydınız bulunamadı. Eklemeye ne dersiniz.',
                        style: GoogleFonts.nunito(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final ability = snapshot.data![index];
                        return Card(
                          color: ColorConstants.theme1DarkBlue, // Eklenen yetenekler tablo rengi
                          elevation: 2, // Card'ın gölgelendirme seviyesi
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(
                              ability.getAbility() ?? '',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.theme2Orange, // Yetenek metni rengi
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteAbility(ability),
                              color: ColorConstants.theme2Orange, // Silme butonu rengi
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
              future: UserAbilitiesRepository()
                  .getUserAbilitiesListByUserId(userId != null ? userId! : ""),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.theme2White,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: abilityController,
                              decoration: const InputDecoration(
                                hintText: 'Yetenek ekle',
                                border: InputBorder.none,
                              ),
                              cursorColor: ColorConstants.theme2Orange, // İmleç rengi
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            onPressed: addAbility,
                            icon: const Icon(
                              Icons.add,
                              color: ColorConstants.theme1DarkBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      ),
    );
  }
}
