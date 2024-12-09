import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';
import 'package:masaj/features/wallet/pages/top_up_wallet_screen.dart';
import 'package:masaj/features/wallet/widgets/transactionhistory_item_widget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';

  const WalletScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WalletBloc>.value(
        child: const WalletScreen(),
        value: context.read<WalletBloc>()..getWalletBalance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: context.read<WalletBloc>().refresh,
          child: Padding(
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
                    child: Text(AppText.msg_transactions_history,
                        style: CustomTextStyles.titleMediumGray90003SemiBold))
              ]),
              SizedBox(height: 12.h),
              Expanded(child: _buildTransactionHistory(context)),
              SizedBox(height: 5.h)
            ]),
          ),
        ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_wallet,
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
                          BlocSelector<WalletBloc, WalletState, WalletModel?>(
                            selector: (state) {
                              return state.walletBalance;
                            },
                            builder: (context, state) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 8.h, bottom: 6.h),
                                  child: Text(
                                      AppText.lbl_kwd(args: [
                                        (state?.balance ?? '').toString()
                                      ]),
                                      style: CustomTextStyles
                                          .titleSmallSemiBold_1));
                            },
                          ),
                        ]),
                        SizedBox(height: 1.h),
                        Text(AppText.lbl_current_balance,
                            style: theme.textTheme.bodyMedium)
                      ])),
              CustomElevatedButton(
                  height: 36.h,
                  width: 109.w,
                  text: AppText.lbl_top_up,
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
                        .pushNamed(TopUpWalletScreen.routeName)
                        .then((_) =>
                            context.read<WalletBloc>().getWalletBalance());
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
              getState(context).walletBalance?.walletTransactionHistory;
          return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemCount: transactions?.length ?? 0,
              itemBuilder: (context, index) {
                return TransactionItem(transactions?[index]);
              });
        }
        if (status == WalletStateStatus.error) {
          return Center(child: Text(AppText.msg_something_went_wrong));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      selector: (WalletState state) => state.status,
    );
  }
}
