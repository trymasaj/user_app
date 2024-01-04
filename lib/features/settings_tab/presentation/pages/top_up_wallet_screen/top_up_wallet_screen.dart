import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/features/settings_tab/presentation/pages/top_up_wallet_payment_method_bottomsheet/top_up_wallet_payment_method_bottomsheet.dart';

import '../top_up_wallet_screen/widgets/userprofile8_item_widget.dart';
import 'bloc/top_up_wallet_bloc.dart';
import 'models/top_up_wallet_model.dart';
import 'models/userprofile8_item_model.dart';
import 'package:flutter/material.dart';

class TopUpWalletScreen extends StatelessWidget {
  static const routeName = '/top-up-wallet';

  const TopUpWalletScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<TopUpWalletBloc>(
        create: (context) => TopUpWalletBloc(
            TopUpWalletState(topUpWalletModelObj: TopUpWalletModel()))
          ..add(TopUpWalletInitialEvent()),
        child: TopUpWalletScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                                _buildValueColumn(context),
                                SizedBox(height: 12.h),
                                _buildFrameRow(context),
                                SizedBox(height: 12.h),
                                _buildFrameRow1(context)
                              ]))))
                ])),
            bottomNavigationBar: _buildPurchaseButton(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 24.w, right: 168.w),
              child: Row(children: [
                AppbarTitleIconbutton(
                    imagePath: ImageConstant.imgGroup1000002973),
                AppbarSubtitleTwo(
                    text: "lbl_wallet_top_up".tr(),
                    margin: EdgeInsets.only(left: 16.w, top: 10.h, bottom: 6.h))
              ])),
          SizedBox(height: 12.h),
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(width: double.maxFinite, child: Divider()))
        ]),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildFrameColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("msg_have_a_gift_voucher".tr(), style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 9.h),
          decoration: AppDecoration.outlineBluegray100
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Row(children: [
            CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 8.h)),
            Padding(
                padding: EdgeInsets.only(left: 6.w, top: 7.h, bottom: 7.h),
                child: Text("msg_enter_redeem_code".tr(),
                    style: CustomTextStyles.bodyMediumBluegray40001_1)),
            Spacer(),
            CustomElevatedButton(
                height: 36.h,
                width: 64.w,
                text: "lbl_apply".tr(),
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles
                    .gradientSecondaryContainerToPrimaryTL6Decoration,
                buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer)
          ]))
    ]);
  }

  /// Section Widget
  Widget _buildValueColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("msg_top_up_your_wallet".tr(), style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      BlocSelector<TopUpWalletBloc, TopUpWalletState, TopUpWalletModel?>(
          selector: (state) => state.topUpWalletModelObj,
          builder: (context, topUpWalletModelObj) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 121.h,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w),
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    topUpWalletModelObj?.userprofile8ItemList.length ?? 0,
                itemBuilder: (context, index) {
                  Userprofile8ItemModel model =
                      topUpWalletModelObj?.userprofile8ItemList[index] ??
                          Userprofile8ItemModel();
                  return Userprofile8ItemWidget(model);
                });
          })
    ]);
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          padding: EdgeInsets.all(9.w),
          decoration: AppDecoration.outlineBlueGray
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomImageView(
                imagePath: ImageConstant.imgClock,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 76.h)),
            Padding(
                padding: EdgeInsets.only(top: 19.h, bottom: 23.h),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("lbl_35".tr(), style: theme.textTheme.headlineSmall),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, top: 3.h, bottom: 2.h),
                        child: Text("lbl_kwd".tr(),
                            style: CustomTextStyles.titleLargeOnPrimary))
                  ]),
                  Text("lbl_free_7_kwd".tr(),
                      style: CustomTextStyles.bodyMediumLightgreen900)
                ]))
          ])),
      _buildRectangleStack(context)
    ]);
  }

  /// Section Widget
  Widget _buildFrameRow1(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildRectangleStack(context),
      Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: EdgeInsets.all(0),
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
                            EdgeInsets.only(left: 21.w, top: 19.h, right: 21.w),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("lbl_502".tr(),
                                    style: theme.textTheme.headlineSmall),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.w, top: 3.h, bottom: 2.h),
                                    child: Text("lbl_kwd".tr(),
                                        style: CustomTextStyles
                                            .titleLargeOnPrimary))
                              ]),
                          Text("lbl_free_10_kwd".tr(),
                              style: CustomTextStyles.bodyMediumLightgreen900)
                        ]))),
                CustomImageView(
                    imagePath: ImageConstant.imgClock,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.topLeft)
              ])))
    ]);
  }

  /// Section Widget
  Widget _buildPurchaseButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_purchase".tr(),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 31.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles
            .gradientSecondaryContainerToDeepOrangeTL28Decoration,
        buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
        onPressed: () {
          onTapPurchaseButton(context);
        });
  }

  /// Common widget
  Widget _buildRectangleStack(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.all(0),
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
                              Text("lbl_45".tr(),
                                  style: theme.textTheme.headlineSmall),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 3.h, bottom: 2.h),
                                  child: Text("lbl_kwd".tr(),
                                      style:
                                          CustomTextStyles.titleLargeOnPrimary))
                            ]),
                        Text("lbl_free_9_kwd".tr(),
                            style: CustomTextStyles.bodyMediumLightgreen900)
                      ]))),
              CustomImageView(
                  imagePath: ImageConstant.imgClock,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.topLeft)
            ])));
  }

  /// Displays a bottom sheet widget using the [showModalBottomSheet] method
  /// of the [Scaffold] class with [isScrollControlled] set to true.
  ///
  /// The bottom sheet is built using the [TopUpWalletPaymentMethodBottomsheet]
  /// class and the [builder] method of the bottom sheet is passed the
  /// [BuildContext] object.
  onTapPurchaseButton(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TopUpWalletPaymentMethodBottomsheet.builder(context),
        isScrollControlled: true);
  }
}
