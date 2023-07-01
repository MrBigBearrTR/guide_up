import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/router_constants.dart';

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
        title: const Text('Yetenekler'),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.myProfileAccountPage);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yeteneklerinizi Ekleyin',
              style: TextStyle(
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
                    decoration: const InputDecoration(
                      hintText: 'Yetenek',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: addAbility,
                  child: const Text('Ekle'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Yetenekleriniz',
              style: TextStyle(
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
    );
  }
}
