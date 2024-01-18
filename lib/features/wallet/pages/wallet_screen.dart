import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/features/wallet/application/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/pages/top_up_wallet_screen.dart';
import 'package:masaj/features/wallet/widgets/transactionhistory_item_widget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';

  const WalletScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WalletBloc>(
        child: const WalletScreen(),
        create: (context) => getIt<WalletBloc>()..getTransactionHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
          child: Column(children: [
            _buildTopUp(context),
            SizedBox(height: 24.h),
            Row(children: [
              CustomImageView(
                  imagePath: ImageConstant.imgIcSharpHistory,
                  height: 22.adaptSize,
                  width: 22.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 2.h)),
              Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text('msg_transactions_history'.tr(),
                      style: CustomTextStyles.titleMediumGray90003SemiBold))
            ]),
            SizedBox(height: 12.h),
            Expanded(child: _buildTransactionHistory(context)),
            SizedBox(height: 5.h)
          ]),
        ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('lbl_wallet'.tr()),
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
                          Text('lbl_5000'.tr(),
                              style: theme.textTheme.headlineSmall),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, top: 8.h, bottom: 6.h),
                              child: Text('lbl_kwd'.tr(),
                                  style: CustomTextStyles.titleSmallSemiBold_1))
                        ]),
                        SizedBox(height: 1.h),
                        Text('lbl_current_balance'.tr(),
                            style: theme.textTheme.bodyMedium)
                      ])),
              CustomElevatedButton(
                  height: 36.h,
                  width: 109.w,
                  text: 'lbl_top_up'.tr(),
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
                    NavigatorHelper.of(context)
                        .pushNamed(TopUpWalletScreen.routeName);
                  })
            ]));
  }

  WalletState getState(BuildContext context) =>
      context.read<WalletBloc>().state;

  Widget _buildTransactionHistory(BuildContext context) {
    return BlocSelector<WalletBloc, WalletState, WalletStateStatus>(
      builder: (context, status) {
        if (status == WalletStateStatus.loaded) {
          final transactions =
              getState(context).wallet.toNullable()!.transactions;
          return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transactions[index]);
              });
        }
        if (status == WalletStateStatus.error) {
          return Center(child: Text('msg_error'.tr()));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      selector: (WalletState state) => state.status,
    );
  }
}
