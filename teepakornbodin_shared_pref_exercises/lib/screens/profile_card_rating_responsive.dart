import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_image.dart';
import 'package:teepakornbodin_widgets_exercises/components/contact_info.dart';
import 'package:teepakornbodin_shared_pref_exercises/components/interactive_ratings.dart';

class ProfileCardRatingResponsive extends StatelessWidget {
  final SharedPreferencesWithCache prefs;

  const ProfileCardRatingResponsive({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: orientation == Orientation.portrait
              ? _buildPortraitLayout(context)
              : _buildLandscapeLayout(context),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const ContactImage(
          imagePath: 'assets/images/youngj.jpg',
          name: 'Young J',
        ),
        const ContactInfo(
          addressName: 'Udon Thani',
          addressInfo: 'Udon Thani, Thailand 41000',
          email: 'youngj@email.com',
          phone: '(081) 123-4567',
        ),
        InteractiveRatings(
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.outlineVariant,
          prefs: prefs,
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
            children: [
              const ContactInfo(
                addressName: 'Udon Thani',
                addressInfo: 'Udon Thani, Thailand 41000',
                email: 'youngj@email.com',
                phone: '(081) 123-4567',
              ),
              InteractiveRatings(
                activeColor: colorScheme.primary,
                inactiveColor: colorScheme.outlineVariant,
                prefs: prefs,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
