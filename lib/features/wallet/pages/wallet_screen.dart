import 'package:dartz/dartz.dart';
import 'package:masaj/core/app_export.dart';
import '../widgets/transactionhistory_item_widget.dart';
import '../bloc/wallet_bloc/wallet_bloc.dart';
import '../models/transactionhistory_item_model.dart';
import '../models/wallet_model.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';

  const WalletScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<WalletBloc>(
        create: (context) =>
            WalletBloc(WalletState(wallet: Wallet())),
        child: WalletScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
            child: Column(children: [
              _buildTopUp(context),
              SizedBox(height: 24.h),
              _buildTransactionHistory(context),
              SizedBox(height: 5.h)
            ])));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("lbl_wallet".tr()),
    );
  }

  /// Section Widget
  Widget _buildTopUp(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
        decoration: AppDecoration.fillGray10002
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text("lbl_5000".tr(),
                              style: theme.textTheme.headlineSmall),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, top: 8.h, bottom: 6.h),
                              child: Text("lbl_kwd".tr(),
                                  style: CustomTextStyles.titleSmallSemiBold_1))
                        ]),
                        SizedBox(height: 1.h),
                        Text("lbl_current_balance".tr(),
                            style: theme.textTheme.bodyMedium)
                      ])),
              CustomElevatedButton(
                  height: 36.h,
                  width: 109.w,
                  text: "lbl_top_up".tr(),
                  margin: EdgeInsets.only(top: 16.h, bottom: 7.h),
                  leftIcon: Container(
                      margin: EdgeInsets.only(right: 5.w),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgPlusOnprimarycontainer,
                          height: 15.adaptSize,
                          color: Colors.white,
                          width: 15.adaptSize)),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomButtonStyles
                      .gradientSecondaryContainerToDeepOrangeTL18Decoration,
                  buttonTextStyle:
                      CustomTextStyles.titleSmallOnPrimaryContainer,
                  onPressed: () {
                    onTapTopUp(context);
                  })
            ]));
  }

  /// Section Widget
  Widget _buildTransactionHistory(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CustomImageView(
            imagePath: ImageConstant.imgIcSharpHistory,
            height: 22.adaptSize,
            width: 22.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 2.h)),
        Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text("msg_transactions_history".tr(),
                style: CustomTextStyles.titleMediumGray90003SemiBold))
      ]),
      SizedBox(height: 12.h),
      BlocSelector<WalletBloc, WalletState, WalletStateStatus>(
          selector: (state) => state.status,
          builder: (context, status) {
            switch(state.) {
              case :

                break;
              default:
            }

            return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.h);
                },
                itemCount:
                    walletModelObj?.transactions.length ?? 0,
                itemBuilder: (context, index) {
                  Transaction model =
                      walletModelObj?.transactions[index] ??
                          Transaction();
                  return TransactionhistoryItemWidget(model);
                });
          })
    ]);
  }

  /// Navigates to the topUpWalletScreen when the action is triggered.
  onTapTopUp(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.topUpWalletScreen,
    );
*/
  }
}
