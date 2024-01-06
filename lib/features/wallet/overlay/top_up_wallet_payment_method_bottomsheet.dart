import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/app_decoration.dart';

import '../bloc/top_up_wallet_bottom_sheet/top_up_wallet_payment_method_bloc.dart';
import '../models/top_up_wallet_payment_method_model.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class TopUpWalletPaymentMethodBottomsheet extends StatelessWidget {

  const TopUpWalletPaymentMethodBottomsheet({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<TopUpWalletPaymentMethodBloc>(
      create: (context) =>
          TopUpWalletPaymentMethodBloc(TopUpWalletPaymentMethodState(
        topUpWalletPaymentMethodModelObj: TopUpWalletPaymentMethodModel(),
      ))
            ..add(TopUpWalletPaymentMethodInitialEvent()),
      child: TopUpWalletPaymentMethodBottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 157.w,
        vertical: 19.h,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL32,
      ),
      child: Divider(
        color: appTheme.gray4007f,
      ),
    );
  }
}
