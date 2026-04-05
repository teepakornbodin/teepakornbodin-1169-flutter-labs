import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/services/firestore_service.dart';

class QuizFirebaseResultScreen extends StatefulWidget {
  final List<Question> questions;
  final Map<int, int?> selectedAnswers;
  final int score;
  final VoidCallback onRestart;

  const QuizFirebaseResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
    required this.onRestart,
  });

  @override
  State<QuizFirebaseResultScreen> createState() =>
      _QuizFirebaseResultScreenState();
}

class _QuizFirebaseResultScreenState extends State<QuizFirebaseResultScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  late final Future<List<int>> _recentScoresFuture;
  late final Future<List<int>> _topScoresFuture;

  @override
  void initState() {
    super.initState();
    _saveScore();
    _recentScoresFuture = _firestoreService.fetchRecentScores();
    _topScoresFuture = _firestoreService.fetchTopScores();
  }

  Future<void> _saveScore() async {
    try {
      await _firestoreService.saveScore(widget.score, widget.questions.length);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save score: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Results'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Score header
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
                      '${widget.score} / ${widget.questions.length}',
                      style: textTheme.displayMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Question review list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  ...List.generate(widget.questions.length, (index) {
                    final question = widget.questions[index];
                    final correctIndex =
                        question.choices.indexWhere((c) => c.isCorrect);
                    final correctChoice = question.choices[correctIndex];
                    final selectedIndex = widget.selectedAnswers[index];
                    final isAnswered = selectedIndex != null;

                    String subtitleText;
                    Color subtitleColor;

                    if (!isAnswered) {
                      subtitleText =
                          'Not answered - Correct: ${correctChoice.name}';
                      subtitleColor = Colors.orange;
                    } else if (selectedIndex == correctIndex) {
                      subtitleText = '${correctChoice.name} \u2713';
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
                          backgroundColor:
                              isAnswered ? correctChoice.displayColor : null,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title:
                            Text(question.title, style: textTheme.titleLarge),
                        subtitle: Text(
                          subtitleText,
                          style: textTheme.titleMedium?.copyWith(
                            color: subtitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),

                  // Scores card
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<List<int>>(
                            future: _recentScoresFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const SizedBox.shrink();
                              if (snapshot.hasError) {
                                return const Text('Could not load recent scores');
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\u23f0 Recent Scores',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!.join('  ')),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<List<int>>(
                            future: _topScoresFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const SizedBox.shrink();
                              if (snapshot.hasError) {
                                return const Text('Could not load top scores');
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\U0001f3c6 Top Scores',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!.join('  ')),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Restart button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onRestart();
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
