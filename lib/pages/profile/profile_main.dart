import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          "Profilim",
          style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CupertinoScrollbar.defaultThickness),
        child: Column(
          children: [
            SizedBox(
              width: 120, height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),child: Image(image: AssetImage("assets/img.png"),)),
            ),
            const SizedBox(height: 10),
            Text("Helin Güler", style: Theme.of(context).textTheme.headlineMedium),
            Text("@helindev", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            SizedBox(
                width:200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent , side: BorderSide.none, shape: StadiumBorder()),
                  child: const Text("Profili Düzenle", style: TextStyle(color: Colors.black87)),
                )),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            ListTile(
              leading: Container(
                width:30, height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: CupertinoColors.systemBlue.withOpacity(0.1),
                ),
                child: Icon(LineAwesomeIcons.cog, color:CupertinoColors.systemBlue),
              ),
              title: Text("Genel Ayarlar", style: Theme.of(context).textTheme.bodyLarge),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: CupertinoColors.systemBlue.withOpacity(0.1),
                ),
                child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
              )

            ),

            ListTile(
                leading: Container(
                  width:30, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.user_check, color:CupertinoColors.systemBlue),
                ),
                title: Text("Hesabım", style: Theme.of(context).textTheme.bodyLarge),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
                )

            ),

            ListTile(
                leading: Container(
                  width:30, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.wallet, color:CupertinoColors.systemBlue),
                ),
                title: Text("Ödeme Yöntemleri", style: Theme.of(context).textTheme.bodyLarge),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
                )

            ),

            ListTile(
                leading: Container(
                  width:30, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.alternate_sign_out, color:CupertinoColors.systemBlue),
                ),
                title: Text("Çıkış Yap", style: Theme.of(context).textTheme.bodyLarge),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
                )

            ),
            const Divider(),
            const SizedBox(height: 10),

            ListTile(
                leading: Container(
                  width:30, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.helping_hands, color:CupertinoColors.systemBlue),
                ),
                title: Text("Destek & Yardım", style: Theme.of(context).textTheme.bodyLarge),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
                )

            ),

            ListTile(
                leading: Container(
                  width:30, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.heart, color:CupertinoColors.systemBlue),
                ),
                title: Text("Hakkımızda", style: Theme.of(context).textTheme.bodyLarge),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: CupertinoColors.systemGrey),
                )

            )
          ],
        )
        ),
      )
    );
  }
}
