import 'package:masaj/core/app_export.dart';

import '../gift_cards_my_gifts_page/widgets/giftcardlist_item_widget.dart';
import 'bloc/gift_cards_my_gifts_bloc.dart';
import 'models/gift_cards_my_gifts_model.dart';
import 'models/giftcardlist_item_model.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class GiftCardsMyGiftsPage extends StatefulWidget {
  const GiftCardsMyGiftsPage({Key? key})
      : super(
          key: key,
        );

  @override
  GiftCardsMyGiftsPageState createState() => GiftCardsMyGiftsPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<GiftCardsMyGiftsBloc>(
      create: (context) => GiftCardsMyGiftsBloc(GiftCardsMyGiftsState(
        giftCardsMyGiftsModelObj: GiftCardsMyGiftsModel(),
      ))
        ..add(GiftCardsMyGiftsInitialEvent()),
      child: GiftCardsMyGiftsPage(),
    );
  }
}

class GiftCardsMyGiftsPageState extends State<GiftCardsMyGiftsPage>
    with AutomaticKeepAliveClientMixin<GiftCardsMyGiftsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.white,
          child: Column(
            children: [
              SizedBox(height: 22.h),
              _buildGiftCardList(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGiftCardList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 22.w,
      ),
      child: BlocSelector<GiftCardsMyGiftsBloc, GiftCardsMyGiftsState,
          GiftCardsMyGiftsModel?>(
        selector: (state) => state.giftCardsMyGiftsModelObj,
        builder: (context, giftCardsMyGiftsModelObj) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount:
                giftCardsMyGiftsModelObj?.giftcardlistItemList.length ?? 0,
            itemBuilder: (context, index) {
              GiftcardlistItemModel model =
                  giftCardsMyGiftsModelObj?.giftcardlistItemList[index] ??
                      GiftcardlistItemModel();
              return GiftcardlistItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }
}
