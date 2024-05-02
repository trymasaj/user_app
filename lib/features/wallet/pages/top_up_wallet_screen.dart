import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/overlay/top_up_wallet_payment_method_bottomsheet.dart';

class TopUpWalletScreen extends StatelessWidget {
  static const routeName = '/top-up-wallet';

  const TopUpWalletScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WalletBloc>(
        create: (context) => Injector().walletCubit..getPredefinedAmounts(),
        child: const TopUpWalletScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(children: [
              SizedBox(height: 24.h),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 24.w, right: 24.w, bottom: 5.h),
                          child: Column(children: [
                            _buildFrameColumn(context),
                            SizedBox(height: 25.h),
                            _buildPackages(context),
                            SizedBox(height: 12.h),
                          ]))))
            ])),
        bottomNavigationBar: _buildPurchaseButton(context));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'lbl_wallet_top_up'.tr(),
    );
  }

  /// Section Widget
  Widget _buildFrameColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('msg_have_a_gift_voucher'.tr(), style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      TextField(
        decoration: InputDecoration(
            hintText: 'msg_enter_redeem_code'.tr(),
            hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
              child: CustomElevatedButton(
                  height: 36.h,
                  width: 64.w,
                  onPressed: () {
                    print('helooo');
                  },
                  text: 'lbl_apply'.tr(),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomButtonStyles
                      .gradientSecondaryContainerToPrimaryTL6Decoration,
                  buttonTextStyle:
                      CustomTextStyles.labelLargeOnPrimaryContainer),
            ),
            prefixIcon: CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w)),
            prefixIconConstraints:
                BoxConstraints(minWidth: 20.adaptSize, minHeight: 20.adaptSize),
            border: OutlineInputBorder(
                borderRadius: BorderRadiusStyle.roundedBorder8,
                borderSide: BorderSide.none)),
      ),
    ]);
  }

  /// Section Widget
  Widget _buildPackages(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('msg_top_up_your_wallet'.tr(), style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      BlocSelector<WalletBloc, WalletState, List<WalletAmountsModel>?>(
          selector: (state) => state.predefinedAmounts,
          builder: (context, state) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 121.h,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildAmountItem(state![index]);
                });
          })
    ]);
  }

  Card _buildAmountItem(WalletAmountsModel walletAmountsModel) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: appTheme.blueGray100, width: 1.w),
            borderRadius: BorderRadiusStyle.roundedBorder12),
        child: Container(
            height: 120.h,
            width: 158.w,
            padding: EdgeInsets.all(9.w),
            decoration: AppDecoration.outlineBlueGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            child: Stack(alignment: Alignment.topLeft, children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 23.w, top: 19.h, right: 23.w),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 3.h, bottom: 2.h),
                                  child: Text(
                                      'lbl_kwd'.tr(args: [
                                        walletAmountsModel.amount.toString()
                                      ]),
                                      style:
                                          CustomTextStyles.titleLargeOnPrimary))
                            ]),
                        Text('lbl_free_9_kwd'.tr(),
                            style: CustomTextStyles.bodyMediumLightgreen900)
                      ]))),
              CustomImageView(
                  imagePath: ImageConstant.imgClock,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.topLeft)
            ])));
  }

  /// Section Widget
  Widget _buildPurchaseButton(BuildContext context) {
    return CustomElevatedButton(
        text: 'lbl_purchase'.tr(),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 31.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles
            .gradientSecondaryContainerToDeepOrangeTL28Decoration,
        buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
        onPressed: () {
          onTapPurchaseButton(context);
        });
  }

  onTapPurchaseButton(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TopUpWalletPaymentMethodBottomsheet.builder(context),
        isScrollControlled: true);
  }
}
