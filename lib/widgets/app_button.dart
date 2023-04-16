import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? widthBtn;
  final AlignmentGeometry? alignmentGeometry;

  const AppButton(
      {Key? key, required this.label, required this.onTap, this.widthBtn, this.alignmentGeometry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: widthBtn ?? double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(3, 6), blurRadius: 6)
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        alignment: alignmentGeometry ?? Alignment.centerLeft,
        child: Text(
          label,
          style: AppStyles.h5.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}
