import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/colors.dart';
import 'package:guide_up/pages/home/home_screen_page.dart';
import 'package:guide_up/pages/login/companenets/my_textfield.dart';
import 'package:guide_up/utils/uesr_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signInWithGoogle() async {
    try {
    User? fireUser = await Authentication.signInWithGoogle(context: context);
      if (fireUser != null) {
        // Giriş başarılı, kullanıcıyı kullanabilirsiniz
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Giriş başarısız, hata mesajını ele alabilirsiniz
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: itemWhite,
              title: const Text('Hata'),
              content: const Text('Google ile giriş yaparken bir hata oluştu.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Tamam',
                    style: TextStyle(
                      color: itemBlack,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Hata oluştu, hata mesajını ele alabilirsiniz
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: itemWhite,
            title: const Text('Hata'),
            content: Text('Google ile giriş yaparken bir hata oluştu: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Tamam',
                  style: TextStyle(
                    color: itemBlack,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }


  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    try {
      await UserHelper().login(emailController.text, passwordController.text);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: itemWhite,
            title: const Text('Hata'),
            content: Text('Şifre veya E-mail Hatalı Girildi'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam',
                  style: TextStyle(
                    color: itemBlack
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212832),
      body: SafeArea(
        child: Center(
          child:Center(
            child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  appcolor2,
                  appcolor2,
                  appcolor1,
                  appcolor1,
                ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topCenter,
                )
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  //LOGO
                  const SizedBox(height: 10),
                  Image.asset(
                    scale: 3,
                    'assets/img/GuideUpLogo.png',
                  ),

                  //WELCOME BACK
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'GuideUp ',
                      style: TextStyle(
                        color: itemWhite,
                        fontSize: 40,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Seni Burada Görmek Güzel  ',
                      style: TextStyle(
                        color: itemWhite,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  //USERNAME TEXTfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'E-mail',
                    obscureText: false,
                  ),


                  const SizedBox(height: 10),
                  //FORGOT PASSWORD ?
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Şifre',
                    obscureText: true,
                    onSubmitted: (){
                 signUserIn();
},
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Add your logic here for the "Şifremi Unuttum" button
                          },
                          child: const Text(
                            "Şifremi Unuttum",
                            style: TextStyle(
                              color: itemWhite,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //SİGN İN BUTTON
                  SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: signUserIn,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: appcolor4, backgroundColor: appcolor2,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        //shadowColor: appcolor2.withOpacity(0.1),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           SizedBox(width: 8),
                           Text(
                            'Giriş Yap',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  //CONTİNUE BUTTON
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            color: itemWhite,
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Veya',
                            style: TextStyle(color: Color(0xFFEF6C00),
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Expanded(child: Divider(
                          thickness: 2,
                          color: itemWhite,
                        ))
                      ],
                    ),
                  ),
                  //Image.asset(
                  // 'assets/img/Google.png',
                  // height: 50,
                  // ),
                  SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: appcolor4, backgroundColor: appcolor1,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        /*shadowColor: const Color(0xFF212832).withOpacity(0.2),
                        elevation: 10,*/
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              'assets/img/Google.png',
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Google ile Giriş Yap',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Üye değil misiniz ? ',
                        style: TextStyle(
                            color: itemWhite,
                            fontFamily: 'Lato'
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child: Text(
                          'Hemen Üye Olun',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )

                  // GOOGLE SİGN BUTTON
                  //REGİSTER
                ]
            ),
          ),
        ),
          ),
      ),
      ),
    );
  }
  }

