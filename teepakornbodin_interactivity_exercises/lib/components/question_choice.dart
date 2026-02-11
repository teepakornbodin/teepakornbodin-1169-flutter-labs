import 'package:flutter/material.dart';

class QuestionChoice extends StatefulWidget {
  final String name;
  final Color bgColor;
  final Color? fgColor;
  final bool correct;

  const QuestionChoice({
    super.key,
    required this.name,
    required this.bgColor,
    this.fgColor,
    required this.correct,
  });

  @override
  State<QuestionChoice> createState() => _QuestionChoiceState();
}

class _QuestionChoiceState extends State<QuestionChoice> {
  bool _isTapped = false;

  void _handleTap() {
    // ถ้าถูกกดแล้ว ไม่ทำอะไร
    if (_isTapped) return;

    // กดแล้ว
    setState(() {
      _isTapped = true;
    });

    // Show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.correct ? 'Correct!' : 'Incorrect'),
          content: Text('Your score is ${widget.correct ? 1 : 0}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // กำหนดสีพื้นหลัง
    Color displayBgColor = widget.bgColor;
    if (_isTapped) {
      displayBgColor = widget.correct ? Colors.green : Colors.red;
    }

    // กำหนดสีตัวอักษร
    final textColor =
        widget.fgColor ??
        (ThemeData.estimateBrightnessForColor(displayBgColor) == Brightness.dark
            ? Colors.white
            : Colors.black);

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
          color: displayBgColor,
          borderRadius: BorderRadius.circular(3),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
