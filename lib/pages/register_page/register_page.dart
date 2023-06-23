import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/pages/login/companenets/my_textfield.dart';
import 'package:guide_up/pages/login/login_page.dart';
import 'package:guide_up/utils/user_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  String? selectedRole;

  bool _passwordsMatch = true;

  final UserHelper _userHelper = UserHelper();

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _register() async {
    if (_password.text == _confirmPassword.text) {
      // Passwords match, proceed with registration logic
      _passwordsMatch = true;

      try {
        await _userHelper.register(
          _name.text,
          _surname.text,
          _email.text,
          _password.text,
          _confirmPassword.text,
          selectedRole ?? "",
        );
        // Registration successful, navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        // Registration failed, handle the error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Passwords don't match
      setState(() {
        _passwordsMatch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topCenter,
            colors: [
              ColorConstants.appcolor2,
              ColorConstants.appcolor2,
              ColorConstants.appcolor1,
              ColorConstants.appcolor1,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/GuideUpLogo.png',
                          scale: 3,
                        ),
                        const Text(
                          'GuideUp Kayıt Ol',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 60,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(
                                color: ColorConstants.info,
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorConstants.appcolor2, ColorConstants.appcolor3],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 2000,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: _name,
                        hintText: 'Adınız:',
                        obscureText: false,
                        onSubmitted: () {},
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        controller: _surname,
                        hintText: 'Soyadınız:',
                        obscureText: false,
                        onSubmitted: () {},
                      ),
                      const SizedBox(height: 12),

                      MyTextField(
                        controller: _email,
                        hintText: 'E-mail',
                        obscureText: false,
                        onSubmitted: () {},
                      ),
                      const SizedBox(height: 12),

                      MyTextField(
                        controller: _password,
                        hintText: 'Şifreniz',
                        obscureText: false,
                        onSubmitted: () {},
                      ),
                      const SizedBox(height: 12),

                      MyTextField(
                        controller: _confirmPassword,
                        hintText: 'Şifre Tekrarı',
                        obscureText: false,
                        onSubmitted: () {},
                        errorText: _passwordsMatch ? null : 'Parolalar uyuşmuyor',
                      ),
                      SizedBox(height: 20,) ,
                      SizedBox(
                        width: 410,
                        height: 60,
                        child: Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: Colors.transparent, // Background color
                            borderRadius: BorderRadius.circular(3.0),
                            border:  Border.all(
                              color: Colors.white ,
                              width: 1.0,
                            )// Radius
                          ),
                          child: DropdownButton<String>(
                            value: selectedRole,
                            hint: const Text('Kullanıcı Seçiniz?', style: TextStyle( color: Colors.white),),
                            onChanged: (newValue) {
                              setState(() {
                                selectedRole = newValue;
                              });
                            },
                            items: <String>[
                              'Mentor',
                              'Mentee',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    backgroundColor: ColorConstants.appcolor2,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,) ,
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                            onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ColorConstants.appcolor4,
                            backgroundColor: ColorConstants.appcolor2,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            //shadowColor: ColorConstants.appcolor2.withOpacity(0.1),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 8),
                              Text(
                                'Kayıt Ol  ',
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
                    ],

                  ),

                ),
              ),


            ],
          ),

        ),

      ),

    );

  }
}

