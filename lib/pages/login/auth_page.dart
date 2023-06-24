import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/pages/home/home_screen_page.dart';
import 'package:guide_up/pages/login/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // loggedin
          if(snapshot.hasData){
            return HomeScreen();
          }

          //not loggedin
          else {
            return LoginPage();
          }
            },

    ),
    );
  }
}
