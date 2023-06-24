import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onSubmitted;
  final String? errorText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onSubmitted,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorText: errorText,
          errorStyle: TextStyle(color: Colors.red),
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
        ),
        onSubmitted: (_) {
          if (onSubmitted != null) {
            onSubmitted!();
          }
        },
      ),
    );
  }
}
