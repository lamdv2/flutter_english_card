import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../models/english_today.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class DetailWordPage extends StatefulWidget {
  final List<EnglishToday> words;
  final int index;

  const DetailWordPage({Key? key, required this.words, required this.index})
      : super(key: key);

  @override
  State<DetailWordPage> createState() => _DetailWordPageState();
}

class _DetailWordPageState extends State<DetailWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          "Detail Word",
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        elevation: 4,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context, widget.words);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: GestureDetector(
        onDoubleTap: () async {
          setState(() {
            widget.words[widget.index].isFavorite =
                !widget.words[widget.index].isFavorite;
          });
        },
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LikeButton(
                    onTap: (isLiked) async {
                      setState(() {
                        widget.words[widget.index].isFavorite =
                            !widget.words[widget.index].isFavorite;
                      });
                      return widget.words[widget.index].isFavorite;
                    },
                    isLiked: widget.words[widget.index].isFavorite,
                    mainAxisAlignment: MainAxisAlignment.end,
                    size: 40,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return ImageIcon(
                        const AssetImage(AppAssets.heart),
                        color: isLiked ? Colors.red : Colors.white,
                        size: 40,
                      );
                    },
                  ),
                ),
                const Spacer(),
                AutoSizeText(
                  maxLines: 1,
                  widget.words[widget.index].noun!,
                  style: AppStyles.h2,
                  overflow: TextOverflow.fade,
                ),
                const Spacer(),
                const Spacer(),
              ],
            )),
      ),
    );
  }
}
