import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../core/utils/user_helper.dart';
import 'my_Profile_Account.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Positioned(
          top: 20,
          left: 0,
          child: Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2C4059),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.homePage);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFFEF6C00),
              ),
            ),
          ),
        ),
        title: Text(
          "Profilim",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.amber,
        items: const <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.search, size: 25),
          Icon(Icons.dashboard, size: 25),
          Icon(Icons.diversity_1, size: 25),
          Icon(Icons.comment, size: 25),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CupertinoScrollbar.defaultThickness),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C4059),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage('assets/img/img.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          "Helin Güler",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: const Color(0xFFEF6C00),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "@helindev",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFEF6C00),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF2C4059),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeProfileAccount(),),);},
                      child: ListTile(
                        leading: Container(
                          width: 30,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CupertinoColors.systemBlue.withOpacity(0.1),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.user_check,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                        title: Text(
                          "Hesabım",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CupertinoColors.systemBlue.withOpacity(0.1),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.angle_right,
                            size: 18.0,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.cog,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      title: Text(
                        "Genel Ayarlar",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.wallet,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      title: Text(
                        "Ödeme Yöntemleri",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        UserHelper().signOut();
                        Navigator.pushReplacementNamed(context, RouterConstants.homePage);
                      },
                      child: ListTile(
                        leading: Container(
                          width: 30,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CupertinoColors.systemBlue.withOpacity(0.1),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.alternate_sign_out,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                        title: Text(
                          "Çıkış Yap",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CupertinoColors.systemBlue.withOpacity(0.1),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.angle_right,
                            size: 18.0,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF2C4059),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.question_circle,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      title: Text(
                        "Yardım ve Destek",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.info_circle,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      title: Text(
                        "Hakkımızda",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
