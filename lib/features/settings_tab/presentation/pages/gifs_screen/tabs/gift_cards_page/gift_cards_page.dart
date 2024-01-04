import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/overlay/gift_cards_bottomsheet/gift_cards1_bottomsheet.dart';

import '../gift_cards_page/widgets/giftcardsection_item_widget.dart';
import 'bloc/gift_cards_bloc.dart';
import 'models/gift_cards_model.dart';
import 'models/giftcardsection_item_model.dart';
import 'package:flutter/material.dart';

class GiftCardsPage extends StatefulWidget {
  const GiftCardsPage({Key? key}) : super(key: key);

  @override
  GiftCardsPageState createState() => GiftCardsPageState();

  static Widget builder(BuildContext context) {
    return BlocProvider<GiftCardsBloc>(
        create: (context) =>
            GiftCardsBloc(GiftCardsState(giftCardsModelObj: GiftCardsModel()))
              ..add(GiftCardsInitialEvent()),
        child: GiftCardsPage());
  }
}

class GiftCardsPageState extends State<GiftCardsPage>
    with AutomaticKeepAliveClientMixin<GiftCardsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.white,
                child: Column(children: [
                  SizedBox(height: 24.h),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(children: [
                        _buildGiftCardSection(context),
                        SizedBox(height: 78.h),
                        CustomElevatedButton(
                            text: "lbl_purchase".tr(),
                            buttonStyle: CustomButtonStyles.none,
                            decoration: CustomButtonStyles
                                .gradientSecondaryContainerToDeepOrangeTL28Decoration,
                            onPressed: () {
                              onTapPurchase(context);
                            })
                      ]))
                ]))));
  }

  /// Section Widget
  Widget _buildGiftCardSection(BuildContext context) {
    return BlocSelector<GiftCardsBloc, GiftCardsState, GiftCardsModel?>(
        selector: (state) => state.giftCardsModelObj,
        builder: (context, giftCardsModelObj) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 14.h);
              },
              itemCount: giftCardsModelObj?.giftcardsectionItemList.length ?? 0,
              itemBuilder: (context, index) {
                GiftcardsectionItemModel model =
                    giftCardsModelObj?.giftcardsectionItemList[index] ??
                        GiftcardsectionItemModel();
                return GiftcardsectionItemWidget(model);
              });
        });
  }

  /// Displays a bottom sheet widget using the [showModalBottomSheet] method
  /// of the [Scaffold] class with [isScrollControlled] set to true.
  ///
  /// The bottom sheet is built using the [GiftCards1Bottomsheet]
  /// class and the [builder] method of the bottom sheet is passed the
  /// [BuildContext] object.
  onTapPurchase(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => GiftCards1Bottomsheet.builder(context),
        isScrollControlled: true);
  }
}
