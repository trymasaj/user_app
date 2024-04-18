import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';

class GiftCardsScreen extends StatefulWidget {
  static const routeName = '/GiftCards';

  const GiftCardsScreen({
    super.key,
  });

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
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

  Padding _buildBody(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          _buildTopBar(context),
          SizedBox(height: 25.h),
          _buildGiftCardsList(),
          DefaultButton(
            margin: const EdgeInsets.symmetric(vertical: 20),
            isExpanded: true,
            onPressed: () async {},
            label: 'purchase',
          ),
          SizedBox(height: bottomPadding)
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container();
  }

  Widget _buildGiftCardsList() {
    return Builder(builder: (context) {
      final cubit = context.read<GiftsCubit>();

      return Expanded(
        flex: 10,
        child: BlocBuilder<GiftsCubit, GiftsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CustomLoading();
            }
            final gifts = state.giftCards ?? [];

            if ((gifts == [] || gifts.isEmpty)) {
              return RefreshIndicator(
                  onRefresh: cubit.refresh,
                  child: const EmptyPageMessage(
                    heightRatio: 0.6,
                  ));
            }
            return _buildGiftsList(cubit);
          },
        ),
      );
    });
  }

  Widget _buildGiftsList(GiftsCubit cubit) {
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: cubit.state.giftCards?.length,
        itemBuilder: (context, index) => _buildMemberItem(cubit, index),
      ),
    );
  }

  Widget _buildMemberItem(GiftsCubit cubit, int index) {
    return BlocBuilder<MembersCubit, MembersState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
      );
    });
  }
}
