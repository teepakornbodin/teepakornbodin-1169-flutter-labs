import 'package:flutter/material.dart';

class PetModel {
  final String name;
  final String imageUrl;
  final Color backgroundColor;
  final Color textColor;

  PetModel({
    required this.name,
    required this.imageUrl,
    this.backgroundColor = Colors.pinkAccent,
    this.textColor = Colors.white,
  });
}
