import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';

class IntroPage4 extends StatefulWidget {
  @override
  _IntroPage4State createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0), // Metnin gecikmeli olarak görünmesi için animasyonun ikinci yarısını kullanıyoruz
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.darkBack,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Align(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: Offset(0, -50),
                    child: Transform.scale(
                      scale: _animation.value,
                      child: Image.asset(
                        'assets/img/4.png',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20), // Kenar boşluklarını ayarlayın
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Text(
                    'İHTİYACIN OLAN HER ŞEY İÇİN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstants.textwhite,
                      height: -1,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21), // Kenar boşluklarını ayarlayın
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Text(
                    'GUIDE UP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstants.textwhite,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
