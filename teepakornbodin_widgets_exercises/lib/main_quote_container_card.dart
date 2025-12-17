// Quote Container Card widget.
// This widget enhances the quote card by using a styled Container
// with padding, margin, border, and rounded corners to highlight
// the author's name.
//
// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-12-17
//
// ใช้ Ai อธิบาย Spacer เปรียบกับ SizedBox

import 'package:flutter/material.dart';

void main() {
  runApp(const QuoteContainerCard());
}

class QuoteContainerCard extends StatelessWidget {
  const QuoteContainerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text(
            'My Favorite Quote',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ดันบน
              const Spacer(),

              // Image
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 500),
                  child: Image.asset(
                    'assets/images/licensed-image.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ชื่อผู้เขียนใน Container
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  border: Border.all(
                    color: const Color.fromARGB(255, 201, 2, 68),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Dalai',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Lama',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              //ดันล่าง
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
