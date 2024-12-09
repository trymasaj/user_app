import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';

// gradient text
class TextWithGradiant extends StatelessWidget {
  const TextWithGradiant(
      {super.key,
      required this.text,
      required this.fontSize,
      this.gradient,
      this.fontWeight = FontWeight.w400,
      this.maxLines = 1,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.start,
      this.disableGradiant = false,
      this.height,
      this.color});

  final String text;
  final double fontSize;
  final Gradient? gradient;
  final FontWeight fontWeight;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? color;
  final double? height;
  final bool disableGradiant;

  @override
  Widget build(BuildContext context) {
    if (disableGradiant)
      return CustomText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        maxLines: maxLines,
        textAlign: textAlign,
        color: color?? Colors.white,
      );
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          (gradient ?? AppColors.GRADIENT_COLOR).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: CustomText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,

        maxLines: maxLines,
        // overflow: overflow,
        textAlign: textAlign,
        color:color?? Colors.white ,
      ),
    );
  }
}
