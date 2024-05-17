import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      required this.text,
      required this.imagePath,
      this.trailing = const SizedBox.shrink(),
      required this.onTap});

  final String text;
  final String imagePath;
  final VoidCallback onTap;
  final Widget trailing;
  final verticalPadding = 12;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(height: verticalPadding.h),
            InkWell(
              child: Row(children: [
                CustomImageView(
                    imagePath: imagePath,
                    height: 20.adaptSize,
                    width: 20.adaptSize),
                Padding(
                    padding: EdgeInsetsDirectional.only(start: 18.w),
                    child: Text(text.tr(), style: theme.textTheme.titleSmall)),
                const Spacer(),
                trailing,
              ]),
            ),
            SizedBox(height: verticalPadding.h),
            Divider(color: theme.colorScheme.onPrimary, indent: 30.w),
          ],
        ),
      ),
    );
  }
}
