// An interactive star rating widget.
// Logic: Uses StatefulWidget to track rating state and GestureDetector for tap handling.
// Tapping a star fills all stars up to that position.

import 'package:flutter/material.dart';

class InteractiveRatings extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final int totalStars;
  final double starSize;
  final double spacing;

  const InteractiveRatings({
    super.key,
    required this.activeColor,
    required this.inactiveColor,
    this.totalStars = 5,
    this.starSize = 24.0,
    this.spacing = 4.0,
  });

  @override
  State<InteractiveRatings> createState() => _InteractiveRatingsState();
}

class _InteractiveRatingsState extends State<InteractiveRatings> {
  int starRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.totalStars,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              starRating = index + 1;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: widget.spacing),
            child: Icon(
              Icons.star,
              size: widget.starSize,
              color: index < starRating
                  ? widget.activeColor
                  : widget.inactiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
