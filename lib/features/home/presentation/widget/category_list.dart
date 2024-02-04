import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/features/focus_area/presentation/pages/focus_area_page.dart';
import 'package:masaj/gen/assets.gen.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 125,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            //todo : remove after finish testing.....
            return GestureDetector(
              onTap: () {
                NavigatorHelper.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const FocusAreaPage(),
                      ),
                    )
                    .then((value) => log(value.toString()));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.GREY_LIGHT_COLOR_2,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // image
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.GREY_LIGHT_COLOR_2,
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage(
                            Assets.images.imgGroup8.path,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Massage',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.FONT_COLOR),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
