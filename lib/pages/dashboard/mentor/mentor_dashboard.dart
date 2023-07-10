import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({Key? key}) : super(key: key);

  @override
  State<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends State<MentorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CupertinoScrollbar.defaultThickness),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/img/unknown_user.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'HELİN GÜLER',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                const Text(
                  'helingüler@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
