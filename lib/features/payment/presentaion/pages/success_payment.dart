import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';

class SuccessPaymentPage extends StatefulWidget {
  const SuccessPaymentPage({super.key});

  @override
  State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
  @override
  Widget build(BuildContext context) {
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
            SvgPicture.asset('assets/images/success_payment.svg'),
            const SubtitleText(
                text: 'msg_payment_successful',
                subtractedSize: -1,
                isBold: true),
            const SubtitleText(text: 'lbl_wallet_balance'),
            const SizedBox(height: 20),
            _buildSummary(),
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
  }

  Widget _buildSummary() {
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
            _buildSummaryItem(amount: 50, title: 'lbl_sub_total2'),
            _buildSummaryItem(amount: 50, title: 'lbl_coupon_discount'),
            _buildSummaryItem(amount: 50, title: 'lbl_total_amount2'),
            _buildSummaryItem(amount: 50, title: 'payment_method'),
            _buildSummaryItem(amount: 50, title: 'payment_id'),
            _buildSummaryItem(amount: 50, title: 'reference_id'),
            _buildSummaryItem(amount: 50, title: 'payment_date'),
            _buildSummaryItem(amount: 50, title: 'payment_status')
          ]),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      {bool isDiscount = false,
      required String title,
      required double amount}) {
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
