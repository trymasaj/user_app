import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';

// ignore_for_file: must_be_immutable
class GiftsPaymentMethodBottomSheet extends StatefulWidget {
  const GiftsPaymentMethodBottomSheet({super.key, required this.giftId});
  final int giftId;
  Widget builder(BuildContext context, int giftId) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Injector().giftsCubit,
        ),
        BlocProvider(
          create: (context) => Injector().paymentCubit..getPaymentMethods(),
        )
      ],
      child: GiftsPaymentMethodBottomSheet(giftId: giftId),
    );
  }

  @override
  State<GiftsPaymentMethodBottomSheet> createState() =>
      _GiftsPaymentMethodBottomSheetState();
}

class _GiftsPaymentMethodBottomSheetState
    extends State<GiftsPaymentMethodBottomSheet> {
  PaymentMethodModel? _selectedPayment;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftsCubit, GiftsState>(
      listener: (BuildContext context, GiftsState state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 40.0),
          child: SizedBox(
            width: double.maxFinite,
            height: 500.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText(text: 'payment method'),
                const SizedBox(height: 18.0),
                Expanded(
                  child: BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                      final paymentMethods = state.methods ?? [];
                      if (state.isLoading) return const CustomLoading();
                      if (paymentMethods.isEmpty)
                        return const EmptyPageMessage();
                      return ListView.builder(
                        itemCount: paymentMethods.length,
                        itemBuilder: (context, index) {
                          return _buildPaymentMethodItem(paymentMethods[index]);
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: DefaultButton(
                        onPressed: () {
                          NavigatorHelper.of(context).pop();
                        },
                        label: 'cancel',
                        color: AppColors.ExtraLight,
                        borderColor: AppColors.ACCENT_COLOR,
                        textColor: AppColors.ACCENT_COLOR,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 10,
                      child: DefaultButton(
                          onPressed: () {
                            final giftsCubit = context.read<GiftsCubit>();
                            giftsCubit.redeemgift(
                                paymentMethodId: _selectedPayment?.id,
                                giftId: widget.giftId);
                          },
                          label: 'purchase'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethodModel? paymentMethod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = paymentMethod;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: paymentMethod == _selectedPayment
                ? AppColors.PRIMARY_COLOR.withOpacity(0.09)
                : AppColors.BACKGROUND_COLOR.withOpacity(0.09),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.PRIMARY_COLOR, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(children: [
              SubtitleText(
                text: paymentMethod?.title ?? '',
                isBold: true,
              ),
              const Spacer(),
              Radio.adaptive(
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: paymentMethod,
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value;
                    });
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
