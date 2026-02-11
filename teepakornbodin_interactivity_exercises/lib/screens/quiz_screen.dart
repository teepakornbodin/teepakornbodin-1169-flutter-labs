import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_interactivity_exercises/components/question_choice_card.dart';
import 'package:teepakornbodin_interactivity_exercises/utils/responsive.dart';

class QuizScreen extends StatefulWidget {
  final Question question;
  final ValueChanged<bool>? onAnswer;
  final bool showNextButton;
  final VoidCallback? onNext;

  const QuizScreen({
    super.key,
    required this.question,
    this.onAnswer,
    required this.showNextButton,
    this.onNext,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedIndex;
  bool selectionMade = false;

  void _handleChoiceSelected(int index) {
    if (selectionMade) return;
    final isCorrect = widget.question.choices[index].isCorrect;

    // Update state
    setState(() {
      selectedIndex = index;
      selectionMade = true;
    });
    // แจ้งผลลัพธ์การตอบกลับผ่าน callback
    widget.onAnswer?.call(isCorrect);
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
                    canSelect: !selectionMade,
                    onSelected: () => _handleChoiceSelected(index),
                  );
                },
              ),
            ),
          ),

          // กดปุ่ม Next แล้วแสดงคะแนน
          if (selectionMade && widget.showNextButton)
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 16)),
              ),
            ),
        ],
      ),
    );
  }
}
