import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  final Color defaultColor;
  final Color ratingColor;
  const Ratings({
    super.key,
    required this.defaultColor,
    required this.ratingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: ratingColor),
        Icon(Icons.star, color: ratingColor),
        Icon(Icons.star, color: ratingColor),
        Icon(Icons.star, color: ratingColor),
        Icon(Icons.star, color: defaultColor),
      ],
    );
  }
}
