import 'package:english_card/values/shared_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double currentSliderValue = 5;
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async{
    preferences = await SharedPreferences.getInstance();
    int value = preferences.getInt(SharedKey.counter) ?? 5;
    setState(() {
      currentSliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          "Your Control",
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        elevation: 1,
        leading: InkWell(
          onTap: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.setInt(SharedKey.counter, currentSliderValue.toInt());
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.secondColor,
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'How much a number word at once?',
              style: AppStyles.h4.copyWith(
                color: AppColors.greyText,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              '${currentSliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 150,
              ),
            ),
            const Spacer(),
            Slider(
              value: currentSliderValue,
              min: 5,
              max: 100,
              divisions: 19,
              activeColor: AppColors.primaryColor,
              // inactiveColor: AppColors.primaryColor,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                });
              },
            ),
            const Spacer(),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Slider to set',
                style: AppStyles.h5.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
