import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_image.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_info.dart';
import 'package:teepakornbodin_widgets_exercises/components/ratings.dart';

class ProfileCardRatingResponsive extends StatelessWidget {
  const ProfileCardRatingResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.cyanAccent,
          padding: const EdgeInsets.all(20),
          child: orientation == Orientation.portrait
              ? _buildPortraitLayout()
              : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        ContactImage(imagePath: 'assets/images/youngj.jpg', name: 'Young J'),
        ContactInfo(
          addressName: 'Udon Thani',
          addressInfo: 'Udon Thani, Thailand 41000',
          email: 'youngj@email.com',
          phone: '(081) 123-4567',
        ),
        Ratings(defaultColor: Colors.black, ratingColor: Colors.lightGreen),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          child: Center(
            child: ContactImage(
              imagePath: 'assets/images/youngj.jpg',
              name: 'Young J',
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              ContactInfo(
                addressName: 'Udon Thani',
                addressInfo: 'Udon Thani, Thailand 41000',
                email: 'youngj@email.com',
                phone: '(081) 123-4567',
              ),
              Ratings(
                defaultColor: Colors.black,
                ratingColor: Colors.lightGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
