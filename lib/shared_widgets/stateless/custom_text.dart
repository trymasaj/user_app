import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Don't use it with items or cards (inside any lists) because it uses SizeHelper inside it so the O(n) and the best solution here is to use SizeHelper from the outside and pass the result to every item/card by parameters so the big O will be O(1).
class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.subtractedSize = 0.0,
    this.color,
    this.margin,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.fontFamily,
    this.maxLines = 10,
    this.fontSize = 20,
    this.fixedFontSize,
    this.fontWeight,
    this.decoration,
  }) : super(key: key);

  final String text;
  final double subtractedSize;
  final Color? color;
  final EdgeInsets? margin;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final String? fontFamily;
  final int? maxLines;
  final double fontSize;
  final double? fixedFontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final textStyleAfter = TextStyle(
      fontSize:
          fixedFontSize ?? (min(fontSize.sp, fontSize) - subtractedSize.sp),
      fontFamily: 'Poppins',
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w600,
      decoration: decoration,
    );
    Widget child = Text(
      text.tr(context: context),
      softWrap: true,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      textDirection: textDirection,
      style: textStyleAfter,
    );

    if (margin != null) child = Padding(padding: margin!, child: child);

    return child;
  }
}
