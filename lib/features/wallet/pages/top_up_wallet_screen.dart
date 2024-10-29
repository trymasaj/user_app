import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/overlay/top_up_wallet_payment_method_bottomsheet.dart';

class TopUpWalletScreen extends StatefulWidget {
  static const routeName = '/top-up-wallet';

  const TopUpWalletScreen({super.key});

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: context.read<WalletBloc>()..getPredefinedAmounts(),
      ),
      BlocProvider(
        create: (context) => DI.find<PaymentCubit>()..getPaymentMethods(),
      ),
      BlocProvider(
        create: (context) => DI.find<GiftsCubit>(),
      )
    ], child: const TopUpWalletScreen());
  }

  @override
  State<TopUpWalletScreen> createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  int? _selectedIndex;
  final TextEditingController _giftController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(children: [
              SizedBox(height: 24.h),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 24.w, right: 24.w, bottom: 5.h),
                          child: Column(children: [
                            _buildFrameColumn(context),
                            SizedBox(height: 25.h),
                            _buildPackages(context),
                            SizedBox(height: 12.h),
                          ]))))
            ])),
        bottomNavigationBar: _buildPurchaseButton(context));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_wallet_top_up,
    );
  }

  /// Section Widget
  Widget _buildFrameColumn(BuildContext context) {
    final walletCubit = context.read<WalletBloc>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(AppText.msg_have_a_gift_voucher, style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      BlocConsumer<GiftsCubit, GiftsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: DefaultTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty)
                  return AppText.lbl_gift_voucher_validation;
              },
              currentController: _giftController,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
                    child: CustomElevatedButton(
                        height: 36.h,
                        width: 64.w,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<GiftsCubit>()
                                .redeemGiftCard(context, _giftController.text);
                          } else {
                            showSnackBar(context,
                                message: AppText.lbl_gift_voucher_validation);
                          }
                        },
                        text: AppText.lbl_apply,
                        buttonStyle: CustomButtonStyles.none,
                        decoration: CustomButtonStyles
                            .gradientSecondaryContainerToPrimaryTL6Decoration,
                        buttonTextStyle:
                            CustomTextStyles.labelLargeOnPrimaryContainer),
                  ),
                  prefixIcon: CustomImageView(
                      imagePath: ImageConstant.imgTelevision,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.h, horizontal: 12.w)),
                  prefixIconConstraints: BoxConstraints(
                      minWidth: 20.adaptSize, minHeight: 20.adaptSize),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      borderSide: BorderSide.none)),
              currentFocusNode: null,
              hint: AppText.msg_enter_redeem_code,
            ),
          );
        },
        listener: (BuildContext context, GiftsState state) async {
          if (state.isLoaded) await walletCubit.getWalletBalance();
        },
      ),
    ]);
  }

  /// Section Widget
  Widget _buildPackages(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(AppText.msg_top_up_your_wallet, style: theme.textTheme.titleSmall),
      SizedBox(height: 8.h),
      BlocSelector<WalletBloc, WalletState, List<WalletAmountsModel>?>(
          selector: (state) => state.predefinedAmounts,
          builder: (context, state) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 121.h,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildAmountItem(state![index], index);
                });
          })
    ]);
  }

  Widget _buildAmountItem(WalletAmountsModel walletAmountsModel, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: appTheme.blueGray100, width: 1.w),
              borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Container(
              height: 120.h,
              width: 158.w,
              padding: EdgeInsets.all(9.w),
              decoration: AppDecoration.outlineBlueGray
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
              child: Stack(alignment: Alignment.topLeft, children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 23.w, top: 19.h, right: 23.w),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.w, top: 3.h, bottom: 2.h),
                                    child: Text(
                                        AppText.lbl_kwd(args: [
                                          walletAmountsModel.amount.toString()
                                        ]),
                                        style: CustomTextStyles
                                            .titleLargeOnPrimary))
                              ]),
                          Text(
                              AppText.lbl_free_kwd(args: [
                                walletAmountsModel.bonusAmount.toString()
                              ]),
                              style: CustomTextStyles.bodyMediumLightgreen900)
                        ]))),
                SvgPicture.asset(
                    isSelected
                        ? 'assets/images/radio_button.svg'
                        : ImageConstant.imgClock,
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    alignment: Alignment.topLeft)
              ]))),
    );
  }

  /// Section Widget
  Widget _buildPurchaseButton(BuildContext context) {
    return CustomElevatedButton(
        text: AppText.lbl_purchase,
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 31.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles
            .gradientSecondaryContainerToDeepOrangeTL28Decoration,
        buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
        onPressed: () {
          onTapPurchaseButton(context);
        });
  }

  void onTapPurchaseButton(BuildContext context) {
    if (_selectedIndex != null) {
      final selectedPredefinedAMount =
          context.read<WalletBloc>().state.predefinedAmounts![_selectedIndex!];
      final total = (selectedPredefinedAMount.totalAmount ?? 0) -
          (selectedPredefinedAMount.bonusAmount ?? 0);
      showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          builder: (_) => TopUpWalletPaymentMethodBottomsheet(
                walletPredefinedAmountId: selectedPredefinedAMount.id!,
                totalAmount: total,
              ).builder(context, selectedPredefinedAMount.id!, total),
          isScrollControlled: true);
    } else
      showSnackBar(context, message: AppText.select_at_least_one);
  }
}
