import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_model.dart';
import 'package:guide_up/service/user/user_service.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../core/enumeration/enums/EnUserType.dart';
import '../../core/utils/user_helper.dart';
import '../../repository/user/user_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _register(BuildContext context) async {
    String email = _emailController.text; // trim ekle
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password == confirmPassword) {
      UserModel userModel = UserModel();
      userModel.setEmail(email);
      userModel.setPassword(password);

      List<String> unfilledFields = [];

      if (email.isEmpty) {
        unfilledFields.add("Email");
      }
      if (password.isEmpty) {
        unfilledFields.add("Şifre");
      }
      if (confirmPassword.isEmpty) {
        unfilledFields.add("Şifre Tekrarı");
      }

      if (unfilledFields.isNotEmpty) {
        String unfilledFieldsMessage =
            "Lütfen aşağıdaki alanları doldurun: " + unfilledFields.join(", ");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(unfilledFieldsMessage)),
        );
        return;
      }

      try {
        // Check if email is already registered
        bool isEmailRegistered =
            await UserHelper().isEmailRegistered(userModel.getEmail()!);
        if (isEmailRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Bu e-posta zaten kayıtlı")),
          );
          return;
        }
        String registeredUserId = await UserService().saveUserModel(userModel);
        // Kayıt başarılı, işlemleri devam ettirebilirsiniz.
        print('Kayıt başarılı: $registeredUserId');
        if (registeredUserId.isEmpty) {
          throw Exception('Kayıt bilgisi gelmedi  ');
        }
        Navigator.pushNamed(context, RouterConstants.registerWithDetailPage,
            arguments: registeredUserId);
      } catch (error) {
        // Kayıt başarısız, hata mesajını göster veya işlem yap.
        print('Kayıt başarısız: $error');
      }
    } else {
      // Parolalar uyuşmuyor, hata mesajını göster veya işlem yap.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Parolalar uyuşmuyor")),
      );
    }
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      Map<EnUserType, UserCredential> userTypeMap =
          await UserService().getUserStatusSignInWithGoogle();

      if (userTypeMap.isNotEmpty) {
        var entryMap = userTypeMap.entries.first;

        EnUserType userType = entryMap.key;
        UserCredential fireUser = entryMap.value;

        if (fireUser.user == null) {
          // Giriş başarısız, hata mesajını ele alabilirsiniz
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: ColorConstants.itemWhite,
                title: const Text('Hata'),
                content:
                    const Text('Google ile giriş yaparken bir hata oluştu.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Tamam',
                      style: TextStyle(
                        color: ColorConstants.itemBlack,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          switch (userType) {
            case EnUserType.havenNotUserModel:
              String userId = await UserService().saveUserModelOnlyUidAndEmail(
                  fireUser.user!.uid, fireUser.user!.email!);
              Navigator.pushNamed(
                  context, RouterConstants.registerWithDetailPage,
                  arguments: userId);

              break;
            case EnUserType.havenNotUserDetail:
              UserRepository()
                  .getUserIdByUid(fireUser.user!.uid)
                  .then((value) => {
                        if (value != null)
                          {
                            Navigator.pushNamed(
                                context, RouterConstants.registerWithDetailPage,
                                arguments: value)
                          }
                      });

              break;
            case EnUserType.haveUserDetail:
              Navigator.pushReplacementNamed(context, RouterConstants.homePage);
              break;
            default:
              break;
          }
        }
      }
    } catch (e) {
      // Hata oluştu, hata mesajını ele alabilirsiniz
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorConstants.itemWhite,
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
                    color: ColorConstants.itemBlack,
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
      body: Container(
        decoration: CustomMaterial.backgroundRegisterWithLoginDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'G u i d e U p ',
                          style: TextStyle(
                            height: 14,
                            fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.itemWhite,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/logo/guideUpLogoWithBackground.png',
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.appcolor2,
                      ColorConstants.appcolor3
                    ],
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
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          ' KAYIT OLUN ',
                          style: TextStyle(
                            color: ColorConstants.appcolor4,
                            fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepOrange, width: 1),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.deepOrange,
                                    blurRadius: 10,
                                    offset: Offset(1, 1)),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.email_outlined),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: _emailController,
                                    obscureText: false,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: "Email",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 1),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.deepOrange,
                                  blurRadius: 10,
                                  offset: Offset(1, 1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.key),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _passwordController,
                                  maxLines: 1,
                                  obscureText: passwordVisible,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Şifre",
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                          () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.deepOrange,
                                  blurRadius: 10,
                                  offset: Offset(1, 1)),
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.key),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  maxLines: 1,
                                  obscureText: passwordVisible,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Şifre Tekrarı",
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                          () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            _register(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.deepOrange,
                              elevation: 18,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Colors.deepOrange, Colors.orange]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              width: 400,
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text(
                                'Devam Et ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: ColorConstants.itemWhite,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Veya',
                                  style: TextStyle(
                                      color: Color(0xFFEF6C00),
                                      fontSize: 14,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 2,
                                color: ColorConstants.itemWhite,
                              ))
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signInWithGoogle(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.deepOrange,
                            elevation: 18,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.deepOrange, Colors.orange]),
                              borderRadius: BorderRadius.circular(20)),
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
                              Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Google İle Giriş Yap',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Üye misiniz ? ',
                            style: TextStyle(
                                color: ColorConstants.itemWhite,
                                fontFamily: 'Lato'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RouterConstants.loginPage);
                            },
                            child: const Text(
                              'Hemen Giriş Yapın',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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
