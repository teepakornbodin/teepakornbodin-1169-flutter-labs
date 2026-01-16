import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_info.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_image.dart';
import 'package:teepakornbodin_widgets_exercises/components/ratings.dart';

class ProfileCardRating extends StatelessWidget {
  const ProfileCardRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.cyanAccent),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ContactImage(
              imagePath: 'assets/images/youngj.jpg',
              name: 'Young J',
            ),
            ContactInfo(
              addressName: 'Udon Thani',
              addressInfo: 'Udon Thani, Thailand 41000',
              email: 'youngj@email.com',
              phone: '(081) 123-4567',
            ),
            Ratings(defaultColor: Colors.black, ratingColor: Colors.lightGreen),
          ],
        ),
      ),
    );
  }
}
