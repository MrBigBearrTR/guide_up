import 'package:flutter/material.dart';

class IntroPage2 extends StatefulWidget {
  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      color: Colors.white,
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
                        'assets/img/2.png',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1),
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    'MENTOR MÜ BULMAK İSTİYORSUN ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      height: -2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    'Alanında uzman mentorlerimiz ile görüş, kendinin en iyisi ol.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      height: 0,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
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
