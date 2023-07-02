import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/color_constants.dart';
import '../../../../ui/material/custom_material.dart';

class Abilities extends StatefulWidget {
  const Abilities({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AbilitiesState createState() => _AbilitiesState();
}

class _AbilitiesState extends State<Abilities> {
  List<String> abilities = []; // Yetenekler listesi
  final TextEditingController _abilityController = TextEditingController();

  @override
  void dispose() {
    _abilityController.dispose();
    super.dispose();
  }

  void addAbility() {
    String ability = _abilityController.text.trim();
    if (ability.isNotEmpty && !abilities.contains(ability)) {
      setState(() {
        abilities.add(ability);
        _abilityController.clear();
      });
    }
  }

  void removeAbility(String ability) {
    setState(() {
      abilities.remove(ability);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yetenekler',
          style: GoogleFonts.nunito(),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () {
            Navigator.pop(context);
          },
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yeteneklerinizi Ekleyin',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _abilityController,
                      cursorColor: ColorConstants.warningDark,
                      style: const TextStyle(fontFamily: 'Nunito'), // Yazı tipi
                      decoration: const InputDecoration(
                        hintText: 'Yetenek',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: addAbility,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.warningDark,
                    ),
                    child: Text('Ekle',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.itemWhite, // Metin rengi
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Yetenekleriniz',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: abilities.length,
                itemBuilder: (BuildContext context, int index) {
                  final ability = abilities[index];
                  return ListTile(
                    title: Text(ability),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeAbility(ability),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
