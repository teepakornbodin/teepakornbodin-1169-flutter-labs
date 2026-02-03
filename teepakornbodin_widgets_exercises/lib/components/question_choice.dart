import 'package:flutter/material.dart';

class QuestionChoice extends StatelessWidget {
  final String name;
  final Color bgColor;
  final Color? fgColor;

  const QuestionChoice({
    super.key,
    required this.name,
    required this.bgColor,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        fgColor ??
        (ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
            ? Colors.white
            : Colors.black);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
