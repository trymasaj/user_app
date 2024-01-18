import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/gen/assets.gen.dart';

class PaymentInfoCard extends StatelessWidget {
  const PaymentInfoCard({
    super.key,
  });
  Widget buildInfoItem(
          {required String title,
          required String data,
          bool isSuccess = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_LIGHT.withOpacity(.7),
          ),
          CustomText(
            text: data,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                isSuccess ? AppColors.SUCCESS_COLOR : const Color(0xff19223C),
          )
        ],
      );
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
          const Row(
            children: [
              CustomText(
                text: 'payment_summary',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff19223C),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          // divider
          Container(
            height: 1,
            color: AppColors.BORDER_COLOR,
          ),

          SizedBox(height: 12.h),
          buildInfoItem(title: 'amount', data: '10.000 KD'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'cupon_discount', data: '0 KD'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'paid_amount', data: '10.000 KD'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'payment_method', data: 'KNET/Credit card'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'payment_id', data: '2030293929'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'reference_id', data: '2030293929'),
          SizedBox(height: 16.h),
          buildInfoItem(title: 'payment_date', data: '20/02/2023 01:00 PM'),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'payment_status', data: 'Success', isSuccess: true),
        ],
      ),
    );
  }
}
