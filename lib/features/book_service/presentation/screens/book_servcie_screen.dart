import 'dart:developer';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/custom_bottom_sheet.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/data/models/time_slot.dart';
import 'package:masaj/features/book_service/enums/avalable_therapist_tab_enum.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/select_therapist_screen.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';
import 'package:masaj/features/payment/data/model/payment_model.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key, required this.serviceModel});
  final ServiceModel serviceModel;

  static const String routeName = '/bookServiceScreen';
  static Widget builder({
    required ServiceModel serviceModel,
  }) =>
      MultiBlocProvider(
          providers: [
            BlocProvider<AvialbleTherapistCubit>(
              create: (context) => Injector().avialbleTherapistCubit,
            ),
          ],
          child: BookServiceScreen(
            serviceModel: serviceModel,
          ));
  static MaterialPageRoute router({required ServiceModel serviceModel}) {
    return MaterialPageRoute(
        builder: (context) => builder(
              serviceModel: serviceModel,
            ));
  }

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  AvailableTherapistTabEnum? selectedTab;
  TimeSlotModel? selectedTimeSlot;
  final TextEditingController _dateController = TextEditingController();

  void setSelectedTimeSlot(TimeSlotModel timeSlot) {
    setState(() {
      selectedTimeSlot = timeSlot;
      _dateController.text =
          '${timeSlot.monthAndDay} ${timeSlot.hour}:${timeSlot.minute} ${timeSlot.amPm}';
    });
  }

  void setSelectedTab(AvailableTherapistTabEnum tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  void initState() {
    context.read<AvialbleTherapistCubit>().getTherapists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'book_service'),
      body: Column(
        children: [
          _buildServiceCard(),
          _buildDivider(),
          _buildBookingDetails(context),
          const Spacer(),
          _buldContinueButton(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Padding _buildBookingDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          const Row(
            children: [
              CustomText(
                text: 'booking_details',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.FONT_COLOR,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDatePicker(context),
          SizedBox(height: 16.h),
          Column(
            children: [
              Row(
                children: [
                  CustomText(
                    text: 'therapist'.tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_COLOR,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var tab in AvailableTherapistTabEnum.values)
                    _buildFilterTap(tab, selectedTab == tab)
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'msg_selected_therapist',
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.FONT_LIGHT_COLOR,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SelectTherapist.routeName,
                          arguments: context.read<AvialbleTherapistCubit>());
                    },
                    child: TextWithGradiant(
                      text: 'change',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.h),
              if (context
                      .watch<AvialbleTherapistCubit>()
                      .state
                      .selectedTherapist !=
                  null)
                TherapistWidget(
                  width: double.infinity,
                  therapist: context
                      .watch<AvialbleTherapistCubit>()
                      .state
                      .selectedTherapist!,
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTap(AvailableTherapistTabEnum tab, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setSelectedTab(tab);
      },
      child: Container(
        height: 80.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ExtraLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? tab.selectedIcon : tab.icon,
            ),
            SizedBox(height: 8.h),
            if (isSelected)
              TextWithGradiant(
                text: tab.hint,
                fontSize: 10,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              )
            else
              CustomText(
                text: tab.hint,
                fontSize: 10,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
                color: AppColors.FONT_LIGHT,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: 'date_and_time'.tr(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.FONT_COLOR,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        DefaultTextFormField(
          borderColor: Color(0xffD9D9D9),
          fillColor: Colors.transparent,
          currentFocusNode: FocusNode(),
          currentController: _dateController,
          isRequired: true,
          readOnly: true,
          hint: 'lbl_select_date'.tr(),
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                builder: (context) {
                  final timeSlots = TimeSlotModel.generateTimeSlots();
                  int selectedIndex = 2;
                  return CustomBottomSheet(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'select_date_and_time',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.FONT_COLOR,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                              height: 160.h,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: selectedIndex),
                                diameterRatio: 10,
                                selectionOverlay: Container(),
                                itemExtent: 40,
                                onSelectedItemChanged: (int index) {
                                  selectedIndex = index;
                                },
                                children:
                                    List.generate(timeSlots.length, (index) {
                                  final timeSlot = timeSlots[index];
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: CustomText(
                                            fontFamily: 'Poppins',
                                            text: timeSlot.monthAndDay,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff343C44),
                                          ),
                                        ),
                                        CustomText(
                                          fontFamily: 'Poppins',
                                          text: timeSlot.hour,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff343C44),
                                        ),
                                        CustomText(
                                          fontFamily: 'Poppins',
                                          text: timeSlot.minute,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff343C44),
                                        ),
                                        CustomText(
                                          fontFamily: 'Poppins',
                                          text: timeSlot.amPm,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff343C44),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )),
                          DefaultButton(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            isExpanded: true,
                            onPressed: () {
                              setSelectedTimeSlot(timeSlots[selectedIndex]);

                              Navigator.of(context).pop();
                            },
                            label: 'save',
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.FONT_LIGHT,
          ),
        ),
      ],
    );
  }

  Container _buildDivider() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: AppColors.ExtraLight,
      ),
    );
  }

  Container _buildServiceCard() {
    final image = (widget.serviceModel.mainImage == null ||
            widget.serviceModel.mainImage!.isEmpty)
        ? (widget.serviceModel.images.firstOrNull ?? '')
        : widget.serviceModel.mainImage;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.GREY_LIGHT_COLOR_2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                image: CustomCachedNetworkImageProvider(
                  image ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: widget.serviceModel.title ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.FONT_COLOR,
              ),
              CustomText(
                text: widget.serviceModel.description ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.PlaceholderColor,
              ),
              CustomText(
                text: 'Add on’s: Hot stone, Herbal Compresses',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.PlaceholderColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buldContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: DefaultButton(
        onPressed: () async {
          final addressCubit = context.read<MyAddressesCubit>();
          await addressCubit.getAddresses();
          final address = addressCubit.state.addressesData.first;
          log(address.formattedAddress ?? '');

          final therapist =
              context.read<AvialbleTherapistCubit>().state.selectedTherapist;
          final CheckOutModel checkOutModel = CheckOutModel(
              address: address,
              therapist: therapist,
              service: widget.serviceModel,
              paymentSummary: PaymentSummary(subTotal: 30, discount: 0));
          NavigatorHelper.of(context)
              .pushNamed(CheckoutScreen.routeName, arguments: checkOutModel);
        },
        label: 'continue',
        isExpanded: true,
      ),
    );
  }
}