// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-12-29

// แอปที่แสดงการใช้ฟอนต์ที่กำหนดเองใน Flutter
// โดยใช้ CustomFont widget ที่สร้างขึ้นเอง
import 'package:flutter/material.dart';
import 'components/custom_font.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CustomFontScreen(),
    );
  }
}

class CustomFontScreen extends StatelessWidget {
  const CustomFontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            const CustomFont(
              text: 'ทีปกรบดินทร์ อินทะสร้อย ',
              fontFamily: 'Prompt',
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 1),

            //แบบ Light
            // const CustomFont(
            //   text: 'Teepakornbodin',
            //   fontFamily: 'Prompt',
            //   fontSize: 24.0,
            //   fontWeight: FontWeight.w300,
            // ),
          ],
        ),
      ),
    );
  }
}
