import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/colors.dart';


class MyButton extends StatelessWidget {
  final Function() ? onTap ;


  const MyButton({Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const  EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: appcolor3,
            borderRadius: BorderRadius.circular(8)
        ),
        child: const Center(
          child: Text(
            "Giriş Yap ",
            style: TextStyle(
                color: itemWhite,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
