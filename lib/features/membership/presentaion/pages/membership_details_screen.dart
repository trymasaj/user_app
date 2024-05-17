import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/membership/presentaion/bloc/membership_cubit.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';

class MembershipCheckoutScreen extends StatefulWidget {
  const MembershipCheckoutScreen({super.key, required this.membershipCubit});
  static const String routeName = '/checkoutScreen';
  final MembershipCubit membershipCubit;
  @override
  State<MembershipCheckoutScreen> createState() =>
      _MembershipCheckoutScreenState();
}

class _MembershipCheckoutScreenState extends State<MembershipCheckoutScreen> {
  static const double _kDividerThickness = 6;
  static const double _KSectionPadding = 24;
  PaymentMethodModel? _selectedPayment;

  late final TextEditingController _couponEditingController;
  late final TextEditingController _walletController;
  late final FocusNode _couponFocusNode;

  @override
  void initState() {
    _couponEditingController = TextEditingController();
    _walletController = TextEditingController();
    _couponFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _couponEditingController.dispose();
    _walletController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => Injector().paymentCubit..getPaymentMethods(),
          ),
          BlocProvider.value(
            value: widget.membershipCubit,
          ),
        ],
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'lbl_membership_plan'.tr(),
          ),
          body: _buildBody(),
        ),
      );
    });
  }

  Widget _buildBody() {
    return BlocConsumer<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return BlocConsumer<MembershipCubit, MembershipState>(
          builder: (context, state) {
            if (state.isLoading) return const CustomLoading();

            return CustomAppPage(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceSection(context),
                    const Divider(
                      thickness: _kDividerThickness,
                      color: AppColors.ExtraLight,
                    ),
                    _buildPaymentSection(context),
                    const Divider(
                      thickness: _kDividerThickness,
                      color: AppColors.ExtraLight,
                    ),
                    _buildSummarySection(context),
                    _buildCheckoutButton(context)
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, MembershipState state) {
            if (state.isError)
              showSnackBar(context, message: state.errorMessage);
          },
        );
      },
      listener: (BuildContext context, PaymentState state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
    );
  }

  Widget _buildServiceSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        children: [
          _buildServiceTitle(context),
        ],
      ),
    );
  }

  Widget _buildServiceTitle(BuildContext context) {
    final membershipCubit = context.read<MembershipCubit>();
    final membershipModel = membershipCubit.state.plans;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleText(
          text: membershipModel?.name ?? '',
          isBold: true,
        ),
        const SizedBox(height: 5.0),
        SubtitleText(
          text: membershipModel?.description ?? '',
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    final planModel = context.read<MembershipCubit>().state.plans;

    final num total = planModel?.price ?? 0;
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(
            text: 'payment_method',
          ),
          WalletSection(
            controller: _walletController,
            totalPrice: total.toDouble(),
          ),
          _buildPaymentMethods()
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoading();
        }
        final methods = state.methods ?? [];

        if ((methods == [] || methods.isEmpty)) {
          return const EmptyPageMessage();
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: methods.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildPaymentMethodItem(methods[index]);
            });
      },
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethodModel paymentMethod) {
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
                text: paymentMethod.title ?? '',
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

  Padding _buildSummarySection(BuildContext context) {
    final planModel = context.read<MembershipCubit>().state.plans;
    final num subTotal = planModel?.price ?? 0;
    final num total = planModel?.price ?? 0;

    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: 'lbl_summary'),
          const SizedBox(height: 12.0),
          _buildSummaryItem(title: 'lbl_sub_total2', amount: subTotal),
          const SizedBox(height: 12.0),
          const Divider(
            thickness: 3,
            color: AppColors.ExtraLight,
          ),
          const SizedBox(height: 12.0),
          _buildSummaryItem(title: 'total', amount: total),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      {bool isDiscount = false, required String title, required num amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SubtitleText(
            text: title,
            color: isDiscount ? AppColors.SUCCESS_COLOR : null,
            subtractedSize: -1,
          ),
          const Spacer(),
          SubtitleText(
            text: '$amount KWD',
            isBold: true,
          )
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(top: 10),
      child: DefaultButton(
        isExpanded: true,
        onPressed: () async {
          final cubit = context.read<MembershipCubit>();

          await cubit.purchaseSubscription(context,
              paymentMethod: _selectedPayment,
              planId: cubit.state.plans?.id,
              fromWallet: false);
        },
        label: 'lbl_upgrade_now',
      ),
    );
  }
}
