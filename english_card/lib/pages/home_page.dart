import 'dart:math';

import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../models/english_today.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex = 0;
  late final PageController _pageController = PageController();

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 200, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newWord = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newWord.contains(val)) {
        continue;
      } else {
        newWord.add(val);
        count++;
      }
    }
    return newWord;
  }

  getEnglishToday() {
    List<String> getList = [];
    List<int> rans = fixedListRandom(len: 5, max: nouns.length);
    rans.forEach((element) {
      getList.add(nouns[element]);
    });

    words = getList.map((e) => EnglishToday(noun: e)).toList();
  }

  @override
  void initState() {
    getEnglishToday();
    super.initState();
  }

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
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: size.height * 1 / 10,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '"It is amazing It is amazing It is amazing It is amazing It is amazing "',
                  style: AppStyles.h5.copyWith(color: AppColors.textColor),
                ),
              ),
              Container(
                height: size.height * 2 / 3,
                alignment: Alignment.center,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    String firstLetter = words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0,1).toUpperCase();
                    String leftLetter = words[index].noun != null ? words[index].noun! : '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset(AppAssets.heart),
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: firstLetter,
                              style: const TextStyle(
                                fontFamily: FontFamily.sen,
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(3, 6),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              children: [
                                TextSpan(
                                  text: leftLetter,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.sen,
                                    fontSize: 36,
                                    fontWeight: FontWeight.normal,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(3, 6),
                                        blurRadius: 9,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 38.0),
                            child: Text(
                              '"Think of all the beauty still left around you and be happy"',
                              style: AppStyles.h4.copyWith(
                                  letterSpacing: .6,
                                  color: AppColors.textColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 12,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == _currentIndex, size);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 6),
              blurRadius: 9,
              color: Colors.black38,
            )
          ]),
    );
  }
}
