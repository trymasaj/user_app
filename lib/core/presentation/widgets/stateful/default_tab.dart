import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/grediant_border.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';

class DefaultTab extends StatelessWidget {
  const DefaultTab({super.key, required this.isSelected, required this.title, this.borderRadius, this.isMemberScreen = false});

  final bool isSelected;
  final String title;
  final BorderRadius? borderRadius;
  final bool isMemberScreen;

  @override
  Widget build(BuildContext context) {
    return Tab(
        height: isMemberScreen ? 56.h : 40.h,
        iconMargin: EdgeInsets.zero,
        child: Container(
          height: isMemberScreen ? 56.h : 40.h,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected
                ? null
                : isMemberScreen
                    ? AppColors.White
                    : AppColors.ExtraLight,
            gradient: isSelected ? AppColors.GRADIENT_Fill_COLOR : null,
            border: isSelected
                ? GradientBoxBorder(
                    gradient: AppColors.GRADIENT_COLOR,
                    width: 1,
                  )
                : Border.all(color: const Color(0xffD9D9D9), width: 1),
            borderRadius: borderRadius ?? BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: isSelected
              ? TextWithGradiant(
                  text: title,
                  fontSize: 14,
                  fontWeight: isMemberScreen ?FontWeight.w400: FontWeight.w700,
                )
              : CustomText(
                  text: title,
                  fontSize: 14,
                  //rgba(24, 27, 40, 0.4)
                  color:isMemberScreen ? AppColors.PlaceholderColor: const Color.fromARGB(255, 24, 27, 40).withOpacity(.4),
                  fontWeight: isMemberScreen ?FontWeight.w400: FontWeight.w700,
                ),
        ));
  }
}
