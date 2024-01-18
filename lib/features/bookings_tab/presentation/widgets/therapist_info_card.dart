import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/gen/assets.gen.dart';

class TherapistInfoCard extends StatelessWidget {
  const TherapistInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.BORDER_COLOR),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Therapist info',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff19223C),
                  )),
            ],
          ),

          SizedBox(height: 16.h),
          // divider
          Container(
            height: 1,
            color: AppColors.BORDER_COLOR,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                            Assets.lib.res.assets.imgRectangle2850x50.path),
                        fit: BoxFit.cover)),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahmed mohsen',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff19223C),
                      )),
                  // SizedBox(height: 5.h),
                  Text('Medical  Therapist',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0x0019223c).withOpacity(.64),
                      )),
                ],
              ),

              // circle avatar with #F5F5F5 color and wharsapp icon
              const Spacer(),
              Row(
                children: [
                  CircleAvatar(
                    radius: (36 / 2).r,
                    backgroundColor: const Color(0xffF5F5F5),
                    child: SvgPicture.asset(
                      'assets/images/wa_logo.svg',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CircleAvatar(
                    radius: (36 / 2).r,
                    backgroundColor: const Color(0xffF5F5F5),
                    child: SvgPicture.asset(
                      'assets/images/phone.svg',
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 15.h),
          const DottedLine(
            dashColor: Color(0xffCFCFCF),
          ),
          SizedBox(height: 15.h),
          _InfoItem(
            iconPath: Assets.lib.res.assets.imgMaterialSymbolBlueGray90003,
            title: 'Khaled Ahmed',
            subtitle: '+9983747228',
          ),
          SizedBox(height: 10.h),
          _InfoItem(
            iconPath: Assets.lib.res.assets.imgMaterialSymbolOnprimary,
            title: 'Deep Tissue massage',
            subtitle: '(60 min)',
          ),

          SizedBox(height: 10.h),
          _InfoItem(
            iconPath: Assets.lib.res.assets.imgTablerApps,
            title: 'Hot stone, Herbal compresses',
          ),
          SizedBox(height: 20.h),
          Container(
            height: 1,
            color: AppColors.BORDER_COLOR,
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/img_alert_circle.svg',
                color: AppColors.FONT_LIGHT.withOpacity(.7),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: CustomText(
                    text: 'allow_up_to_1_hour',
                    fontSize: 11.5,
                    height: 2,
                    fontWeight: FontWeight.w400,
                    color: AppColors.FONT_LIGHT.withOpacity(.7)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.iconPath,
    required this.title,
    // ignore: unused_element
    this.subtitle,
  });

  final String iconPath;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Khaled Ahmed
        // SvgPicture.asset(Assets.lib.res.assets.imgMaterialSymbolBlueGray90003),
        SvgPicture.asset(iconPath),

        SizedBox(width: 5.w),
        CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff19223C),
        ),
        const Spacer(),
        if (subtitle != null)
          CustomText(
            text: subtitle!,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_LIGHT.withOpacity(.7),
          )
      ],
    );
  }
}
