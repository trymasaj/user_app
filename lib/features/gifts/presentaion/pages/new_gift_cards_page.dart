part of 'gift_cards.dart';

class NewGiftCardsPage extends StatefulWidget {
  const NewGiftCardsPage({super.key});

  @override
  State<NewGiftCardsPage> createState() => _NewGiftCardsPageState();
}

class _NewGiftCardsPageState extends State<NewGiftCardsPage> {
  int? _selectIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().giftsCubit..getGiftCards(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<GiftsCubit, GiftsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(child: _buildGiftCardsList()),
              DefaultButton(
                margin: const EdgeInsets.symmetric(vertical: 20),
                isExpanded: true,
                onPressed: () async {
                  onTapPurchaseButton(context);
                },
                label: 'purchase',
              ),
            ],
          ),
        );
      },
    );
  }

  void onTapPurchaseButton(BuildContext context) {
    if (_selectIndex != null) {
      final id = context.read<GiftsCubit>().state.giftCards?[_selectIndex!].id;
      showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          builder: (_) =>
              GiftsPaymentMethodBottomSheet(giftId: id!).builder(context, id),
          isScrollControlled: true);
    } else
      showSnackBar(context, message: 'select at least one');
  }

  Widget _buildGiftCardsList() {
    return BlocBuilder<GiftsCubit, GiftsState>(
      builder: (context, state) {
        final cubit = context.read<GiftsCubit>();

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
    );
  }

  Widget _buildGiftsList(GiftsCubit cubit) {
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: cubit.state.giftCards?.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectIndex = index;
            });
          },
          child: GiftCardItem(
            amount: 20.0,
            color: cubit.state.giftCards![index].imageColor!,
            action: Radio.adaptive(
              value: index,
              groupValue: _selectIndex,
              onChanged: (value) {
                setState(() {
                  _selectIndex = index;
                });
              },
              activeColor: AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}