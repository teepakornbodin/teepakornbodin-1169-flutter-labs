import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';

class QuestionChoiceCard extends StatefulWidget {
  final Choice choice;
  final bool isSelected;
  final bool canSelect;
  final VoidCallback onSelected;

  const QuestionChoiceCard({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.canSelect,
    required this.onSelected,
  });

  @override
  State<QuestionChoiceCard> createState() => _QuestionChoiceCardState();
}

class _QuestionChoiceCardState extends State<QuestionChoiceCard> {
  @override
  Widget build(BuildContext context) {
    // เปลี่ยนสีพื้นหลังตามสถานะการเลือก
    Color bgColor;
    if (widget.isSelected) {
      // สีเขียวถ้าถูกต้อง สีแดงถ้าไม่ถูกต้อง
      bgColor = widget.choice.isCorrect ? Colors.green : Colors.red;
    } else {
      // ใช้สีปกติถ้าไม่ได้เลือก
      bgColor = widget.choice.displayColor;
    }

    // สีข้อความที่ตามกับสีพื้นหลัง
    final textColor =
        ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return GestureDetector(
      onTap: widget.canSelect ? widget.onSelected : null,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(3),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            widget.choice.name,
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
