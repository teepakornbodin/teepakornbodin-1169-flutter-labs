// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-12-29

// แอปแกลเลอรีสัตว์เลี้ยงที่ใช้ Expanded widget
// ใช้ ai ในการอธิบาย ClipRRect widget และยกตัวอย่างการใช้งาน

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/pets_screen.dart';

void main() {
  runApp(const PetGallery());
}

class PetGallery extends StatelessWidget {
  const PetGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PetsScreen(),
    );
  }
}
