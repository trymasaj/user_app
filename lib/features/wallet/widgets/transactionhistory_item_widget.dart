import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';

// ignore: must_be_immutable
class TransactionItem extends StatelessWidget {
  const TransactionItem(
    this.transaction, {
    super.key,
  });

  final WalletTransactionHistory? transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 18.h,
      ),
      decoration: AppDecoration.outlineGray30001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction?.transactionReason ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  transaction?.transactionDate ?? '',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 22.h),
            child: Text(
              (transaction?.credit ?? '').toString(),
              style: CustomTextStyles.bodyMediumLightgreen900,
            ),
          ),
        ],
      ),
    );
  }
}
