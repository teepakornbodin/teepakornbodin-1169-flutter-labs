import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen.dart';

class QuizScreenHome extends StatelessWidget {
  final Question question;
  final int? initialSelectedIndex;
  final bool isInitiallyAnswered;
  final ValueChanged<int> onChoiceSelected;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool showPreviousButton;
  final bool showNextButton;
  final bool isLastQuestion;

  const QuizScreenHome({
    super.key,
    required this.question,
    required this.initialSelectedIndex,
    required this.isInitiallyAnswered,
    required this.onChoiceSelected,
    required this.onPrevious,
    required this.onNext,
    required this.showPreviousButton,
    required this.showNextButton,
    required this.isLastQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ใช้ QuizScreen จาก Problem 1
        Expanded(
          child: QuizScreen(
            question: question,
            initialSelectedIndex: initialSelectedIndex,
            isInitiallyAnswered: isInitiallyAnswered,
            onChoiceSelected: onChoiceSelected,
          ),
        ),

        // Navigation  Previous , Home , Next
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous ซ่อนที่ Q1
              Visibility(
                visible: showPreviousButton,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: ElevatedButton(
                  onPressed: onPrevious,
                  child: const Text('Previous'),
                ),
              ),

              // Home
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Home'),
              ),

              // Next , Finish
              Visibility(
                visible: showNextButton,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: ElevatedButton(
                  onPressed: onNext,
                  child: Text(isLastQuestion ? 'Finish' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
