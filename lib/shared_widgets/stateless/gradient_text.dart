import 'package:flutter/material.dart';
import 'package:masaj/shared_widgets/stateless/custom_text.dart';

/// A gradient text.
class GradientText extends StatelessWidget {
  /// Colors used to show the gradient.
  final List<Color> colors;

  /// Direction in which the gradient will be displayed.
  final GradientDirection? gradientDirection;

  /// The type of gradient to apply.
  final GradientType gradientType;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The radius of the gradient, as a fraction of the shortest side
  /// of the paint box.
  final double radius;

  /// If non-null, the style to use for this text.
  final TextStyle? style;

  /// The text to display.
  final String text;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How the text should be scaled.
  final double? textScaleFactor;

  /// Maximum number of lines for the text to span.
  final int? maxLines;

  /// Gradient stops
  final List<double>? stops;

  const GradientText(
    this.text, {
    required this.colors,
    this.gradientDirection = GradientDirection.ltr,
    this.gradientType = GradientType.linear,
    super.key,
    this.overflow,
    this.radius = 1.0,
    this.style,
    this.textAlign,
    this.stops,
    this.textScaleFactor,
    this.maxLines,
  }) : assert(
          colors.length >= 2,
          'Colors list must have at least two colors',
        );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        switch (gradientType) {
          case GradientType.linear:
            final Map<String, Alignment> map = {};
            switch (gradientDirection) {
              case GradientDirection.rtl:
                map['begin'] = Alignment.centerRight;
                map['end'] = Alignment.centerLeft;
              case GradientDirection.ttb:
                map['begin'] = Alignment.topCenter;
                map['end'] = Alignment.bottomCenter;
              case GradientDirection.btt:
                map['begin'] = Alignment.bottomCenter;
                map['end'] = Alignment.topCenter;
              default:
                map['begin'] = Alignment.centerLeft;
                map['end'] = Alignment.centerRight;
            }
            return LinearGradient(
              begin: map['begin']!,
              colors: colors,
              stops: stops,
              end: map['end']!,
            ).createShader(bounds);
          case GradientType.radial:
            return RadialGradient(
              colors: colors,
              radius: radius,
            ).createShader(bounds);
        }
      },
      child: CustomText(
        text: text,
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
      ),
    );
  }
}

/// The type of gradient to apply.
enum GradientType {
  /// A linear gradient.
  linear,

  /// A radial gradient.
  radial,
}

/// Direction to apply in the gradient.
enum GradientDirection {
  /// Bottom to top.
  btt,

  /// Left to right.
  ltr,

  /// Right to left.
  rtl,

  /// Top to bottom.
  ttb,
}
