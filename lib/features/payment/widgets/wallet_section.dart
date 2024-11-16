
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';

class WalletSection extends StatefulWidget {
  const WalletSection({
    super.key,
    required this.totalPrice,
  });
  final double totalPrice;

  @override
  State<WalletSection> createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<WalletBloc>();
    cubit.getWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletBloc>();
    bool useWallet = walletCubit.state.useWallet;
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Row(
          children: [
            SubtitleText(text: AppText.use_wallet),
            SizedBox(width: 4.w),
            SubtitleText(
                text: AppText.lbl_kwd(args: [
              (walletCubit.state.walletBalance?.balance ?? 0).toString()
            ])),
            const Spacer(),
            CustomSwitch(
              // disable if the balance is zero
              onChange: (walletCubit.state.walletBalance?.balance == 0)? null : (value) {
                if ((walletCubit.state.walletBalance?.balance ?? 0) == 0)
                  return showSnackBar(context,
                      message: AppText.msg_wallet_balance);
                setState(() {
                  walletCubit.onChooseWallet(value);
                });
              },
              value: useWallet,
            ),
          ],
        );
      },
    );
  }
}
