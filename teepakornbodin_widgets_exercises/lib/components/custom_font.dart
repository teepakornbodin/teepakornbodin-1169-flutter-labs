import 'package:flutter/material.dart';

class CustomFont extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomFont({
    Key? key,
    required this.text,
    this.fontFamily,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 154, 154),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
