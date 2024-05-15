import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/data/models/booking_model/payment.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';

class PaymentInfoCard extends StatelessWidget {
  const PaymentInfoCard({
    super.key,
    required this.bookingModel,
  });
  final BookingModel bookingModel;

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
          SizedBox(
            width: 170.w,
            child: CustomText(
              maxLines: 1,
              text: data,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.end,
              color:
                  isSuccess ? AppColors.SUCCESS_COLOR : const Color(0xff19223C),
            ),
          )
        ],
      );
  Widget _buildSummaryItem(
      {bool isDiscount = false, required String title, dynamic amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SubtitleText(
            text: title,
            color: isDiscount ? AppColors.SUCCESS_COLOR : AppColors.FONT_LIGHT,
            subtractedSize: -1,
          ),
          const Spacer(),
          Expanded(
            flex: 6,
            child: SubtitleText(
              text: '$amount ',
              textAlign: TextAlign.end,
              isBold: false,
              color: const Color(0xff1D212C),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

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
          buildInfoItem(
              title: 'amount',
              data: "price_in_kd".tr(args: [bookingModel.grandTotal.toString()])
              //  '${bookingModel.grandTotal} KD'
              ),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'cupon_discount',
              data: "price_in_kd"
                  .tr(args: [bookingModel.discountedAmount.toString()])
              // '${bookingModel.discountedAmount} KD'
              ),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'paid_amount',
              data: "price_in_kd".tr(args: [bookingModel.grandTotal.toString()])
              //  '${bookingModel.grandTotal} KD'
              ),
          SizedBox(height: 16.h),
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              return buildInfoItem(
                  title: 'payment_method',
                  data: state.methods
                          ?.where((element) =>
                              element.id == bookingModel.payment?.paymentMethod)
                          .firstOrNull
                          ?.title ??
                      '');
            },
          ),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'status', data: bookingModel?.bookingStatus?.name ?? ''),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'payment_id',
              data: bookingModel?.payment?.paymentId.toString() ?? ''),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'reference_id',
              data: bookingModel?.payment?.referenceId.toString() ?? ''),

          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'payment_date',
              data: bookingModel?.payment?.formattedDate ?? ''),
          SizedBox(height: 16.h),
          buildInfoItem(
              title: 'payment_status',
              data: bookingModel.paymentStatus?.name ?? '',
              isSuccess: true),
        ],
      ),
    );
  }
}
