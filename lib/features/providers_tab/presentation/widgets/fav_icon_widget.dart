import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class FavIconWidget extends StatelessWidget {
  const FavIconWidget({
    super.key,
    required this.isFav,
    this.onTap,
    this.heaight,
    this.width,
    this.padding,
  });

  final bool isFav;
  final VoidCallback? onTap;
  final double? heaight;
  final double? width;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,

      onTap: onTap,
      child: Container(
          padding: padding ?? EdgeInsets.all(11.h),
          width: width ?? 44.w,
          height: heaight ?? 44.h,
          decoration: BoxDecoration(
            color: isFav
                ? const Color(0xffEDA67433).withOpacity(.2)
                : AppColors.ExtraLight,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            isFav ? 'assets/images/heart.svg' : 'assets/images/black_heart.svg',
          )),
    );
  }
}
