import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {Key? key,
      required this.text,
      required this.imagePath,
      this.trailing = const SizedBox.shrink(),
      required this.onTap})
      : super(key: key);
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
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(text.tr(), style: theme.textTheme.titleSmall)),
                Spacer(),
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
