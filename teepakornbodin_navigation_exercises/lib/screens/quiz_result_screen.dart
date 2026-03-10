import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';

class QuizResultScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, int?> selectedAnswers;
  final int score;
  final VoidCallback onRestart;

  const QuizResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Results'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            // Score header
            SizedBox(height: 30),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your Score',
                      style: textTheme.headlineLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score / ${questions.length}',
                      style: textTheme.displayMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Question list
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];

                  // หา choice ที่ถูกต้องจาก question.choices
                  final correctIndex = question.choices.indexWhere(
                    (c) => c.isCorrect,
                  );
                  final correctChoice = question.choices[correctIndex];

                  final selectedIndex = selectedAnswers[index];
                  final isAnswered = selectedIndex != null;

                  // สร้าง subtitle text and color
                  String subtitleText;
                  Color subtitleColor;

                  if (!isAnswered) {
                    subtitleText =
                        'Not answered - Correct: ${correctChoice.name}';
                    subtitleColor = Colors.orange;
                  } else if (selectedIndex == correctIndex) {
                    subtitleText = '${correctChoice.name} ✓';
                    subtitleColor = Colors.green;
                  } else {
                    final answerChoice = question.choices[selectedIndex];
                    subtitleText =
                        '${answerChoice.name} x Should be ${correctChoice.name}';
                    subtitleColor = Colors.red;
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        // ถ้าไม่ได้ตอบ ไม่มีสี null = default
                        backgroundColor: isAnswered
                            ? correctChoice.displayColor
                            : null,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(question.title, style: textTheme.titleLarge),
                      subtitle: Text(
                        subtitleText,
                        style: textTheme.titleMedium?.copyWith(
                          color: subtitleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Restart button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onRestart();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Restart',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
