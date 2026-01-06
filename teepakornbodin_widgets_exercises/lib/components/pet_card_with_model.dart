import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/pet_model.dart';

class PetCardWithModel extends StatelessWidget {
  final PetModel pet;

  const PetCardWithModel({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            pet.imageUrl,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: pet.backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            pet.name,
            style: TextStyle(
              color: pet.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
