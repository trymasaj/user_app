import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';
import 'package:masaj/gen/assets.gen.dart';
import 'package:masaj/main.dart';

class RepeatedSessions extends StatelessWidget {
  const RepeatedSessions({
    super.key,
  });

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
                SectionTitle(title: 'repeated_sessions'.tr()),
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
                  return GestureDetector(
                    onTap: () => navigatorKey.currentState!
                        .pushNamed(CheckoutScreen.routeName),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 280,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.GREY_LIGHT_COLOR_2,
                          width: 1,
                        ),
                      ),
                      child: Row(
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
                                  Assets.images.imgGroup8.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deep tissue massage',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.FONT_COLOR),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              // start from
                              Text(
                                'Start from',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.PlaceholderColor),
                              ),
                              Text(
                                'KD 10',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.FONT_COLOR),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
