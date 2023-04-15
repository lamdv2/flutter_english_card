import 'package:english_card/pages/detail_word_page.dart';
import 'package:flutter/material.dart';

import '../models/english_today.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AllWordsPage extends StatefulWidget {
  final List<EnglishToday> words;

  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  @override
  Widget build(BuildContext context) {
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
          onTap: () async {
            Navigator.pop(context, widget.words);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        // child: GridView.count(
        //   crossAxisCount: 2,
        //   children: words
        //       .map(
        //         (e) => Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: AppColors.primaryColor,
        //           ),
        //           alignment: Alignment.center,
        //           margin: const EdgeInsets.all(8),
        //           child: Text('${e.noun}'),
        //         ),
        //       )
        //       .toList(),
        // ),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: widget.words.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: index % 2 == 0
                    ? AppColors.primaryColor
                    : AppColors.secondColor,
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    widget.words[index].isFavorite =
                        !widget.words[index].isFavorite;
                  });
                },
                leading: GestureDetector(
                  onTap: () async {
                    setState(() {
                      widget.words[index].isFavorite =
                          !widget.words[index].isFavorite;
                    });
                  },
                  child: ImageIcon(
                    const AssetImage(AppAssets.heart),
                    color: widget.words[index].isFavorite
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                trailing: InkWell(
                  child: const Icon(
                    Icons.menu,
                  ),
                  onTap: () async {
                    widget.words[index] = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailWordPage(
                                  words: widget.words,
                                  index: index,
                                )));
                    setState(() {
                      widget.words;
                    });
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    widget.words[index].noun!,
                    style: index % 2 == 0
                        ? AppStyles.h4
                        : AppStyles.h4.copyWith(color: AppColors.textColor),
                  ),
                ),
                subtitle: Text(
                  widget.words[index].quote ??
                      'Think of all the beauty still left around you and be happy',
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                splashColor: Colors.black26,
              ),
            );
          },
        ),
      ),
    );
  }
}
