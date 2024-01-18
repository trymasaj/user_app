import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/gen/assets.gen.dart';

class Therapists extends StatelessWidget {
  const Therapists({
    super.key,
  });

  //Book with therapists

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(title: 'book_with_therapists'.tr()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TherapistWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TherapistWidget extends StatelessWidget {
  const TherapistWidget({
    super.key,
    this.withFiv = false,
  });

  final bool withFiv;

  @override
  Widget build(BuildContext context) {
    //TODO: test size
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: withFiv ? 300 : 280,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.GREY_LIGHT_COLOR_2,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // image
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.GREY_LIGHT_COLOR_2,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.lib.res.assets.imgGroup8.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Dr. Mahmoud Mohamed',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.FONT_COLOR,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // start from
                  const CustomText(
                      text: 'Sports massage specialist',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.PlaceholderColor),

                  // rating
                  Row(
                    children: [
                      // for loop
                      for (var i = 0; i < 5; i++)
                        const Icon(Icons.star,
                            color: Color(0xffFFBA49), size: 15)
                    ],
                  ),
                ],
              ),
            ],
          ),

          // fav icon in circle
          const Spacer(),
          if (withFiv)
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: const Color(0xffEDA674).withOpacity(.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.FONT_COLOR,
                size: 15,
              ),
            ),
        ],
      ),
    );
  }
}
