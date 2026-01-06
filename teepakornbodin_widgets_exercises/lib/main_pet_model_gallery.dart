// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-1-3
// แอปแกลเลอรีสัตว์เลี้ยงที่ใช้ PetModel class
// และ PetCardWithModel widget เพื่อแสดงข้อมูลสัตว์เลี้ยง
// ใช้ ai recheck ว่าครบตามโจทย์หรือยัง

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/pets_gallery_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetsGalleryScreen(),
    ),
  );
}
