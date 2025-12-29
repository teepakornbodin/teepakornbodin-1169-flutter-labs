// lib/components/pet_card.dart

import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  final String petName;
  final String petImagePath;

  const PetCard({super.key, required this.petName, required this.petImagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Image.network(
            petImagePath,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: 120,
            alignment: Alignment.center,
            color: Colors.pink,
            child: Text(
              petName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
