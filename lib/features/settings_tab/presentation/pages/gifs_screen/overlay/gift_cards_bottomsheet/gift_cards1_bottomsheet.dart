import 'package:masaj/core/app_export.dart';

import 'bloc/gift_cards1_bloc.dart';
import 'models/gift_cards1_model.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class GiftCards1Bottomsheet extends StatelessWidget {
  const GiftCards1Bottomsheet({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<GiftCards1Bloc>(
      create: (context) => GiftCards1Bloc(GiftCards1State(
        giftCards1ModelObj: GiftCards1Model(),
      ))
        ..add(GiftCards1InitialEvent()),
      child: GiftCards1Bottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 157.w,
        vertical: 20.h,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL38,
      ),
      child: Container(
        height: 6.h,
        width: 61.w,
        decoration: BoxDecoration(
          color: appTheme.gray4007f,
          borderRadius: BorderRadius.circular(
            2.w,
          ),
        ),
      ),
    );
  }
}
