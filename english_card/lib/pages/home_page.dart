import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          "English today",
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        elevation: 1,
        leading: InkWell(
          onTap: () {},
          child: Image.asset(AppAssets.menu),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: size.height*1/10,
                  alignment: Alignment.center,
                  child: Text('"It is amazing"', style: AppStyles.h5,),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: const [
                      Text('data'),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
