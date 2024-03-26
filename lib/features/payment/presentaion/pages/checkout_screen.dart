import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/data/model/payment_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/payment/presentaion/pages/success_payment.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required CheckOutModel checkOutModel})
      : _checkOutModel = checkOutModel;
  static const String routeName = '/checkoutScreen';
  final CheckOutModel _checkOutModel;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _kDividerThickness = 6;
  static const double _KSubVerticalSpace = 12;
  static const double _KSectionPadding = 24;
  PaymentMethodModel? _selectedPayment;

  late final TextEditingController _couponEditingController;
  late final TextEditingController _walletController;
  late final FocusNode _couponFocusNode;

  @override
  void initState() {
    _couponEditingController = TextEditingController();
    _walletController = TextEditingController();
    _couponFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _couponEditingController.dispose();
    _walletController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => Injector().paymentCubit..getPaymentMethods(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'checkout_title'.tr(),
          ),
          body: _buildBody(),
        ),
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
          imageUrl: widget._checkOutModel.service?.images.first,
          height: 70.0,
          width: 70.0,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(12.0),
        ),
        const SizedBox(width: _KSubVerticalSpace),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtitleText(
              text: widget._checkOutModel.service?.title ?? '',
              isBold: true,
            ),
            const SizedBox(height: 5.0),
            SubtitleText(
                text: widget._checkOutModel.service?.description ?? ''),
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
          _buildDetailsRow(title: 'time:', content: 'date_dummy'),
          _buildDetailsRow(title: 'name:', content: 'date_dummy'),
          _buildDetailsRow(title: 'phone:', content: 'date_dummy'),
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
                imageUrl: widget._checkOutModel.therapist?.profileImage,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleText(
                    text: widget._checkOutModel.therapist?.fullName ?? '',
                    isBold: true,
                  ),
                  SubtitleText(
                      text: widget._checkOutModel.therapist?.title ?? ''),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    log(widget._checkOutModel.address?.googleMapAddress ?? '');
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(text: 'location'),
          const SizedBox(height: _KSubVerticalSpace),
          TitleText(
            text: widget._checkOutModel.address!.nickName!.isEmpty
                ? widget._checkOutModel.address?.formattedAddress ?? ''
                : '',
            subtractedSize: 2,
          ),
          const SizedBox(height: 4),
          SubtitleText(
              text: widget._checkOutModel.address?.formattedAddress ?? ''),
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
          _WalletSection(controller: _walletController),
          _buildPaymentMethods()
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoading();
        }
        final methods = state.methods ?? [];

        if ((methods == [] || methods.isEmpty)) {
          return const EmptyPageMessage();
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: methods.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildPaymentMethodItem(methods[index]);
            });
      },
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethodModel paymentMethod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = paymentMethod;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: paymentMethod == _selectedPayment
                ? AppColors.PRIMARY_COLOR.withOpacity(0.09)
                : AppColors.BACKGROUND_COLOR.withOpacity(0.09),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.PRIMARY_COLOR, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(children: [
              SubtitleText(
                text: paymentMethod.name ?? '',
                isBold: true,
              ),
              const Spacer(),
              Radio.adaptive(
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: paymentMethod,
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value;
                    });
                  })
            ]),
          ),
        ),
      ),
    );
  }

  Padding _buildSummarySection() {
    final double subTotal = 90.0;
    final double tax = 12.0;
    final double discount = 2.0;
    final double wallet = double.tryParse(_walletController.text) ?? 0.0;
    final double total = subTotal + tax - discount - wallet;

    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: 'booking_summary'),
          const SizedBox(height: 12.0),
          _buildCoupon(),
          const SizedBox(height: 12.0),
          _buildSummaryItem(title: 'lbl_sub_total2', amount: subTotal),
          _buildSummaryItem(title: 'lbl_tax', amount: tax),
          _buildSummaryItem(
              isDiscount: true, title: 'lbl_discount', amount: discount),
          _buildSummaryItem(title: 'lbl_wallet', amount: wallet),
          const SizedBox(height: 12.0),
          const Divider(
            thickness: 3,
            color: AppColors.ExtraLight,
          ),
          const SizedBox(height: 12.0),
          _buildSummaryItem(title: 'total', amount: total),
        ],
      ),
    );
  }

  Widget _buildCoupon() {
    return DefaultTextFormField(
      currentFocusNode: _couponFocusNode,
      currentController: _couponEditingController,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(
          'assets/images/dicount_icon.svg',
        ),
      ),
      hint: 'lbl_coupon_code',
      suffixIcon: DefaultButton(
        borderRadius: BorderRadius.circular(8),
        onPressed: () {},
        label: 'lbl_apply',
      ),
    );
  }

  Widget _buildSummaryItem(
      {bool isDiscount = false,
      required String title,
      required double amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(top: 10),
      child: DefaultButton(
        isExpanded: true,
        onPressed: () {
          NavigatorHelper.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const SuccessPaymentPage()),
              (_) => false);
        },
        label: 'lbl_book_now',
      ),
    );
  }
}

class _WalletSection extends StatefulWidget {
  const _WalletSection({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  State<_WalletSection> createState() => _WalletSectionState();
}

class _WalletSectionState extends State<_WalletSection> {
  late final FocusNode _focusNode;
  bool _useWallet = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SubtitleText(text: 'use_wallet'.tr(args: ['200'])),
            const Spacer(),
            CustomSwitch(
              onChange: (value) {
                setState(() {
                  _useWallet = value;
                });
              },
              value: _useWallet,
            ),
          ],
        ),
        if (_useWallet) const SizedBox(height: 4),
        if (_useWallet)
          DefaultTextFormField(
            currentFocusNode: _focusNode,
            currentController: widget.controller,
            hint: 'apply_wallet_amount',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        if (_useWallet) const SizedBox(height: 8),
      ],
    );
  }
}
