import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/core/helpers/date_helper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/apple_pay_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/checkout_cubit.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/payment/widgets/coupon.dart';
import 'package:masaj/features/payment/widgets/wallet_section.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/checkoutScreen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _kDividerThickness = 6;
  static const double _KSubVerticalSpace = 12;
  static const double _KSectionPadding = 24;
  PaymentMethodModel? _selectedPayment;

  late final TextEditingController _couponEditingController;
  late final FocusNode _couponFocusNode;
  final SystemService systemService = DI.find();

  @override
  void initState() {
    _couponEditingController = TextEditingController();
    _couponFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _couponEditingController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppText.checkout_title,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return BlocConsumer<BookingCubit, BookingState>(
          builder: (context, state) {
            if (state.isLoading) return const CustomLoading();

            return CustomAppPage(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceSection(),
                    const Divider(
                      thickness: _kDividerThickness,
                      color: AppColors.ExtraLight,
                    ),
                    _buildDetailsSection(context),
                    const Divider(
                      thickness: _kDividerThickness,
                      color: AppColors.ExtraLight,
                    ),
                    _buildTherapistSection(context),
                    const Divider(
                      thickness: _kDividerThickness,
                      color: AppColors.ExtraLight,
                    ),
                    _buildLocationSection(context),
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
          listener: (BuildContext context, BookingState state) {
            if (state.isError)
              showSnackBar(context, message: state.errorMessage);
          },
        );
      },
      listener: (BuildContext context, PaymentState state) {
        if (state.isGetMethods) _selectedPayment = state.methods?[0];

        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
    );
  }

  Widget _buildServiceSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        children: [
          _buildServiceTitle(context),
          const SizedBox(height: _KSubVerticalSpace),
          WarningContainer(title: AppText.checkout_warning),
        ],
      ),
    );
  }

  Row _buildServiceTitle(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    final bookingModel = bookingCubit.state.bookingModel;
    return Row(
      children: [
        CustomCachedNetworkImage(
          imageUrl: bookingModel?.service?.mediaUrl,
          height: 70.0,
          width: 70.0,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(12.0),
        ),
        const SizedBox(width: _KSubVerticalSpace),
        SizedBox(
          width: 280.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtitleText(
                text: bookingModel?.service?.title ?? '',
                isBold: true,
              ),
              const SizedBox(height: 5.0),
              SubtitleText.small(
                text: bookingModel?.service?.description ?? '',
                maxLines: 4,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    final cubit = context.read<BookingCubit>();
    final bookingModel = cubit.state.bookingModel;
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: AppText.details),
          const SizedBox(height: _KSubVerticalSpace),
          _buildDetailsRow(
              title: '${AppText.date}:',
              content: DateHelper.formatDate(bookingModel?.bookingDate) ?? ''),
          _buildDetailsRow(
              title: '${AppText.time}:',
              content:
                  DateHelper.formatDateTime(bookingModel?.bookingDate) ?? ''),
          _buildDetailsRow(
            title: '${AppText.name}:',
            content:
                (bookingModel?.members ?? []).map((e) => e.name).join(', '),
          ),
          _buildDetailsRow(
              title: '${AppText.phone}:',
              content: (bookingModel?.members?.first.countryCode ?? '') +
                  (bookingModel?.members?.first.phone ?? '')),
        ],
      ),
    );
  }

  Widget _buildDetailsRow({required String title, required String content}) {
    return Row(
      children: [
        SubtitleText(text: title),
        const SizedBox(width: 24.0),
        SubtitleText(text: content)
      ],
    );
  }

  Widget _buildTherapistSection(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    final bookingModel = bookingCubit.state.bookingModel;
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: AppText.therapist,
            color: AppColors.ACCENT_COLOR,
          ),
          const SizedBox(height: _KSubVerticalSpace),
          Row(
            children: [
              CustomCachedNetworkImage(
                imageUrl: bookingModel?.therapist?.profileImage,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleText(
                    text: bookingModel?.therapist?.fullName ?? '',
                    isBold: true,
                  ),
                  SubtitleText(text: bookingModel?.therapist?.title ?? ''),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    final bookingModel = bookingCubit.state.bookingModel;
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: AppText.location),
          const SizedBox(height: _KSubVerticalSpace),
          TitleText(
            text: bookingModel?.address?.addressTitle ?? '',
            subtractedSize: 2,
          ),
          const SizedBox(height: 4),
          SubtitleText(text: bookingModel?.address?.formattedAddress ?? ''),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    final bookingModel = context.read<BookingCubit>().state.bookingModel;

    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: AppText.payment_method,
          ),
          WalletSection(
            totalPrice: bookingModel?.grandTotal?.toDouble() ?? 0,
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
              return _buildPaymentMethodItem(context, methods[index]);
            });
      },
    );
  }

  Widget _buildPaymentMethodItem(
      BuildContext context, PaymentMethodModel paymentMethod) {
    final walletCubit = context.read<WalletBloc>();
    if (paymentMethod.id == 3) {
      // prevent apple pay in android
      if (systemService.currentOS != OS.iOS) return Container();

      final bookingModel = context.read<BookingCubit>().state.bookingModel;

      final useWallet = walletCubit.state.useWallet;
      final num discount = bookingModel?.discountedAmount ?? 0;

      final double walletPayAmount = useWallet
          ? walletCubit.state.walletBalance?.balance?.toDouble() ?? 0.0
          : 0.0;
      final num totalWithDiscounts =
          (bookingModel?.grandTotal ?? 0) - walletPayAmount - discount;
      final num total = totalWithDiscounts < 0 ? 0 : totalWithDiscounts;

      return ApplePayCustomButton(
        onPressed: () async {
          final cubit = context.read<PaymentCubit>();
          final walletCubit = context.read<WalletBloc>();
          final countryCubit = context.read<CountryCubit>();
          final currentCountry = countryCubit.state.currentAddress?.country;

          await cubit.confirmOrder(
            3,
            bookingModel?.bookingId,
            countryCode: currentCountry?.isoCode,
            currencyCode: currentCountry?.currencyIso,
            total: total.toDouble(),
            fromWallet: walletCubit.state.useWallet,
          );
        },
      );
    }
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
            color:
                !context.read<CheckoutCubit>().isPaymentMethodsEnabled(context)
                    ? AppColors.BORDER_COLOR
                    : paymentMethod == _selectedPayment
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
                  onChanged: !context
                          .read<CheckoutCubit>()
                          .isPaymentMethodsEnabled(context)
                      ? null
                      : (PaymentMethodModel? value) {
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

  Widget _buildSummarySection(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final walletCubit = context.read<WalletBloc>();

        final bookingModel = context.read<BookingCubit>().state.bookingModel;
        final useWallet = walletCubit.state.useWallet;
        final num subTotal = bookingModel?.subtotal ?? 0;
        final num tax = bookingModel?.vatAmount ?? 0;
        final num discount = bookingModel?.discountedAmount ?? 0;

        final double wallet = useWallet
            ? walletCubit.state.walletBalance?.balance?.toDouble() ?? 0.0
            : 0.0;
        final num totalWithDiscounts =
            (bookingModel?.grandTotal ?? 0 + tax) - wallet - discount;
        final num total = totalWithDiscounts < 0 ? 0 : totalWithDiscounts;
        return Padding(
          padding: const EdgeInsets.all(_KSectionPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(text: AppText.booking_summary),
              const SizedBox(height: 12.0),
              _buildCoupon(),
              const SizedBox(height: 12.0),
              _buildSummaryItem(
                  title: AppText.lbl_sub_total2, amount: subTotal),
              _buildSummaryItem(title: AppText.lbl_tax, amount: tax),
              _buildSummaryItem(
                  isDiscount: true,
                  title: AppText.lbl_discount,
                  amount: discount),
              _buildSummaryItem(title: AppText.lbl_wallet, amount: wallet),
              const SizedBox(height: 12.0),
              const Divider(
                thickness: 3,
                color: AppColors.ExtraLight,
              ),
              const SizedBox(height: 12.0),
              _buildSummaryItem(title: AppText.total, amount: total),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoupon() {
    return CouponWidget(
        couponFocusNode: _couponFocusNode,
        couponEditingController: _couponEditingController);
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
            text: '${amount.toStringAsFixed(2)} KWD',
            isBold: true,
          )
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    final walletCubit = context.read<WalletBloc>();
    final bookingModel = bookingCubit.state.bookingModel;
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(top: 10),
      child: DefaultButton(
        isExpanded: true,
        onPressed: () async {
          final cubit = context.read<PaymentCubit>();

          await cubit.confirmOrder(
            _selectedPayment?.id ?? 1,
            bookingModel?.bookingId,
            fromWallet: walletCubit.state.useWallet,
          );
        },
        label: AppText.lbl_book_now,
      ),
    );
  }
}
