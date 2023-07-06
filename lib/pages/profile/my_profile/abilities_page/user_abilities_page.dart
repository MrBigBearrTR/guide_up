import 'package:flutter/material.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/repository/user/user_abilities/user_abilities_repository.dart';

import '../../../../core/constant/color_constants.dart';
import '../../../../core/models/users/user_abilities/user_abilities.dart';

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
        userId = tempUserId;
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
        UserAbilitiesRepository().add(userAbilities);

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
          title: const Text('Yeteneği Sil'),
          content:
              const Text('Bu yeteneği silmek istediğinizden emin misiniz?'),
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
                  await UserAbilitiesRepository().delete(ability);

                  setState(() {});

                  print(
                      'Ability added to Firebase: ${ability.getAbility() ?? "Unknown ability"}');
                } catch (error) {
                  print('Failed to delete ability from Firebase: $error');
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
        title: const Text('Yetenekler'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Yeteneklerinizi şu an listeyemiyoruz.'),
                  );
                } else {
                  if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                    return const Center(
                      child: Text(
                          'Yetenek kaydınız bulunamadı. Eklemeye ne dersiniz.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final ability = snapshot.data![index];
                        return ListTile(
                          title: Text(ability.getAbility() ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteAbility(ability),
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
                  child: TextField(
                    controller: abilityController,
                    decoration: const InputDecoration(
                      hintText: 'Yetenek ekle',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: addAbility,
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
