import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';

// ignore_for_file: must_be_immutable
class TopUpWalletPaymentMethodBottomsheet extends StatefulWidget {
  const TopUpWalletPaymentMethodBottomsheet(
      {super.key, required this.walletPredefinedAmountId});
  final int walletPredefinedAmountId;
  Widget builder(BuildContext context, int walletPredefinedAmountId) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Injector().walletCubit,
        ),
        BlocProvider(
          create: (context) => Injector().paymentCubit..getPaymentMethods(),
        )
      ],
      child: TopUpWalletPaymentMethodBottomsheet(
          walletPredefinedAmountId: walletPredefinedAmountId),
    );
  }

  @override
  State<TopUpWalletPaymentMethodBottomsheet> createState() =>
      _TopUpWalletPaymentMethodBottomsheetState();
}

class _TopUpWalletPaymentMethodBottomsheetState
    extends State<TopUpWalletPaymentMethodBottomsheet> {
  PaymentMethodModel? _selectedPayment;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (BuildContext context, WalletState state) {},
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
                // _buildCouponItem(
                //   PaymentMethodModel(isSelected: false, title: 'gift card'),
                // ),
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
                            final walletCubit = context.read<WalletBloc>();
                            walletCubit.chargeWallet(context,
                                paymentMethodId: _selectedPayment?.id,
                                walletPredefinedAmountId:
                                    widget.walletPredefinedAmountId);
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

  // Widget _buildCouponItem(PaymentMethodModel? paymentMethod) {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _selectedPayment = paymentMethod;
  //           });
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 6.0),
  //           child: DecoratedBox(
  //             decoration: BoxDecoration(
  //               color: paymentMethod == _selectedPayment
  //                   ? AppColors.PRIMARY_COLOR.withOpacity(0.09)
  //                   : AppColors.BACKGROUND_COLOR.withOpacity(0.09),
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(color: AppColors.PRIMARY_COLOR, width: 1.5),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(24.0),
  //               child: Row(children: [
  //                 SubtitleText(
  //                   text: paymentMethod?.title ?? '',
  //                   isBold: true,
  //                 ),
  //                 const Spacer(),
  //                 Radio.adaptive(
  //                     activeColor: AppColors.PRIMARY_COLOR,
  //                     value: paymentMethod,
  //                     groupValue: _selectedPayment,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         _selectedPayment = value;
  //                       });
  //                     })
  //               ]),
  //             ),
  //           ),
  //         ),
  //       ),
  //       DefaultTextFormField(
  //         currentFocusNode: _node,
  //         currentController: _controller,
  //         hint: 'add Coupon code',
  //         decoration: InputDecoration(
  //             hintText: 'msg_enter_redeem_code'.tr(),
  //             hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
  //             suffixIcon: Padding(
  //               padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
  //               child: CustomElevatedButton(
  //                   height: 36.h,
  //                   width: 64.w,
  //                   onPressed: () {
  //                     print('helooo');
  //                   },
  //                   text: 'lbl_apply'.tr(),
  //                   buttonStyle: CustomButtonStyles.none,
  //                   decoration: CustomButtonStyles
  //                       .gradientSecondaryContainerToPrimaryTL6Decoration,
  //                   buttonTextStyle:
  //                       CustomTextStyles.labelLargeOnPrimaryContainer),
  //             ),
  //             prefixIcon: CustomImageView(
  //                 imagePath: ImageConstant.imgTelevision,
  //                 height: 20.adaptSize,
  //                 width: 20.adaptSize,
  //                 margin:
  //                     EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w)),
  //             prefixIconConstraints: BoxConstraints(
  //                 minWidth: 20.adaptSize, minHeight: 20.adaptSize),
  //             border: OutlineInputBorder(
  //                 borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 borderSide: BorderSide.none)),
  //       ),
  //     ],
  //   );
  // }

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
