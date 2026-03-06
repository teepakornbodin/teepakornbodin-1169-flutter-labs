import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_interactivity_exercises/utils/responsive.dart';
import 'package:teepakornbodin_navigation_exercises/components/question_choice_card.dart';

class QuizScreen extends StatefulWidget {
  final Question question;
  final int? initialSelectedIndex;
  final bool isInitiallyAnswered;
  final ValueChanged<int> onChoiceSelected;

  const QuizScreen({
    super.key,
    required this.question,
    required this.initialSelectedIndex,
    required this.isInitiallyAnswered,
    required this.onChoiceSelected,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedIndex;
  // ลบ selectionMade เพราะไม่ lock แล้ว

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  //  เพิ่ม sync selectedIndex เมื่อ parent navigate ข้ามคำถาม
  @override
  void didUpdateWidget(covariant QuizScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelectedIndex != widget.initialSelectedIndex ||
        oldWidget.isInitiallyAnswered != widget.isInitiallyAnswered) {
      setState(() {
        selectedIndex = widget.initialSelectedIndex;
      });
    }
  }

  void _handleChoiceSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onChoiceSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortraitMode = Responsive.isPortrait(context);

    return Padding(
      padding: Responsive.getScreenPadding(context),
      child: Column(
        children: [
          // Question title
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.question.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Question image
          Expanded(
            flex: isPortraitMode ? 3 : 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                widget.question.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Choices grid
          Expanded(
            flex: isPortraitMode ? 2 : 4,
            child: Align(
              alignment: isPortraitMode
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: isPortraitMode
                    ? const EdgeInsets.all(1)
                    : const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: isPortraitMode ? 2.5 : 8,
                ),
                itemCount: widget.question.choices.length,
                itemBuilder: (context, index) {
                  return QuestionChoiceCard(
                    choice: widget.question.choices[index],
                    isSelected: selectedIndex == index,
                    canSelect: true, // เปลี่ยน: true เสมอ ไม่ lock
                    onSelected: () => _handleChoiceSelected(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
