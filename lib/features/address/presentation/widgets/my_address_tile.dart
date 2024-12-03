import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/decoration/app_decoration.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_radio_button.dart';

import '../../domain/entities/my_address_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAddressTile extends StatelessWidget {
  MyAddressTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    required this.subTitle,
    required this.isPrimary,
    this.isRadioButtonVisible = true,
  }) : super(
          key: key,
        );

  final String imagePath, title, subTitle;
  final bool isPrimary;
  final bool isRadioButtonVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 11.h,
        ),
        decoration: isPrimary == true
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFCCA3B7).withOpacity(0.09),
                    const Color(0xFFEDA674).withOpacity(0.09),
                    const Color(0xFFEFB287).withOpacity(0.09),
                  ],
                ),
                borderRadius: BorderRadiusStyle.roundedBorder12,
                border: GradientBoxBorder(
                  gradient: AppColors.GRADIENT_COLOR,
                  width: 1,
                ))
            : AppDecoration.outlineBluegray100.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 18.adaptSize,
              width: 18.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 11.h),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      subTitle,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            if (isRadioButtonVisible)
              Radio(
                value: this.isPrimary,
                groupValue: true,
                onChanged: (value) {},
              ),
          ],
        ),
      ),
    );
  }
}
