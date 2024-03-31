import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/book_service/enums/payment_status.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';

class SummaryPaymentPage extends StatefulWidget {
  const SummaryPaymentPage({super.key});
  @override
  State<SummaryPaymentPage> createState() => _SummaryPaymentPageState();
}

class _SummaryPaymentPageState extends State<SummaryPaymentPage> {
  void getBooking() async {
    final bookingCubit = context.read<BookingCubit>();
    await bookingCubit.getBookingDetails();
  }

  @override
  void initState() {
    getBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final bookingModel = context.read<BookingCubit>().state.bookingModel;
        final isSucceeded =
            bookingModel?.paymentStatus == PaymentStatus.Captured;
        if (state.isLoading) return const CustomLoading();

        return CustomAppPage(
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'lbl_payment_details',
              centerTitle: true,
              showBackButton: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/share.svg',
                    height: 25,
                    color: AppColors.ACCENT_COLOR,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(children: [
                const SizedBox(height: 20),
                SvgPicture.asset(isSucceeded
                    ? 'assets/images/success_payment.svg'
                    : 'assets/images/failed_payment.svg'),
                SubtitleText(
                    text: isSucceeded
                        ? 'msg_payment_successful'
                        : 'msg_payment_failed',
                    subtractedSize: -1,
                    isBold: true),
                const SubtitleText(text: 'lbl_wallet_balance'),
                const SizedBox(height: 20),
                _buildSummary(context),
                Spacer(),
                DefaultButton(
                  onPressed: () {
                    NavigatorHelper.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName, (route) => false);
                  },
                  label: 'lbl_back_to_home',
                  isExpanded: true,
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummary(BuildContext context) {
    final bookingModel = context.read<BookingCubit>().state.bookingModel;
    return Flexible(
      flex: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.GREY_LIGHT_COLOR,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildSummaryItem(
                amount: bookingModel?.subtotal, title: 'lbl_sub_total2'),
            _buildSummaryItem(
                amount: bookingModel?.discountedAmount,
                title: 'lbl_coupon_discount'),
            _buildSummaryItem(
                amount: bookingModel?.grandTotal, title: 'lbl_total_amount2'),
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentMethod,
                title: 'payment_method'),
            _buildSummaryItem(
                amount: bookingModel?.paymentStatus, title: 'payment_id'),
            _buildSummaryItem(amount: 50, title: 'reference_id'),
            _buildSummaryItem(amount: 50, title: 'payment_date'),
            _buildSummaryItem(amount: 50, title: 'payment_status')
          ]),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      {bool isDiscount = false, required String title, dynamic amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SubtitleText(
            text: title,
            color: isDiscount ? AppColors.SUCCESS_COLOR : null,
            subtractedSize: -1,
          ),
          const Spacer(),
          SubtitleText(
            text: '$amount KWD',
            isBold: true,
          )
        ],
      ),
    );
  }
}
