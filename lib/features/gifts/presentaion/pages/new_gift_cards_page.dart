part of 'gift_cards.dart';

class NewGiftCardsPage extends StatelessWidget {
  const NewGiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(child: _buildGiftCardsList()),
          DefaultButton(
            margin: const EdgeInsets.symmetric(vertical: 20),
            isExpanded: true,
            onPressed: () async {},
            label: 'purchase',
          ),
        ],
      ),
    );
  }

  Widget _buildGiftCardsList() {
    return BlocBuilder<GiftsCubit, GiftsState>(
      builder: (context, state) {
        final cubit = context.read<GiftsCubit>();

        // if (state.isLoading) {
        //   return const CustomLoading();
        // }
        // final gifts = state.giftCards ?? [];

        // if ((gifts == [] || gifts.isEmpty)) {
        //   return RefreshIndicator(
        //       onRefresh: cubit.refresh,
        //       child: const EmptyPageMessage(
        //         heightRatio: 0.6,
        //       ));
        // }
        return _buildGiftsList(cubit);
      },
    );
  }

  Widget _buildGiftsList(GiftsCubit cubit) {
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => GiftCardItem(
          amount: 20.0,
          action: Radio<bool>.adaptive(
            value: true,
            groupValue: true,
            onChanged: (value) {},
            activeColor: AppColors.PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
