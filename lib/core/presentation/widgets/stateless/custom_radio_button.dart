import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton({
    super.key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.groupValue,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.gradient,
    this.backgroundColor,
  });

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  String? value;

  final String? groupValue;

  final Function(String) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final Gradient? gradient;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget,
          )
        : buildRadioButtonWidget;
  }

  bool get isGradient => gradient != null;

  BoxDecoration get gradientDecoration => BoxDecoration(gradient: gradient);

  Widget get buildRadioButtonWidget => InkWell(
        borderRadius: BorderRadius.circular(12.w),
        onTap: () {
          onChange(value!);
        },
        child: Container(
          decoration: decoration ??
              BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(
                  color: appTheme.blueGray100,
                  width: 1.w,
                ),
              ),
          width: width,
          padding: padding,
          child: (isRightCheck ?? false)
              ? rightSideRadioButton
              : leftSideRadioButton,
        ),
      );

  Widget get leftSideRadioButton => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: radioButtonWidget,
          ),
          textWidget,
        ],
      );

  Widget get rightSideRadioButton => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: radioButtonWidget,
          ),
        ],
      );

  Widget get textWidget => Text(
        text ?? '',
        textAlign: textAlignment ?? TextAlign.center,
        style: textStyle ?? theme.textTheme.titleSmall,
      );

  Widget get radioButtonWidget => SizedBox(
        height: iconSize,
        width: iconSize,
        child: Radio<String>(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? '',
          groupValue: groupValue,
          onChanged: (value) {
            onChange(value!);
          },
        ),
      );

  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: backgroundColor);
}

/// Extension on [CustomFloatingButton] to facilitate inclusion of all types of border style etc
extension RadioStyleHelper on CustomRadioButton {
  static BoxDecoration get gradientContainerToDeepOrange => BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        gradient: LinearGradient(
          begin: const Alignment(0.0, 0),
          end: const Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );

  static BoxDecoration gradientSecondaryContainerToDeepOrange(
          bool isSelected) =>
      BoxDecoration(
        border: isSelected
            ? Border.all(color: theme.colorScheme.secondaryContainer)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12.w),
        gradient: LinearGradient(
          begin: const Alignment(0.0, 0),
          end: const Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(12.w),
      );

  static BoxDecoration get fillGrayTL12 => BoxDecoration(
        color: appTheme.gray10001,
        borderRadius: BorderRadius.circular(12.w),
      );

  static BoxDecoration get outline => BoxDecoration(
        color: appTheme.gray10001,
        borderRadius: BorderRadius.circular(12.w),
      );
}
