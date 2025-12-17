// Quote Card widget that uses Expanded to divide vertical space.
// It displays a quote image on top and the author's name below.

// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-12-17

// ใช้ Ai อธิบาย Expanded children โครงสร้างของมัน

import 'package:flutter/material.dart';

void main() {
  runApp(const QuoteCard());
}

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text("My Favorite Quote"),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 500),
                    child: Image.asset(
                      'assets/images/licensed-image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Dalai',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Lama',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
