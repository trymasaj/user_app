part of 'gift_cards.dart';

class PurchasedGiftsPage extends StatelessWidget {
  const PurchasedGiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Injector().giftsCubit..getPurchasedGiftCards(GiftCardStatus.Redeemed),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: _buildGiftCardsList(),
    );
  }

  Widget _buildGiftCardsList() {
    return BlocBuilder<GiftsCubit, GiftsState>(
      builder: (context, state) {
        final cubit = context.read<GiftsCubit>();
        if (state.isLoading) {
          return const CustomLoading();
        }
        final gifts = state.purchasedGiftCards ?? [];

        if ((gifts == [] || gifts.isEmpty)) {
          return RefreshIndicator(
              onRefresh: cubit.refresh,
              child: const EmptyPageMessage(
                heightRatio: 0.6,
              ));
        }
        return _buildGiftsList(cubit);
      },
    );
  }

  Widget _buildGiftsList(GiftsCubit cubit) {
    final gifts = cubit.state.purchasedGiftCards ?? [];

    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: gifts.length,
        itemBuilder: (context, index) => GiftCardItem(
          amount: gifts[index].amount!.toDouble(),
          action: TextButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/images/share.svg',
              color: Colors.white,
            ),
            label: SubtitleText.medium(
              text: 'share'.tr(),
              color: Colors.white,
              isBold: true,
            ),
          ),
        ),
      ),
    );
  }
}
