import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/overlay/top_up_wallet_payment_method_bottomsheet.dart';

class TopUpWalletScreen extends StatefulWidget {
  static const routeName = '/top-up-wallet';

  const TopUpWalletScreen({super.key});

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => Injector().walletCubit..getPredefinedAmounts(),
      ),
      BlocProvider(
        create: (context) => Injector().paymentCubit..getPaymentMethods(),
      )
    ], child: const TopUpWalletScreen());
  }

  @override
  State<TopUpWalletScreen> createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  int? _selectedIndex;

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
                  return _buildAmountItem(state![index], index);
                });
          })
    ]);
  }

  Widget _buildAmountItem(WalletAmountsModel walletAmountsModel, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Card(
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
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                                        style: CustomTextStyles
                                            .titleLargeOnPrimary))
                              ]),
                          Text('lbl_free_9_kwd'.tr(),
                              style: CustomTextStyles.bodyMediumLightgreen900)
                        ]))),
                SvgPicture.asset(
                    isSelected
                        ? 'assets/images/radio_button.svg'
                        : ImageConstant.imgClock,
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    alignment: Alignment.topLeft)
              ]))),
    );
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

  void onTapPurchaseButton(BuildContext context) {
    if (_selectedIndex != null) {
      final id = context
          .read<WalletBloc>()
          .state
          .predefinedAmounts![_selectedIndex!]
          .id;
      showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          builder: (_) =>
              TopUpWalletPaymentMethodBottomsheet(walletPredefinedAmountId: id!)
                  .builder(context, id),
          isScrollControlled: true);
    } else
      showSnackBar(context, message: 'select at least one');
  }
}
