import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/features/home/presentation/pages/search_screen.dart';
import 'package:masaj/gen/assets.gen.dart';
import 'package:masaj/res/style/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.ExtraLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.lib.res.assets.imgSearch,
              color: AppColors.PlaceholderColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                readOnly: true,
                onTap: () {
                  // Navigator.pushNamed(context, '/search');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                decoration: InputDecoration(
                  hintText: 'search'.tr(),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.PlaceholderColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}