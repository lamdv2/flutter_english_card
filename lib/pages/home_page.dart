import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_card/packages/quote/quote.dart';
import 'package:english_card/pages/all_words_page.dart';
import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:english_card/values/shared_key.dart';
import 'package:english_card/widgets/drawer.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/english_today.dart';
import '../packages/quote/quote_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex = 0;
  late final PageController _pageController = PageController();

  List<EnglishToday> words = [];
  String? quote;

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

  int lenword = 5;

  getEnglishToday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    lenword = preferences.getInt(SharedKey.counter) ?? 5;

    List<String> getList = [];
    List<int> randoms = fixedListRandom(len: lenword, max: nouns.length);
    for (var element in randoms) {
      getList.add(nouns[element]);
    }

    setState(() {
      words = getList.map((e) => getWords(e)).toList();
      quote = Quotes().getRandom().content;
    });
  }

  EnglishToday getWords(noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      id: quote?.id,
      noun: noun,
      quote: quote?.content ??
          'Think of all the beauty still left around you and be happy',
    );
  }

  @override
  void initState() {
    super.initState();
    getEnglishToday();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
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
                child: AutoSizeText(
                  '"$quote"',
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
                    String firstLetter = words[index].noun ?? '';
                    firstLetter = firstLetter.substring(0, 1).toUpperCase();
                    String leftLetter = words[index].noun ?? '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            blurRadius: 6,
                            color: Colors.black26,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child: Material(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 4,
                        child: InkWell(
                          onDoubleTap: () {
                            setState(() {
                              words[index].isFavorite =
                                  !words[index].isFavorite;
                            });
                          },
                          splashColor: Colors.black26,
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceOut,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LikeButton(
                                  onTap: (isLiked) async {
                                    setState(() {
                                      words[index].isFavorite =
                                          !words[index].isFavorite;
                                    });
                                    return words[index].isFavorite;
                                  },
                                  isLiked: words[index].isFavorite,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  size: 40,
                                  circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return ImageIcon(
                                      const AssetImage(AppAssets.heart),
                                      color:
                                          isLiked ? Colors.red : Colors.white,
                                      size: 40,
                                    );
                                  },
                                ),
                                // Container(
                                //   alignment: Alignment.centerRight,
                                //   child: Image.asset(
                                //     AppAssets.heart,
                                //     color: words[index].isFavorite
                                //         ? Colors.red
                                //         : Colors.white,
                                //   ),
                                // ),
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
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child: AutoSizeText(
                                    '"${words[index].quote}"',
                                    style: AppStyles.h4.copyWith(
                                        letterSpacing: .6,
                                        color: AppColors.textColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _currentIndex >= 5
                  ? buildShowMore()
                  : Container(
                      height: 12,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lenword,
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
      drawer: const DrawerWidget(),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
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

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.primaryColor,
        elevation: 4,
        child: InkWell(
          onTap: () async{
            words = await Navigator.push(context,
                MaterialPageRoute(builder: (_) => AllWordsPage(words: words)));
            setState(() {
              words;
            });
          },
          splashColor: Colors.black26,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: const Text('Show More'),
          ),
        ),
      ),
    );
  }
}
