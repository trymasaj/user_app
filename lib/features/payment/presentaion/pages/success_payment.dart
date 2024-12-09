import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/enums/booking_status.dart';
import 'package:masaj/features/book_service/enums/payment_status.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';

import '../../../wallet/bloc/wallet_bloc/wallet_bloc.dart';
import '../../../wallet/models/wallet_model.dart';

class SummaryPaymentPage extends StatefulWidget {
  const SummaryPaymentPage({super.key, required this.bookingId});
  final int bookingId;
  @override
  State<SummaryPaymentPage> createState() => _SummaryPaymentPageState();
}

class _SummaryPaymentPageState extends State<SummaryPaymentPage> {
  void getBooking() async {
    final bookingCubit = context.read<BookingCubit>();
    await bookingCubit.getBookingDetails(oldBookingId: widget.bookingId);
    final bookingModel = bookingCubit.state.bookingModel;
    final isSuccess =
        bookingModel?.payment?.paymentStatus == PaymentStatus.Captured ||
            bookingModel?.paymentStatus == PaymentStatusPaidOrNotPaid.paid ||
            bookingModel?.payment?.paymentStatus == PaymentStatus.Pending;
    if (isSuccess) {
      await bookingCubit.getBookingStreaks();
      if (bookingCubit.state.bookingStreaks == 10) {
        return _showCompleteStreaksBottomSheet();
      }
      _modalBottomSheetMenu();
      // AdjustTracker.trackCheckoutSuccess(
      //     bookingModel?.grandTotal?.toDouble() ?? 0);
      // AdjustTracker.trackFirstSale();
    }
  }

  @override
  void initState() {
    getBooking();

    super.initState();
  }

  void _showCompleteStreaksBottomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int total = 10;
      await showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/congrats_celeb.svg',
                      width: 520,
                    ),
                    const SizedBox(height: 24.0),
                    SvgPicture.asset(
                      'assets/images/congrats.svg',
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      height: 90.0,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: total,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SvgPicture.asset(
                            'assets/images/success_session.svg',
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    CustomText(
                      text: AppText.msg_congratulations,
                      textAlign: TextAlign.center,
                      subtractedSize: -2,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText(
                      text: AppText.msg_you_hit_a_10_sessions,
                      textAlign: TextAlign.center,
                      subtractedSize: -2,
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ));
          });
    });
  }

  void _modalBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bookingCubit = context.read<BookingCubit>();

      int total = 10;
      int streak = bookingCubit.state.bookingStreaks ?? 0;
      await showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/header.svg',
                      width: 520,
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      height: 90.0,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: total,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (streak > index)
                            return SvgPicture.asset(
                              'assets/images/success_session.svg',
                            );
                          return SvgPicture.asset(
                            'assets/images/remained_session.svg',
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    CustomText(
                      text: AppText.remaining_sessions,
                      textAlign: TextAlign.center,
                      subtractedSize: -2,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText(
                      text: AppText.left_sessions(args: [streak.toString()]),
                      subtractedSize: -2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final bookingModel = context.read<BookingCubit>().state.bookingModel;
        final isSucceeded = bookingModel?.payment?.paymentStatus ==
                PaymentStatus.Captured ||
            bookingModel?.paymentStatus == PaymentStatusPaidOrNotPaid.paid ||
            bookingModel?.payment?.paymentStatus == PaymentStatus.Pending;
        if (state.isLoading) return const CustomLoading();

        return CustomAppPage(
          child: Scaffold(
            bottomSheet: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              height: 100,
              child: DefaultButton(
                onPressed: () {
                  NavigatorHelper.of(context).pushNamedAndRemoveUntil(
                      HomePage.routeName, (route) => false);
                },
                label: AppText.lbl_back_to_home,
                isExpanded: true,
              ),
            ),
            appBar: CustomAppBar(
              title: AppText.lbl_payment_details,
              centerTitle: true,
              showBackButton: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(isSucceeded
                      ? 'assets/images/success_payment.svg'
                      : 'assets/images/failed_payment.svg'),
                  SubtitleText(
                      text: isSucceeded
                          ? AppText.msg_payment_successful
                          : AppText.msg_payment_failed,
                      subtractedSize: -1,
                      isBold: true),
                  SubtitleText(text: AppText.lbl_wallet_balance),
                  BlocSelector<WalletBloc, WalletState, WalletModel?>(
                    selector: (state) {
                      return state.walletBalance;
                    },
                    builder: (context, state) {
                      return SubtitleText(
                          text: AppText.lbl_kwd(args: [(state?.balance ?? 0).toString()]));
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSummary(context),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummary(BuildContext context) {
    final bookingModel = context.read<BookingCubit>().state.bookingModel;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.GREY_LIGHT_COLOR,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildSummaryPriceItem(
              amount: bookingModel?.subtotal, title: AppText.lbl_sub_total2),
          _buildSummaryPriceItem(
              amount: bookingModel?.discountedAmount,
              title: AppText.lbl_coupon_discount),
          _buildSummaryPriceItem(
              amount: bookingModel?.grandTotal, title: AppText.lbl_total_amount2),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentMethod?.name,
                title: AppText.payment_method),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentId, title: AppText.payment_id),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.referenceId,
                title: AppText.reference_id),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: DateTime.parse(bookingModel!.payment!.paymentDate!)
                    .formatDate(),
                title: AppText.payment_date),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentStatus?.name,
                isStatus: bookingModel?.payment?.paymentStatus ==
                    PaymentStatus.Captured,
                title: AppText.payment_status)
        ]),
      ), //Education2016
    );
  }

  Widget _buildSummaryItem(
      {bool isDiscount = false,
      required String title,
      dynamic amount,
      bool? isStatus}) {
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
              text: '$amount',
              textAlign: TextAlign.end,
              isBold: false,
              color: isStatus != null
                  ? (isStatus == true
                      ? AppColors.SUCCESS_COLOR
                      : AppColors.ERROR_COLOR)
                  : const Color(0xff1D212C),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryPriceItem(
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
              text: AppText.lbl_kwd(args: [amount.toString()]),
              textAlign: TextAlign.end,
              isBold: false,
              color:
                  isDiscount ? AppColors.SUCCESS_COLOR : AppColors.FONT_LIGHT,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
