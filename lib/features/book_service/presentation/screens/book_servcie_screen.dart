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
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';

import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';

import 'package:masaj/features/book_service/data/models/time_slot.dart';
import 'package:masaj/features/book_service/enums/avalable_therapist_tab_enum.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/select_therapist_screen.dart';
import 'package:masaj/features/home/presentation/widget/index.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';
import 'package:masaj/features/payment/data/model/payment_model.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';
import 'package:masaj/features/providers_tab/data/models/avilable_therapist_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  static const String routeName = '/bookServiceScreen';
  static Widget builder() => MultiBlocProvider(providers: [
        BlocProvider<AvialbleTherapistCubit>(
          create: (context) => Injector().avialbleTherapistCubit,
        ),
      ], child: BookServiceScreen());
  static MaterialPageRoute router() {
    return MaterialPageRoute(builder: (context) => builder());
  }

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  AvailableTherapistTabEnum? selectedTab;
  TimeSlotModel? selectedTimeSlot;
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;

  void setSelectedTab(AvailableTherapistTabEnum tab, BuildContext context) {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select date and time'),
      ));
    }
    setState(() {
      selectedTab = tab;
    });
    getAvailable();
  }

  Future<void> getAvailable() async {
    if (selectedTab == null || selectedDate == null) {
      return;
    }
    await context.read<AvialbleTherapistCubit>().getAvailableTherapists(
        bookingDate: selectedDate!, pickTherapistType: selectedTab!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'book_service'),
      body: BlocListener<AvialbleTherapistCubit, AvialbleTherapistState>(
        listener: (context, state) {
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? ''),
            ));
          }
        },
        child: Column(
          children: [
            // _buildServiceCard(),
            _buildDivider(),
            _buildBookingDetails(context),
            const Spacer(),
            _buldContinueButton(context),
            const SizedBox(height: 40),
          ],
        ),
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
                    _buildFilterTap(tab, selectedTab == tab, context)
                ],
              ),
              SizedBox(height: 20.h),
              if (context.watch<AvialbleTherapistCubit>().state.isLoading)
                CustomLoading(),
              if (context.watch<AvialbleTherapistCubit>().state.isLoaded &&
                  context
                      .watch<AvialbleTherapistCubit>()
                      .state
                      .availableTherapists
                      .isNotEmpty &&
                  context
                          .watch<AvialbleTherapistCubit>()
                          .state
                          .availableTherapists
                          .firstOrNull !=
                      null)
                Column(
                  children: [
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
                            Navigator.of(context).pushNamed(
                                SelectTherapist.routeName,
                                arguments:
                                    context.read<AvialbleTherapistCubit>());
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
                    TherapistWidget(
                      width: double.infinity,
                      therapist: context
                          .watch<AvialbleTherapistCubit>()
                          .state
                          .availableTherapists
                          .firstOrNull
                          ?.therapist!,
                    ),
                    SizedBox(height: 20.h),
                    _buildTimeSlotPicker(context),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTap(
      AvailableTherapistTabEnum tab, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setSelectedTab(tab, context);
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

  Widget _buildTimeSlotPicker(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: '_time'.tr(),
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
            final cubit = context.read<AvialbleTherapistCubit>();
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: CustomBottomSheet(
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
                                child: BlocBuilder<AvialbleTherapistCubit,
                                    AvialbleTherapistState>(
                                  builder: (context, state) {
                                    return CupertinoPicker(
                                        scrollController:
                                            FixedExtentScrollController(),
                                        diameterRatio: 10,
                                        selectionOverlay: Container(),
                                        itemExtent: 40,
                                        onSelectedItemChanged: (int index) {},
                                        children: [
                                          ...(state.selectedTherapist
                                                      ?.availableTimeSlots ??
                                                  [])
                                              .map((e) => Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child: CustomText(
                                                            fontFamily:
                                                                'Poppins',
                                                            text: e.hour
                                                                .toString(),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff343C44),
                                                          ),
                                                        ),
                                                        CustomText(
                                                          fontFamily: 'Poppins',
                                                          text: e.minute
                                                              .toString(),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff343C44),
                                                        ),
                                                        CustomText(
                                                          fontFamily: 'Poppins',
                                                          text: e.second
                                                              .toString(),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff343C44),
                                                        ),
                                                        // CustomText(
                                                        //   fontFamily: 'Poppins',
                                                        //   text: timeSlot.amPm,
                                                        //   fontSize: 16,
                                                        //   fontWeight:
                                                        //       FontWeight.w400,
                                                        //   color:
                                                        //       Color(0xff343C44),
                                                        // ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                        ]);
                                  },
                                )),
                            DefaultButton(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              isExpanded: true,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              label: 'save',
                            )
                          ],
                        ),
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
                          SizedBox(
                            height: 160.h,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.dateAndTime,
                              initialDateTime: selectedDate ?? DateTime.now(),
                              onDateTimeChanged: (DateTime dateTime) {
                                selectedDate = dateTime;
                                getAvailable();
                              },
                            ),
                          ),

                          // Container(
                          //     height: 160.h,
                          //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                          //     child: CupertinoPicker(
                          //       scrollController: FixedExtentScrollController(
                          //           initialItem: selectedIndex),
                          //       diameterRatio: 10,
                          //       selectionOverlay: Container(),
                          //       itemExtent: 40,
                          //       onSelectedItemChanged: (int index) {
                          //         selectedIndex = index;
                          //       },
                          //       children:
                          //           List.generate(timeSlots.length, (index) {
                          //         final timeSlot = timeSlots[index];
                          //         return Center(
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Container(
                          //                 width: 120,
                          //                 child: CustomText(
                          //                   fontFamily: 'Poppins',
                          //                   text: timeSlot.monthAndDay,
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Color(0xff343C44),
                          //                 ),
                          //               ),
                          //               CustomText(
                          //                 fontFamily: 'Poppins',
                          //                 text: timeSlot.hour,
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.w400,
                          //                 color: Color(0xff343C44),
                          //               ),
                          //               CustomText(
                          //                 fontFamily: 'Poppins',
                          //                 text: timeSlot.minute,
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.w400,
                          //                 color: Color(0xff343C44),
                          //               ),
                          //               CustomText(
                          //                 fontFamily: 'Poppins',
                          //                 text: timeSlot.amPm,
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.w400,
                          //                 color: Color(0xff343C44),
                          //               ),
                          //             ],
                          //           ),
                          //         );
                          //       }),
                          //     )),
                          DefaultButton(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            isExpanded: true,
                            onPressed: () {
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

  // Container _buildServiceCard() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 70.w,
  //           height: 70.h,
  //           decoration: BoxDecoration(
  //             color: AppColors.GREY_LIGHT_COLOR_2,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(12),
  //             ),
  //             image: DecorationImage(
  //               image: CustomCachedNetworkImageProvider(
  //                 image ?? '',
  //               ),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 16.w),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomText(
  //               text: widget.serviceModel.title ?? '',
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //               color: AppColors.FONT_COLOR,
  //             ),
  //             CustomText(
  //               text: widget.serviceModel.description ?? '',
  //               fontSize: 12,
  //               fontWeight: FontWeight.w400,
  //               color: AppColors.PlaceholderColor,
  //             ),
  //             CustomText(
  //               text: 'Add on’s: Hot stone, Herbal Compresses',
  //               fontSize: 12,
  //               fontWeight: FontWeight.w400,
  //               color: AppColors.PlaceholderColor,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buldContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: DefaultButton(
        onPressed: () async {
          final addressCubit = context.read<MyAddressesCubit>();
          await addressCubit.getAddresses();
          final address = addressCubit.state.addressesData.first;
          log(address.formattedAddress ?? '');

          await context.read<BookingCubit>().addBookingTherapist(
                therapistId: 1,
                availableTime: selectedDate!,
              );

          // final therapist =
          //     context.read<AvialbleTherapistCubit>().state.selectedTherapist;

          NavigatorHelper.of(context).pushNamed(CheckoutScreen.routeName);
        },
        label: 'continue',
        isExpanded: true,
      ),
    );
  }
}
