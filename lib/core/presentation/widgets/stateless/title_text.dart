import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

///Don't use it with items or cards (inside any lists) because it uses SizeHelper inside it so the O(n) and the best solution here is to use SizeHelper from the outside and pass the result to every item/card by parameters so the big O will be O(1).
class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    this.subtractedSize = 0.0,
    this.color,
    this.margin,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.fontFamily,
    this.maxLines = 10,
  });

  final String text;
  final double subtractedSize;
  final Color? color;
  final EdgeInsets? margin;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final String? fontFamily;
  final int? maxLines;

  const TitleText.verySmall({
    Key? key,
    required String text,
    Color? color,
    EdgeInsets? margin,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          subtractedSize: 9.0,
          color: color,
          margin: margin,
          textAlign: textAlign,
          textDirection: textDirection,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const TitleText.small({
    Key? key,
    required String text,
    Color? color,
    EdgeInsets? margin,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          subtractedSize: 6.0,
          color: color,
          margin: margin,
          textAlign: textAlign,
          textDirection: textDirection,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const TitleText.medium({
    Key? key,
    required String text,
    Color? color,
    EdgeInsets? margin,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          subtractedSize: 4.0,
          color: color,
          margin: margin,
          textAlign: textAlign,
          textDirection: textDirection,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const TitleText.large({
    Key? key,
    required String text,
    Color? color,
    EdgeInsets? margin,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          subtractedSize: -6.0,
          color: color,
          margin: margin,
          textAlign: textAlign,
          textDirection: textDirection,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const TitleText.extraLarge({
    Key? key,
    required String text,
    Color? color,
    EdgeInsets? margin,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          subtractedSize: -14.0,
          color: color,
          margin: margin,
          textAlign: textAlign,
          textDirection: textDirection,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  @override
  Widget build(BuildContext context) {
    final textStyleBefore = Theme.of(context).textTheme.displayLarge!.copyWith(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        );

    final textStyleAfter = textStyleBefore.copyWith(
        fontSize: textStyleBefore.fontSize! - subtractedSize);
    Widget child = Text(
      text.tr(),
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
