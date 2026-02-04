import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/profile_with_button_model.dart';

Widget _submitButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      textStyle: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal),
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to submit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
    child: const Text('Submit'),
  );
}

Widget profileHeader(BuildContext context, String name, String studentId) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Text(
          studentId,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

class ProfileWithButton extends StatelessWidget {
  final ProfileWithButtonModel model;

  const ProfileWithButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          profileHeader(context, model.name, model.studentId),
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(model.imagePath, fit: BoxFit.cover),
          ),
          Text(
            'Photo Credit : ${model.photoCredit}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          _submitButton(context),
        ],
      ),
    );
  }
}
