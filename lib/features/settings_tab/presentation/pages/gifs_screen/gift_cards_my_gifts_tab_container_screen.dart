import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_my_gifts_page/gift_cards_my_gifts_page.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_page/gift_cards_page.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_purchased_page/gift_cards_purchased_page.dart';

import 'bloc/gift_cards_my_gifts_tab_container_bloc.dart';
import 'models/gift_cards_my_gifts_tab_container_model.dart';
import 'package:flutter/material.dart';

class GiftCardsScreen extends StatefulWidget {
  static const routeName = '/gift-cards';

  const GiftCardsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  GiftCardsScreenState createState() => GiftCardsScreenState();
  static Widget builder(BuildContext context) {
    return BlocProvider<GiftCardsMyGiftsTabContainerBloc>(
      create: (context) =>
          GiftCardsMyGiftsTabContainerBloc(GiftCardsMyGiftsTabContainerState(
        giftCardsMyGiftsTabContainerModelObj:
            GiftCardsMyGiftsTabContainerModel(),
      ))
            ..add(GiftCardsMyGiftsTabContainerInitialEvent()),
      child: GiftCardsScreen(),
    );
  }
}

class GiftCardsScreenState extends State<GiftCardsScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardsMyGiftsTabContainerBloc,
        GiftCardsMyGiftsTabContainerState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 23.h),
                  _buildTabview(context),
                  SizedBox(
                    height: 638.h,
                    child: TabBarView(
                      controller: tabviewController,
                      children: [
                        GiftCardsPage(),
                        GiftCardsPurchasedPage(),
                        GiftCardsMyGiftsPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 192.w,
            ),
            child: Row(
              children: [
                AppbarTitleIconbutton(
                  imagePath: ImageConstant.imgGroup1000002973,
                ),
                AppbarSubtitle(
                  text: "lbl_gift_cards".tr(),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    top: 6.h,
                    bottom: 7.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(),
            ),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 42.h,
      width: 327.w,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: theme.colorScheme.secondaryContainer,
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: appTheme.blueGray40001,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            21.w,
          ),
          gradient: LinearGradient(
            begin: Alignment(0, 0.5),
            end: Alignment(1, 0.5),
            colors: [
              theme.colorScheme.secondaryContainer.withOpacity(0.09),
              theme.colorScheme.primary.withOpacity(0.09),
              appTheme.deepOrange200.withOpacity(0.09),
            ],
          ),
        ),
        tabs: [
          Tab(
            child: Text(
              "lbl_new".tr(),
            ),
          ),
          Tab(
            child: Text(
              "lbl_purchased".tr(),
            ),
          ),
          Tab(
            child: Text(
              "lbl_my_gifts".tr(),
            ),
          ),
        ],
      ),
    );
  }
}
