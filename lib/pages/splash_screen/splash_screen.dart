import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/secure_strorage_constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intro_page_1.dart';
import 'intro_page_2.dart';
import 'intro_page_3.dart';
import 'intro_page_4.dart';
import 'intro_page_5.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen ({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _controller = PageController();
  int currentPage = 0;
  FlutterSecureStorage preference = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
              IntroPage5(),
            ],
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Visibility(
                  visible: currentPage < 4,
                  child:ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeIn,
                      );
                    },
                  style: ElevatedButton.styleFrom(
                shadowColor: ColorConstants.buttonPurple,
                elevation: 18,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [ColorConstants.buttonPurple, ColorConstants.buttonPink]),
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 300,
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  'Devam Et ',
                  style: TextStyle(
                    fontSize: 25,
                    color: ColorConstants.textwhite,
                  ),
                ),

              ),
            ),
    ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage == 4) {

                      preference.write(key: SecureStrogeConstants.FIRST_SIGIN_KEY, value: "Y");
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      _controller.jumpToPage(4); // Ana sayfaya git
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: ColorConstants.buttonPurple,
                      elevation: 18,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: 300,
                      height: 40,
                      alignment: Alignment.center,
                  child: Text(
                    currentPage == 4 ? 'Ana Sayfa' : 'Atla',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF2E393F),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

            ),
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(controller: _controller, count: 5, ),
              ],
            ),
          )
        ],
      ),
          )
    ],
    )
    );
  }
}
