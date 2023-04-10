import 'package:english_card/pages/home_page.dart';
import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to',
                  style: AppStyles.h3,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Expanded(
                        flex: 2,
                        child: Text(
                          'English',
                          style: AppStyles.h2.copyWith(
                            color: AppColors.blackGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: Expanded(
                        flex: 1,
                        child: Text(
                          'Quotes"',
                          textAlign: TextAlign.left,
                          style: AppStyles.h4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RawMaterialButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(),), (route) => false);
                  },
                  fillColor: AppColors.lightBlue,
                  child: Image.asset(AppAssets.rightArrow)),
            ),
          ],
        ),
      ),
    );
  }
}
