import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

// ignore: must_be_immutable
class AppbarSubtitleSeven extends StatelessWidget {
  AppbarSubtitleSeven({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          style: theme.textTheme.titleSmall!.copyWith(
            color: appTheme.gray90003,
          ),
        ),
      ),
    );
  }
}
