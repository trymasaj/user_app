import 'package:masaj/core/app_export.dart';

import '../models/transactionhistory_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransactionhistoryItemWidget extends StatelessWidget {
  TransactionhistoryItemWidget(
    this.transactionhistoryItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  TransactionhistoryItemModel transactionhistoryItemModelObj;

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
                  transactionhistoryItemModelObj.transactionTitle!,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  transactionhistoryItemModelObj.transactionDate!,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 22.h),
            child: Text(
              transactionhistoryItemModelObj.transactionAmount!,
              style: CustomTextStyles.bodyMediumLightgreen900,
            ),
          ),
        ],
      ),
    );
  }
}
