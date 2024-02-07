import 'package:masaj/core/app_export.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAddressTile extends StatelessWidget {
  const MyAddressTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    required this.subTitle,
    required this.isPrimary,
    this.isRadioButtonVisible = true,
  });

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
        decoration: AppDecoration.outlineBluegray100.copyWith(
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
                value: isPrimary,
                groupValue: true,
                onChanged: (value) {},
              ),
          ],
        ),
      ),
    );
  }
}
