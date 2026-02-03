import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/question_choice.dart';
import 'package:teepakornbodin_widgets_exercises/utils/responsive.dart';

class QuestionWithChoicesResponsive extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<QuestionChoice> choices;

  const QuestionWithChoicesResponsive({
    super.key,
    required this.title,
    required this.imagePath,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPortraitMode = Responsive.isPortrait(context);

    return Padding(
      padding: Responsive.getScreenPadding(context),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: isPortraitMode ? 3 : 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
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
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  return choices[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
