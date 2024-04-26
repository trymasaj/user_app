import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
part 'my_gifts_page.dart';
part 'new_gift_cards_page.dart';
part 'purchased_cards_page.dart';
part 'gift_card_item.dart';

class GiftCardsScreen extends StatefulWidget {
  static const routeName = '/GiftCards';

  const GiftCardsScreen({
    super.key,
  });

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Injector().giftsCubit..getGiftCards(),
        child: BlocBuilder<GiftsCubit, GiftsState>(
          builder: (context, state) {
            return CustomAppPage(
              child: Scaffold(
                  appBar: CustomAppBar(
                    title: 'lbl_gift_cards'.tr(),
                  ),
                  body: _buildBody(context)),
            );
          },
        ));
  }

  Widget _buildBody(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Column(
      children: [
        SizedBox(height: 25.h),
        _buildTopBar(context),
        SizedBox(height: 25.h),
        Expanded(
          child: TabBarView(controller: tabController, children: const [
            NewGiftCardsPage(),
            PurchasedGiftsPage(),
            MyGiftsPage(),
          ]),
        ),
        SizedBox(height: bottomPadding)
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.PRIMARY_COLOR,
        unselectedLabelColor: AppColors.GREY_DARK_COLOR,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.PRIMARY_COLOR),
          color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
        ),
        tabs: const [
          Tab(
            text: 'new',
          ),
          Tab(
            text: 'purchased',
          ),
          Tab(
            text: 'my_gifts',
          ),
        ],
      ),
    );
  }
}
