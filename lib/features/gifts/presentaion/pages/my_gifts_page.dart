part of 'gift_cards.dart';

class MyGiftsPage extends StatelessWidget {
  const MyGiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().giftsCubit
        ..getPurchasedGiftCards(GiftCardStatus.Available),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(child: _buildGiftCardsList()),
        ],
      ),
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
    final gifts = cubit.state.purchasedGiftCards;
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
          itemCount: gifts?.length,
          itemBuilder: (context, index) =>
              _buildMyGiftItem(context, gifts![index])),
    );
  }

  Widget _buildMyGiftItem(BuildContext context, PurchasedGiftCard gift) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 70.0,
            width: 70.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.PRIMARY_COLOR.withOpacity(0.9),
                  AppColors.PRIMARY_COLOR.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image.asset(
              'assets/images/gift.png',
              scale: 2.8,
              color: AppColors.PRIMARY_COLOR.withOpacity(0.5),
              colorBlendMode: BlendMode.srcATop,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SubtitleText(
                  text: 'lbl_gift_card_off'.tr(args: [gift.amount.toString()])),
              const SizedBox(height: 8.0),
              SubtitleText(
                text: 'lbl_kwd'.tr(args: [gift.amount.toString()]),
                isBold: true,
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: gift.redemptionCode ?? ''));
              showSnackBar(context, message: 'msg_copy_code'.tr());
            },
          )
        ]),
      ),
    );
  }
}
