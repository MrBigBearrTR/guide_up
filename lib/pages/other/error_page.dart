import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.theme1CloudBlue,
              ColorConstants.theme1White,
              ColorConstants.theme1PowderSkin,
              ColorConstants.theme1BrightCloudBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/img/404_error.png',
                  fit: BoxFit.none,
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  'Ooopps!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                    fontSize: 51,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.appcolor2,
                  )),
                ),
                Text(
                  'Aradığınız sayfayı bulamadık :(\n Geri dönmeye ne dersin!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  )),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RouterConstants.homePage);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorConstants.theme2Orange),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Text(
                          "Ana Sayfaya Dön",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  color: ColorConstants.theme1White,
                                  fontWeight: FontWeight.bold)),
                        )),
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
