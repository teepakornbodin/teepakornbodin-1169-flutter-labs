// An interactive star rating widget.
// Logic: Uses StatefulWidget to track rating state and GestureDetector for tap handling.
// Tapping a star fills all stars up to that position.
// Persistence: Loads saved rating from SharedPreferences in initState() and saves on tap.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InteractiveRatings extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final SharedPreferencesWithCache prefs;
  final int totalStars;
  final double starSize;
  final double spacing;

  static const String _ratingKey = 'star_rating';

  const InteractiveRatings({
    super.key,
    required this.activeColor,
    required this.inactiveColor,
    required this.prefs,
    this.totalStars = 5,
    this.starSize = 24.0,
    this.spacing = 4.0,
  });

  @override
  State<InteractiveRatings> createState() => _InteractiveRatingsState();
}

class _InteractiveRatingsState extends State<InteractiveRatings> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    // SharedPreferencesWithCache อ่านค่าที่บันทึกไว้โดยไม่ต้องรอ async หลังจากสร้าง instance
    _rating = widget.prefs.getInt(InteractiveRatings._ratingKey) ?? 0;
  }

  void _setRating(int value) async {
    setState(() {
      _rating = value;
    });
    await widget.prefs.setInt(InteractiveRatings._ratingKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.totalStars,
        (index) => GestureDetector(
          onTap: () => _setRating(index + 1),
          child: Padding(
            padding: EdgeInsets.only(right: widget.spacing),
            child: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              size: widget.starSize,
              color: index < _rating
                  ? widget.activeColor
                  : widget.inactiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
