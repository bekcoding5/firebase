import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyElevatedButtonWithLogin extends StatelessWidget {
  VoidCallback onTap;
  final String text;
  EdgeInsets? padding;
  double? height;
  MyElevatedButtonWithLogin({
    required this.onTap,
    required this.text,
    this.padding,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
