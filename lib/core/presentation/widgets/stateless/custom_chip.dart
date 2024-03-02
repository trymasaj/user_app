import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/presentation/widgets/stateless/gradient_text.dart';

class CustomChip<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onValueSelected;
  final double? width;
  final double? height;
  final bool? isExpanded;

  const CustomChip({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onValueSelected,
    this.width,
    this.height,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final child = GestureDetector(
      onTap: () => onValueSelected(value), // Calling the callback with value
      child: Container(
        width: width,
        height: height ?? 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: isSelected
              ? _buildGradientBorder()
              : Border.all(
                  color: Colors.transparent,
                ),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.9667],
                  colors: [
                    const Color(0xFFCCA3B7).withOpacity(0.1),
                    const Color(0xFFEDA674).withOpacity(0.1),
                  ],
                )
              : null,
          color: isSelected ? null : const Color(0xFFF6F6F6),
        ),
        child: GestureDetector(
          onTap: () => onValueSelected(value),
          child: GradientText(
            label,
            textAlign: TextAlign.center,
            colors: isSelected
                ? [
                    const Color(0xFFCCA3B7),
                    const Color(0xFFEDA674),
                  ]
                : [
                    const Color(0xFF8C8C8C).withOpacity(0.7),
                    const Color(0xFF8C8C8C).withOpacity(0.7),
                  ],
          ),
        ),
      ),
    );

    if (isExpanded ?? false) {
      return Expanded(child: child);
    }
    return child;
  }

  GradientBoxBorder _buildGradientBorder() {
    return const GradientBoxBorder(
      gradient: LinearGradient(colors: [
        Color(0xFFCCA3B7),
        Color(0xFFEDA674),
      ]),
      width: 1,
    );
  }
}

GradientBoxBorder appGradinatBorder({
  List<Color>? colors,
  double? width,
}) =>
    GradientBoxBorder(
      gradient: LinearGradient(
        colors: colors ??
            [
              const Color(0xFFCCA3B7),
              const Color(0xFFEDA674),
            ],
      ),
      width: width ?? 1,
    );

class AppContainerWithGradinatBorder extends StatelessWidget {
  const AppContainerWithGradinatBorder(
      {super.key,
      this.borderRadius,
      this.width,
      this.height,
      this.child,
      this.colors,
      this.borderWidth,
      this.constraints,
      this.margin,
      this.padding,
      this.alignment,
      this.image,
      this.position,
      this.gradient,
      this.shape});

  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Widget? child;
  final List<Color>? colors;
  final double? borderWidth;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final DecorationImage? image;
  final DecorationPosition? position;
  final BoxShape? shape;

  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              colors: colors ??
                  [
//                 #CCA3B7
// 9%
// #EDA674
// 9%
// #EFB287
// 9%
                    const Color(0xFFCCA3B7).withOpacity(0.09),
                    const Color(0xFFEDA674).withOpacity(0.09),
                    const Color(0xFFEFB287).withOpacity(0.09),
                  ],
            ),
        image: image,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
        border: appGradinatBorder(
          colors: colors,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
