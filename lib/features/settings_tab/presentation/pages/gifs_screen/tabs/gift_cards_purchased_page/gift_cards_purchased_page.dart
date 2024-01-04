import 'package:masaj/core/app_export.dart';

import 'bloc/gift_cards_purchased_bloc.dart';
import 'models/gift_cards_purchased_model.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class GiftCardsPurchasedPage extends StatefulWidget {
  const GiftCardsPurchasedPage({Key? key})
      : super(
          key: key,
        );

  @override
  GiftCardsPurchasedPageState createState() => GiftCardsPurchasedPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<GiftCardsPurchasedBloc>(
      create: (context) => GiftCardsPurchasedBloc(GiftCardsPurchasedState(
        giftCardsPurchasedModelObj: GiftCardsPurchasedModel(),
      ))
        ..add(GiftCardsPurchasedInitialEvent()),
      child: GiftCardsPurchasedPage(),
    );
  }
}

class GiftCardsPurchasedPageState extends State<GiftCardsPurchasedPage>
    with AutomaticKeepAliveClientMixin<GiftCardsPurchasedPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardsPurchasedBloc, GiftCardsPurchasedState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.maxFinite,
              decoration: AppDecoration.white,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _buildGiftCardSection(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildGiftCardSection(BuildContext context) {
    return Container(
      width: 327.w,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder19,
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgGroup1175,
          ),
          fit: BoxFit.cover,
        ),
      ),
      foregroundDecoration: AppDecoration.gradientGrayToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder19,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 87.h),
            child: Text(
              "lbl_gift_card2".tr(),
              style: CustomTextStyles.bodyMediumOnPrimaryContainer,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgThumbsUpPink100,
            height: 67.adaptSize,
            width: 67.adaptSize,
            margin: EdgeInsets.only(
              left: 18.w,
              top: 16.h,
              bottom: 25.h,
            ),
          ),
          Spacer(),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant
                          .imgPhShareFatLightOnprimarycontainer20x20,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "lbl_share".tr(),
                        style: CustomTextStyles.titleSmallOnPrimaryContainer_1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 51.h),
              SizedBox(
                width: 72.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "lbl_25".tr(),
                      style: CustomTextStyles.headlineSmallOnPrimaryContainer,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "lbl_kwd".tr(),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
