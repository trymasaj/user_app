import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/configs/payment_configration.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/apple_pay_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/bookings_tab/data/models/review_request.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/review_tips_cubit/review_tips_cubit.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:pay/pay.dart';

enum TipsAmountEnumn {
  one('1_kwd', 1),
  two('2_kwd', 2),
  other('other');

  final String name;
  final int? value;
  const TipsAmountEnumn(this.name, [this.value]);
}

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.bookingModel});
  static const routeName = '/add-review';
  static Widget builder(BuildContext context, BookingModel bookingModel) =>
      BlocProvider(
        create: (context) => Injector().reviewTipsCubit,
        child: AddReviewScreen(
          bookingModel: bookingModel,
        ),
      );
  static Route route(
    BookingModel bookingModel,
  ) =>
      MaterialPageRoute(
          builder: (context) => AddReviewScreen.builder(context, bookingModel));

  final BookingModel bookingModel;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  static const double _KSubVerticalSpace = 12;
  static const double _KSectionPadding = 24;
  late TextEditingController _walletController;
  late FocusNode _walletFocusNode;

  late TextEditingController _customerOpinionController;
  late FocusNode _customerOpinionFocusNode;
  late TextEditingController _improveServicesController;
  late FocusNode _improveServicesFocusNode;

  Widget _buildWriteReviwButton() {
    return BlocListener<ReviewTipsCubit, ReviewTipsCubitState>(
      listener: (context, state) {
        if (state.isLoaded) {
          Navigator.of(context).pop(state);
        }
        if (state.isError) {
          showSnackBar(
            context,
            message: state.errorMessage,
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: DefaultButton(
          label: 'write_review'.tr(),
          isExpanded: true,
          onPressed: () async {
            if (_selectedTipAmount != null && _selectedPayment == null) {
              showSnackBar(context,
                  message: 'please_select_payment_method'.tr());
              return;
            }
            await context.read<ReviewTipsCubit>().addReview(
                tipAmount: _selectedTipAmount == null ? null : _totalPrice,
                reviewRequest: ReviewRequest(
                    bookingId: widget.bookingModel.bookingId ?? 0,
                    rating: _rating,
                    customerOpinion: _customerOpinionController.text,
                    improveServicesHint: _improveServicesController.text),
                paymentMethodId: _selectedPayment?.id ?? 0,
                walletPayment: false,
                applePayToken: '');
          },
        ),
      ),
    );
  }

  TipsAmountEnumn? _selectedTipAmount;
  @override
  void initState() {
    _walletController = TextEditingController();
    _customerOpinionController = TextEditingController();
    _improveServicesController = TextEditingController();
    _walletFocusNode = FocusNode();
    _customerOpinionFocusNode = FocusNode();
    _improveServicesFocusNode = FocusNode();

    super.initState();
  }

  PaymentMethodModel? _selectedPayment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().paymentCubit..getPaymentMethods(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'add_review',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildReviewForm(),
              _buildDivider(),
              _buildTipsSection(context),
              _buildWriteReviwButton()
            ],
          ),
        ),
      ),
    );
  }

  Column _buildTipsSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  const CustomText(
                    text: 'tips',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff19223C),
                  ),
                  SizedBox(width: 4.w),
                  const CustomText(
                    text: 'optional',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8C8C8C),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              const Row(
                children: [
                  CustomText(
                    text: 'tip_amount',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1D212C),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var tipAmount in TipsAmountEnumn.values)
                    GestureDetector(
                      onTap: () {
                        if (_selectedTipAmount == tipAmount) {
                          setState(() {
                            _selectedTipAmount = null;
                            print(
                                ' Selected amount tip + ${_selectedTipAmount}');
                          });
                          return;
                        }

                        if (tipAmount == TipsAmountEnumn.other) {
                          setState(() {
                            _selectedTipAmount = tipAmount;
                          });
                          // show dialog
                        } else {
                          _walletController.text = tipAmount.value.toString();
                          setState(() {
                            _selectedTipAmount = tipAmount;
                          });
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: 103.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: tipAmount == _selectedTipAmount
                              ? AppColors.PRIMARY_COLOR.withOpacity(0.09)
                              : AppColors.BACKGROUND_COLOR.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.PRIMARY_COLOR, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: TextWithGradiant(
                          disableGradiant: tipAmount != _selectedTipAmount,
                          text: tipAmount.name.tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.FONT_LIGHT_COLOR,
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(height: 16.h),
              if (_selectedTipAmount == TipsAmountEnumn.other)
                DefaultTextFormField(
                    fillColor: Colors.white,
                    borderColor: const Color(0xffD9D9D9),
                    currentFocusNode: _walletFocusNode,
                    currentController: _walletController,
                    hint: 'enter_amount'.tr()),
            ],
          ),
        ),
        _buildPaymentSection(context, 0.0),
      ],
    );
  }

  Container _buildDivider() {
    return Container(
      height: 6.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.ExtraLight,
      ),
    );
  }

  double get _totalPrice {
    final useWallet = context.read<WalletBloc>().state.useWallet;
    final double wallet =
        useWallet ? double.tryParse(_walletController.text) ?? 0.0 : 0.0;
    if (_selectedTipAmount == TipsAmountEnumn.other) {
      return double.tryParse(_walletController.text) ?? 0;
    }
    // return ((_selectedTipAmount?.value) as num?) ?? 0;
    return (_selectedTipAmount?.value ?? 0)?.toDouble() ?? 0;
  }

  int _rating = 3;
  void _onRatingUpdate(double rating) {
    _rating = rating.toInt();
  }

  Widget _buildReviewForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        children: [
          const Row(
            children: [
              CustomText(
                text: 'review',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xff19223C),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Row(
            children: [
              CustomText(
                text: 'what_is_you_rate',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff1D212C),
              )
            ],
          ),
          // SizedBox(height: 16.h),
          Row(
            children: [
              RatingBar(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star,
                    color: Color(0xffD9D9D9),
                  ),
                ),
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: _onRatingUpdate,
              )
            ],
          ),
          SizedBox(height: 16.h),
          const Row(
            children: [
              CustomText(
                text: 'please_share_your_opinion',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff1D212C),
              )
            ],
          ),
          const Row(
            children: [
              CustomText(
                text: 'optional',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff8C8C8C),
              )
            ],
          ),
          SizedBox(height: 8.h),
          DefaultTextFormField(
              maxLines: 4,
              currentFocusNode: _customerOpinionFocusNode,
              currentController: _customerOpinionController,
              hint: ''),
          SizedBox(height: 16.h),
          Row(
            children: [
              const CustomText(
                text: 'how_can_we_improve_our_services',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff1D212C),
              ),
              SizedBox(width: 8.w),
              const CustomText(
                text: 'optional',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff8C8C8C),
              )
            ],
          ),
          SizedBox(height: 8.h),
          DefaultTextFormField(
              maxLines: 4,
              currentFocusNode: _improveServicesFocusNode,
              currentController: _improveServicesController,
              hint: ''),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context, double totalPrice) {
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
            totalPrice: totalPrice,
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
              return _buildPaymentMethodItem(context, methods[index], 0.0);
            });
      },
    );
  }

  Widget _buildPaymentMethodItem(BuildContext context,
      PaymentMethodModel paymentMethod, double totalPrice) {
    if (paymentMethod.id == 3) {
      return ApplePayCustomButton(
        onPressed: () async {
          final cubit = context.read<PaymentCubit>();
          final countryCubit = context.read<CountryCubit>();
          final currentCountry = countryCubit.state.currentAddress?.country;
          await cubit.tipTherapist(
            context,
            3,
            countryCode: currentCountry?.isoCode,
            currencyCode: currentCountry?.currencyIso,
            total: _totalPrice,
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
}
