part of 'gift_cards.dart';

class GiftCardItem extends StatelessWidget {
  const GiftCardItem({
    super.key,
    this.action,
    required this.amount,
    this.color = AppColors.THIRD_COLOR,
  });
  final Widget? action;
  final double amount;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
              image: const AssetImage('assets/images/gift.png'),
              scale: 2.8,
              colorFilter:
                  ColorFilter.mode(color.withOpacity(0.5), BlendMode.srcATop))),
      child: Column(
        children: [
          Row(
            children: [const Spacer(), if (action != null) action!],
          ),
          const Spacer(),
          Row(
            children: [
              const SubtitleText.medium(
                text: 'lbl_gift_card',
                color: Colors.white,
              ),
              const Spacer(),
              SubtitleText.medium(
                text: 'lbl_kwd'.tr(args: [amount.toString()]),
                color: Colors.white,
                isBold: true,
              )
            ],
          )
        ],
      ),
    );
  }
}
