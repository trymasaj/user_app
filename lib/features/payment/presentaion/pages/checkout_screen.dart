import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/checkoutScreen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _kDividerThickness = 6;
  static const double _KSubVerticalSpace = 12;
  static const double _KSectionPadding = 24;
  int? _selectedPayment;

  late final TextEditingController _couponEditingController;
  late final FocusNode _couponFocusNode;

  @override
  void initState() {
    _couponEditingController = TextEditingController();
    _couponFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _couponEditingController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'checkout_title'.tr(),
        ),
        body: _buildBody(),
      );
    });
  }

  CustomAppPage _buildBody() {
    return CustomAppPage(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceSection(),
            const Divider(
              thickness: _kDividerThickness,
              color: AppColors.ExtraLight,
            ),
            _buildDetailsSection(),
            const Divider(
              thickness: _kDividerThickness,
              color: AppColors.ExtraLight,
            ),
            _buildTherapistSection(),
            const Divider(
              thickness: _kDividerThickness,
              color: AppColors.ExtraLight,
            ),
            _buildLocationSection(),
            const Divider(
              thickness: _kDividerThickness,
              color: AppColors.ExtraLight,
            ),
            _buildPaymentSection(),
            const Divider(
              thickness: _kDividerThickness,
              color: AppColors.ExtraLight,
            ),
            _buildSummarySection(),
            _buildCheckoutButton()
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        children: [
          _buildServiceTitle(),
          const SizedBox(height: _KSubVerticalSpace),
          const WarningContainer(title: 'checkout_warning'),
        ],
      ),
    );
  }

  Row _buildServiceTitle() {
    return Row(
      children: [
        CustomCachedNetworkImage(
          imageUrl: '',
          height: 70.0,
          width: 70.0,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(12.0),
        ),
        const SizedBox(width: _KSubVerticalSpace),
        const Column(
          children: [
            SubtitleText(
              text: 'dummy service',
              isBold: true,
            ),
            SizedBox(height: 5.0),
            SubtitleText(text: 'dummy service'),
          ],
        )
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(text: 'details'),
          const SizedBox(height: _KSubVerticalSpace),
          _buildDetailsRow(title: 'date:', content: 'date_dummy'),
          _buildDetailsRow(title: 'date:', content: 'date_dummy'),
          _buildDetailsRow(title: 'date:', content: 'date_dummy'),
          _buildDetailsRow(title: 'date:', content: 'date_dummy'),
        ],
      ),
    );
  }

  Widget _buildDetailsRow({required String title, required String content}) {
    return Row(
      children: [
        SubtitleText(text: title),
        const SizedBox(width: 24.0),
        SubtitleText(text: content)
      ],
    );
  }

  Widget _buildTherapistSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(
            text: 'therapist',
            color: AppColors.ACCENT_COLOR,
          ),
          const SizedBox(height: _KSubVerticalSpace),
          Row(
            children: [
              CustomCachedNetworkImage(
                imageUrl: '',
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(width: 12.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleText(
                    text: 'test dummy',
                    isBold: true,
                  ),
                  SubtitleText(text: 'dummy test dummy'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return const Padding(
      padding: EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: 'location'),
          SizedBox(height: _KSubVerticalSpace),
          TitleText(
            text: 'home_dummy',
            subtractedSize: 2,
          ),
          SizedBox(height: 4),
          SubtitleText(text: 'title'),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(
            text: 'payment_method',
          ),
          _buildWalletApply(),
          const SizedBox(height: _KSubVerticalSpace),
          _buildPaymentMethods()
        ],
      ),
    );
  }

  Widget _buildWalletApply() {
    return Row(
      children: [
        SubtitleText(text: 'use_wallet_dummy'.tr(args: ['200'])),
        const Spacer(),
        CustomSwitch(onChange: (value) {}),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildPaymentMethodItem(index);
        });
  }

  Widget _buildPaymentMethodItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR.withOpacity(0.09),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.PRIMARY_COLOR, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(children: [
            const SubtitleText(
              text: 'payment',
              isBold: true,
            ),
            const Spacer(),
            Radio.adaptive(
                activeColor: AppColors.PRIMARY_COLOR,
                value: index,
                groupValue: _selectedPayment,
                onChanged: (value) {
                  _selectedPayment = value;
                })
          ]),
        ),
      ),
    );
  }

  Padding _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        children: [
          _buildCoupon(),
          const SizedBox(height: 12.0),
          _buildSummaryItem(),
          _buildSummaryItem(),
          _buildSummaryItem(isDiscount: true),
          _buildSummaryItem(),
          const SizedBox(height: 12.0),
          const Divider(
            thickness: 3,
            color: AppColors.ExtraLight,
          ),
          const SizedBox(height: 12.0),
          _buildSummaryItem(),
        ],
      ),
    );
  }

  DefaultTextFormField _buildCoupon() {
    return DefaultTextFormField(
      currentFocusNode: _couponFocusNode,
      currentController: _couponEditingController,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(
          'assets/images/dicount_icon.svg',
        ),
      ),
      hint: 'add_your_coupon',
      suffixIcon: DefaultButton(
        borderRadius: BorderRadius.circular(8),
        onPressed: () {},
        label: 'apply',
      ),
    );
  }

  Widget _buildSummaryItem({bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SubtitleText(
            text: 'title',
            color: isDiscount ? AppColors.SUCCESS_COLOR : null,
            subtractedSize: -1,
          ),
          const Spacer(),
          const SubtitleText(
            text: '40 KWD',
            isBold: true,
          )
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(top: 10),
      child: DefaultButton(
        isExpanded: true,
        onPressed: () {},
        label: 'book_now',
      ),
    );
  }
}
