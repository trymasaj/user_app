import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/gen/assets.gen.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/BookingDetialsScreen');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: //,
            //  EdgeInsets.fromLTRB(16, 20, 16, 20),
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.BORDER_COLOR),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.PRIMARY_COLOR.withOpacity(.09)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithGradiant(
                        text: '12',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      TextWithGradiant(
                        text: 'Monday',
                        fontSize: 12.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Sat',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: '10 AM -12 PM',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff181B28).withOpacity(.7),
                      )
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
            // divider
            Container(
              height: 1,
              color: AppColors.BORDER_COLOR,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                    Assets.lib.res.assets.imgMaterialSymbolBlueGray90003),
                SizedBox(width: 5.w),
                CustomText(
                  text: 'Khaled Ahmed',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C),
                ),
                const Spacer(),
                CustomText(
                  text: '+9983747228',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C).withOpacity(.64),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                    Assets.lib.res.assets.imgMaterialSymbolOnprimary),
                SizedBox(width: 5.w),
                CustomText(
                  text: 'Deep Tissue massage',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C),
                ),
                CustomText(
                  text: '(60 min)',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C).withOpacity(.64),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
