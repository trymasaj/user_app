import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/apple_pay_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';

// ignore_for_file: must_be_immutable
class GiftsPaymentMethodBottomSheet extends StatefulWidget {
  const GiftsPaymentMethodBottomSheet(
      {super.key, required this.giftId, required this.totalPrice});
  final int giftId;
  final int totalPrice;

  Widget builder(BuildContext context, int giftId, int totalPrice) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DI.find<GiftsCubit>(),
        ),
        BlocProvider(
          create: (context) => DI.find<PaymentCubit>()..getPaymentMethods(),
        )
      ],
      child: GiftsPaymentMethodBottomSheet(
        giftId: giftId,
        totalPrice: totalPrice,
      ),
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
      listener: (BuildContext context, GiftsState state) {
        if (state.isError) {
          return showSnackBar(context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 40.0),
          child: SizedBox(
            width: double.maxFinite,
            height: 500.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: AppText.lbl_payment_method),
                const SizedBox(height: 18.0),
                Expanded(
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                      final paymentMethods = state.methods ?? [];
                      if (state.isLoading) return const CustomLoading();
                      if (paymentMethods.isEmpty)
                        return const EmptyPageMessage();
                      return ListView.builder(
                        itemCount: paymentMethods.length,
                        itemBuilder: (context, index) {
                          if (paymentMethods[index].id == 3) {
                            return ApplePayCustomButton(
                              onPressed: () async {
                                final cubit = context.read<GiftsCubit>();
                                final countryCubit =
                                    context.read<CountryCubit>();
                                final currentCountry =
                                    countryCubit.state.currentAddress?.country;
                                NavigatorHelper.of(context).pop();
                                Future.delayed(Duration(milliseconds: 100));
                                await cubit.purchaseGiftCard(context,
                                    paymentMethodId: 3,
                                    countryCode: currentCountry?.isoCode,
                                    currencyCode: currentCountry?.currencyIso,
                                    total: widget.totalPrice.toDouble(),
                                    giftId: widget.giftId);
                              },
                            );
                          }
                          return _buildPaymentMethodItem(paymentMethods[index]);
                        },
                      );
                    },
                    listener: (BuildContext context, PaymentState state) {
                      if (state.isError) {
                        return showSnackBar(context,
                            message: state.errorMessage);
                      }
                      if (state.isGetMethods)
                        _selectedPayment = state.methods?[0];
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
                        label: AppText.cancel,
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
                            giftsCubit.purchaseGiftCard(context,
                                paymentMethodId: _selectedPayment?.id,
                                giftId: widget.giftId);
                          },
                          label: AppText.lbl_purchase),
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
              paymentMethod?.title == "Credit Card"
                  ? Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/visa.svg',
                    height: 32,
                    width: 24,
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/images/master.svg',
                    height: 32,
                    width: 24,
                  ),
                ],
              )
                  : const SizedBox.shrink(),
              paymentMethod?.title == "Knet"
                  ? Row(
                children: [
                  Image.asset(
                    'assets/images/knet_logo.png',
                    width: 24,
                    height: 24,
                  ),
                ],
              )
                  : const SizedBox.shrink(),
              paymentMethod?.title == "Apple Pay"
                  ? Image.asset(
                'assets/images/apple_pay_image.png',
                width: 32,
                height: 24,
              )
                  : const SizedBox.shrink(),
              const SizedBox(width: 4),
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
