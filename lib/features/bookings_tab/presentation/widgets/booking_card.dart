import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/book_service/data/models/booking_model/member.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/booking_details.dart';
import 'package:masaj/gen/assets.gen.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    this.sessionModel,
    this.enable = true,
    this.isCompleted = false,
  });
  final SessionModel? sessionModel;
  final bool enable;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable
          ? () {
              Navigator.of(context).pushNamed(BookingDetialsScreen.routeName,
                  arguments: sessionModel?.id);
            }
          : null,
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
                  width: 60.w,
                  padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isCompleted
                          ? Color(0xffF7F7F7)
                          : AppColors.PRIMARY_COLOR.withOpacity(.09)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithGradiant(
                        disableGradiant: isCompleted,
                        text: sessionModel?.bookingDate?.day.toString() ?? '',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: isCompleted ? AppColors.FONT_LIGHT_COLOR : null,
                        height: 1.2,
                      ),
                      TextWithGradiant(
                        disableGradiant: isCompleted,
                        color: isCompleted ? AppColors.FONT_LIGHT_COLOR : null,
                        text:
                            sessionModel?.bookingDate?.monthString.toString() ??
                                '',
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
                        text: sessionModel?.bookingDate?.weekDayString
                                .toString() ??
                            '',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        // text: '10 AM -12 PM',
                        text: sessionModel?.timeString ?? '',
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
            for (var member in sessionModel?.members ?? <Member>[]) ...[
              Row(
                children: [
                  SvgPicture.asset(
                      Assets.images.imgMaterialSymbolBlueGray90003),
                  SizedBox(width: 5.w),
                  CustomText(
                    text: member.name ?? '',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff19223C),
                  ),
                  const Spacer(),
                  CustomText(
                    text: (member.countryCode ?? '') + (member.phone ?? ''),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff19223C).withOpacity(.64),
                  )
                ],
              ),
              SizedBox(height: 10.h)
            ],
            Row(
              children: [
                SvgPicture.asset(Assets.images.imgMaterialSymbolOnprimary),
                SizedBox(width: 5.w),
                CustomText(
                  text: sessionModel?.serviceName ?? 'Service Name',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C),
                ),
                CustomText(
                  text: ' (${sessionModel?.durationInMinutes} ${'min'.tr()})',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff19223C).withOpacity(.64),
                )
              ],
            ),
            if (sessionModel?.address != null) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.imgFluentLocation20Regular,
                    color: AppColors.FONT_LIGHT_COLOR,
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 250.w,
                    child: CustomText(
                      text: sessionModel?.address?.formattedAddress ??
                          'Service Name',
                      maxLines: 1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff19223C),
                    ),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
