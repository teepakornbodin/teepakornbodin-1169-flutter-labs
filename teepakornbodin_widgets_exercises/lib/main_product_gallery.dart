// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-01-27

// Product Detail Layout
// Displays product details using Column, Row, Expanded, and SingleChildScrollView.
// Designed to handle long content without overflow while pinning the 'Add to Cart' button at the bottom.

// Logic: Divided into 2 columns—Column 1 has no padding, while Column 2 includes padding.
// Each row contains an Icon and a Value.
// Use AI to explain InkWell and SingleChildScrollView (enabling the description to be scrollable) // and how to fix the position of the bottomNavigationBar.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/product_model.dart';
import 'package:teepakornbodin_widgets_exercises/components/product_card.dart';
import 'package:teepakornbodin_widgets_exercises/screens/product_detail.dart';

void main() {
  runApp(const MainProductGallery());
}

class MainProductGallery extends StatelessWidget {
  const MainProductGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductModel.getProducts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product Gallery by 663040116-9'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: product),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
