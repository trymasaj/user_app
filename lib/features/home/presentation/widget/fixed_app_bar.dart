import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/address/presentation/overlay/select_location_bottom_sheet.dart';
import 'package:masaj/gen/assets.gen.dart';

class FixedAppBar extends StatelessWidget {
  const FixedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top * 1.5;

    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: topPadding + 60,
        maxHeight: topPadding + 60,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: topPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            SelectLocationBottomSheet.builder(context),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CustomText(
                          text: 'location',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(24, 27, 40, .7),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.images.imgFluentLocation48Filled,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              '2131 Street, Kuwait',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.FONT_COLOR),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              Assets.images.imgArrowDown,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // circle shape
                          shape: BoxShape.circle,
                          // border color
                          border: Border.all(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            width: 1,
                          ),
                        ),
                        child: SvgPicture.asset(
                          Assets.images.fluentPeopleCommunity20Regular,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // circle shape
                          shape: BoxShape.circle,
                          // border color
                          border: Border.all(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            width: 1,
                          ),
                        ),
                        child: SvgPicture.asset(
                          Assets.images.bell,
                          color: AppColors.ACCENT_COLOR,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
