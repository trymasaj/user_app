import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
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
    await bookingCubit.getBookingStreaks();
  }

  @override
  void initState() {
    getBooking();
    final bookingCubit = context.read<BookingCubit>();
    if (bookingCubit.state.bookingModel?.payment?.paymentStatus ==
        PaymentStatus.Captured) _modalBottomSheetMenu();

    super.initState();
  }

  void _modalBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bookingCubit = context.read<BookingCubit>();

      int total = 10;
      int remaining = bookingCubit.state.bookingStreaks ?? 0;
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
                          if (remaining > index + 1)
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
                    const CustomText(
                      text: 'remaining_sessions',
                      textAlign: TextAlign.center,
                      subtractedSize: -2,
                    ),
                    const SizedBox(height: 24.0),
                    CustomText(
                      text: 'left_sessions'.tr(args: [remaining.toString()]),
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
        final isSucceeded =
            bookingModel?.paymentStatus == PaymentStatus.Captured ||
                bookingModel?.paymentStatus == PaymentStatus.Pending;
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
                label: 'lbl_back_to_home',
                isExpanded: true,
              ),
            ),
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
                          ? 'msg_payment_successful'
                          : 'msg_payment_failed',
                      subtractedSize: -1,
                      isBold: true),
                  const SubtitleText(text: 'lbl_wallet_balance'),
                  BlocSelector<WalletBloc, WalletState, WalletModel?>(
                    selector: (state) {
                      return state.walletBalance;
                    },
                    builder: (context, state) {
                      return SubtitleText(
                          text: 'lbl_kwd'
                              .tr(args: [(state?.balance ?? 0).toString()]));
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
              amount: bookingModel?.subtotal, title: 'lbl_sub_total2'),
          _buildSummaryPriceItem(
              amount: bookingModel?.discountedAmount,
              title: 'lbl_coupon_discount'),
          _buildSummaryPriceItem(
              amount: bookingModel?.grandTotal, title: 'lbl_total_amount2'),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentMethod?.name,
                title: 'payment_method'),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentId, title: 'payment_id'),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.referenceId,
                title: 'reference_id'),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: DateTime.parse(bookingModel!.payment!.paymentDate!)
                    .formatDate(),
                title: 'payment_date'),
          if (bookingModel?.payment != null)
            _buildSummaryItem(
                amount: bookingModel?.payment?.paymentStatus?.name,
                isStatus: bookingModel?.payment?.paymentStatus ==
                    PaymentStatus.Captured,
                title: 'payment_status')
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
              text: 'lbl_kwd'.tr(args: [amount.toString()]),
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
