import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/custom_bottom_sheet.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/book_service/data/models/booking_model/timeslot.dart';
import 'package:masaj/features/book_service/enums/avalable_therapist_tab_enum.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/select_therapist_screen.dart';
import 'package:masaj/features/home/presentation/widget/index.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';
import 'package:masaj/features/payment/presentaion/pages/checkout_screen.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  static const String routeName = '/bookServiceScreen';
  static Widget builder() => MultiBlocProvider(providers: [
        BlocProvider<AvialbleTherapistCubit>(
          create: (context) => DI.find<AvialbleTherapistCubit>(),
        ),
      ], child: const BookServiceScreen());
  static MaterialPageRoute router() {
    return MaterialPageRoute(
        builder: (context) => builder(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  AvailableTherapistTabItem? selectedTab;
  AvailableTimeSlot? selectedTimeSlot;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? selectedDate;

  // di
  SystemService system = DI.find();

  void setSelectedTimeSlot(AvailableTimeSlot timeSlot) {
    setState(() {
      selectedTimeSlot = timeSlot;
      _timeController.text = timeSlot.timeString12HourFormat;
    });
  }

  void setSelectedTab(AvailableTherapistTabItem tab, BuildContext context) {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(AppText.please_select_date_and_time),
      ));
    }
    setState(() {
      selectedTab = tab;
    });
    getAvailable();
  }

  Future<void> getAvailable() async {
    if (fromTherapistFow) {
      return;
    }
    if (selectedTab == null || selectedDate == null) {
      return;
    }
    await context.read<AvialbleTherapistCubit>().getAvailableTherapists(
        bookingDate: selectedDate!, pickTherapistType: selectedTab!);
  }

  @override
  void initState() {
    checkTherapistInBooking();
    // AdjustTracker.trackAddToBasket(
    //   context.read<BookingCubit>().state.bookingModel?.service?.title ?? '',
    //   context.read<BookingCubit>().state.bookingModel?.service?.duration ?? '',
    // );
    //print(context.read<BookingCubit>().state.bookingModel?.service?.duration);
    super.initState();
  }

  bool get fromTherapistFow =>
      context.read<BookingCubit>().state.selectedTherapist != null;

  Future<void> checkTherapistInBooking() async {
    if (fromTherapistFow) {
      context.read<AvialbleTherapistCubit>().getTherapistById(
          context.read<BookingCubit>().state.selectedTherapist!.therapistId!);
    }
  }

  Future _onChangeTherapist() async {
    final therapist = await Navigator.of(context).pushNamed<dynamic>(
        SelectTherapist.routeName,
        arguments: context.read<AvialbleTherapistCubit>());
    if (therapist != null) {
      context.read<AvialbleTherapistCubit>().selectTherapist(therapist);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            _buildContinueButton(context),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      appBar: CustomAppBar(title: AppText.book_service),
      body: BlocListener<AvialbleTherapistCubit, AvialbleTherapistState>(
        listener: (context, state) {
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? ''),
            ));
          }
        },
        child: BlocBuilder<AvialbleTherapistCubit, AvialbleTherapistState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // _buildServiceCard(),
                  _buildDivider(),
                  _buildBookingDetails(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final bookingModel = state.bookingModel;
        final service = bookingModel?.service;
        return Container(
          width: 280,
          padding: const EdgeInsets.all(10),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(
          //     color: AppColors.GREY_LIGHT_COLOR_2,
          //     width: 1,
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // image
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.GREY_LIGHT_COLOR_2,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CustomCachedNetworkImageProvider(
                      service?.mediaUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service?.title ?? '',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.FONT_COLOR),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // start from
                  Row(
                    children: [
                      Text(
                        AppText.duration,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor),
                      ),
                      Text(
                        ': ',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor),
                      ),
                      CustomText(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.FONT_LIGHT,
                          text:
                              "${bookingModel?.durationInMinutes}  ${AppText.min}")
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildBookingDetails(
      BuildContext context, AvialbleTherapistState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              CustomText(
                text: AppText.booking_details,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.FONT_COLOR,
              ),
            ],
          ),
          _buildServiceCard(context),
          SizedBox(height: 20.h),
          if (!fromTherapistFow)
            Column(
              children: [
                _buildDatePicker(context),
              ],
            ),
          SizedBox(height: 16.h),
          Column(
            children: [
              Row(
                children: [
                  CustomText(
                    text: AppText.therapist,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_COLOR,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (!fromTherapistFow)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var tab in availableTherapistsTabItems)
                          _buildFilterTap(tab, selectedTab == tab, context)
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              if (state.isLoading) const CustomLoading(),
              if (state.isLoaded && state.availableTherapists.isEmpty)
                SizedBox(
                  child: EmptyPageMessage(
                    message: AppText.no_therapist_available,
                    heightRatio: .4,
                    svgImage: 'empty',
                  ),
                ),
              if (state.isLoaded &&
                  state.availableTherapists.isNotEmpty &&
                  state.availableTherapists.firstOrNull != null)
                Column(
                  children: [
                    if (selectedTab?.index == 2)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppText.msg_selected_therapist,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.FONT_LIGHT_COLOR,
                          ),
                          GestureDetector(
                            onTap: _onChangeTherapist,
                            child: TextWithGradiant(
                              text: AppText.change,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    SizedBox(height: 8.h),
                    TherapistWidget(
                      isClckable: false,
                      width: double.infinity,
                      therapist:
                          state.availableTherapists.firstOrNull?.therapist!,
                    ),
                    SizedBox(height: 20.h),
                    if (fromTherapistFow)
                      Column(
                        children: [
                          _buildDatePicker(context),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    if (fromTherapistFow) _buildTimeSlotPicker(context, state),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTap(
      AvailableTherapistTabItem tab, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setSelectedTab(tab, context);
      },
      child: Container(
        height: 80.h,
        width: 100.w,
        padding: const EdgeInsets.symmetric(horizontal: 12),
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

  Widget _buildTimeSlotPicker(
      BuildContext context, AvialbleTherapistState state) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: AppText.time,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.FONT_COLOR,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (state.isTimeSlotsLoading)
          const CustomLoading()
        else if (!state.isTimeSlotsLoading)
          BlocListener<AvialbleTherapistCubit, AvialbleTherapistState>(
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                closeIconColor: Colors.white,
                content: Text(state.errorMessage ?? ''),
              ));
            },
            child: DefaultTextFormField(
              borderColor: const Color(0xffD9D9D9),
              fillColor: Colors.transparent,
              currentFocusNode: FocusNode(),
              currentController: _timeController,
              isRequired: true,
              readOnly: true,
              hint: AppText.lbl_select_date,
              onTap: () async {
                final cubit = context.read<AvialbleTherapistCubit>();
                await cubit.getAvailableTimeSlots(selectedDate!);
                Future.delayed(Duration.zero, () {
                  if (state.isTimeSlotsLoaded)
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        builder: (context) {
                          int? _selectedTimeSlot;
                          AvailableTimeSlot? firstTimeSlot;
                          bool didPickerSpinned = false;

                          return BlocProvider.value(
                            value: cubit,
                            child: BlocListener<AvialbleTherapistCubit,
                                AvialbleTherapistState>(
                              listener: (context, state) {
                                if (state.availableTimeSlots?.isNotEmpty ==
                                        true &&
                                    selectedTimeSlot == null) {
                                  firstTimeSlot =
                                      state.availableTimeSlots!.first;
                                  // setSelectedTimeSlot(state.availableTimeSlots!.first);
                                }
                              },
                              child: CustomBottomSheet(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: AppText.select_date_and_time,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.FONT_COLOR,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Container(
                                          height: 160.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w),
                                          child: BlocBuilder<
                                              AvialbleTherapistCubit,
                                              AvialbleTherapistState>(
                                            builder: (context, state) {
                                              if (state.availableTimeSlots
                                                  .isNotEmpty)
                                                return CupertinoPicker(
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                      initialItem: selectedTimeSlot ==
                                                              null
                                                          ? 0
                                                          : state
                                                              .availableTimeSlots
                                                              .indexOf(
                                                                  selectedTimeSlot!),
                                                    ),
                                                    diameterRatio: 10,
                                                    selectionOverlay:
                                                        Container(),
                                                    itemExtent: 40,
                                                    onSelectedItemChanged:
                                                        (int index) {
                                                      didPickerSpinned = true;
                                                      _selectedTimeSlot = index;
                                                    },
                                                    children: [
                                                      ...(state.availableTimeSlots ??
                                                              <AvailableTimeSlot>[])
                                                          .map((e) => Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          120,
                                                                      child:
                                                                          CustomText(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        text: e
                                                                            .timeString12HourFormat,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xff343C44),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ]);

                                              if (state.timeSlotsStatus ==
                                                  TimeSlotsStatus.loading)
                                                return const CustomLoading();
                                              if (state.timeSlotsStatus ==
                                                      TimeSlotsStatus.loaded &&
                                                  state.availableTimeSlots!
                                                      .isEmpty)
                                                return EmptyPageMessage(
                                                  message:
                                                      AppText.no_time_slots_available,
                                                  heightRatio: .4,
                                                );
                                              return Container();
                                            },
                                          )),
                                      Builder(builder: (context) {
                                        return DefaultButton(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          isExpanded: true,
                                          onPressed: () {
                                            if (_selectedTimeSlot != null)
                                              setSelectedTimeSlot(context
                                                      .read<
                                                          AvialbleTherapistCubit>()
                                                      .state
                                                      .availableTimeSlots![
                                                  _selectedTimeSlot!]); //Education2016

                                            if (!didPickerSpinned &&
                                                firstTimeSlot != null &&
                                                selectedTimeSlot == null) {
                                              setSelectedTimeSlot(
                                                  firstTimeSlot!);
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          label: AppText.save,
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                });
              },
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: AppColors.FONT_LIGHT,
              ),
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
              text: fromTherapistFow ? AppText.date : AppText.date_and_time,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.FONT_COLOR,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        DefaultTextFormField(
          borderColor: const Color(0xffD9D9D9),
          fillColor: Colors.transparent,
          currentFocusNode: FocusNode(),
          currentController: _dateController,
          isRequired: true,
          readOnly: true,
          hint: AppText.lbl_select_date,
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
                  DateTime updatedDate = (selectedDate != null &&
                          // date is in the past
                          selectedDate!.isAfter(system.now))
                      ? selectedDate!
                      : system.now.add(
                          Duration(minutes: 30 - system.now.minute % 30),
                        );
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
                                text: AppText.select_date_and_time,
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
                              minuteInterval: 30,

                              minimumDate: system.now.add(
                                Duration(
                                    minutes: 30 - system.now.minute % 30),
                              ),
                              mode: fromTherapistFow
                                  ? CupertinoDatePickerMode.date
                                  : CupertinoDatePickerMode.dateAndTime,
                              // mode: CupertinoDatePickerMode.date,
                              initialDateTime: (selectedDate != null &&
                                      // date is in the past
                                      selectedDate!.isAfter(system.now.add(
                                        Duration(
                                            minutes: 30 -
                                                system.now.minute % 30),
                                      )))
                                  ? selectedDate!
                                  : system.now.add(
                                      Duration(
                                          minutes:
                                              30 - system.now.minute % 30),
                                    ),
                              onDateTimeChanged: (DateTime dateTime) {
                                //print(dateTime);
                                updatedDate = dateTime;
                              },
                            ),
                          ),
                          DefaultButton(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            isExpanded: true,
                            onPressed: () {
                              selectedDate = updatedDate;
                              _dateController.text = fromTherapistFow == true
                                  ? DateFormat('E, MMM d, yyyy',
                                          context.locale.languageCode)
                                      .format(updatedDate)
                                  : DateFormat('E, MMM d, yyyy, hh:mm a',
                                          context.locale.languageCode)
                                      .format(updatedDate);
                              _timeController.clear();
                              selectedTimeSlot = null;
                              Navigator.of(context).pop();
                              getAvailable();
                            },
                            label: AppText.save,
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
      decoration: const BoxDecoration(
        color: AppColors.ExtraLight,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: DefaultButton(
        onPressed: () async {
          try {
            if (selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppText.please_select_date),
              ));
              return;
            }
            final therapist =
                context.read<AvialbleTherapistCubit>().state.selectedTherapist;
            if (therapist == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppText.please_select_therapist),
              ));
              return;
            }

            final therapistId = context
                .read<AvialbleTherapistCubit>()
                .state
                .selectedTherapist!
                .therapist!
                .therapistId;
            final addingTherapistSuccess =
                await context.read<BookingCubit>().addBookingTherapist(
                      therapistId: therapistId,
                      availableTime: getFinlaDate(),
                    );
            if (!addingTherapistSuccess) {
              final errorMsg =
                  context.read<BookingCubit>().state.errorMessage?.isEmpty ==
                          true
                      ? AppText.error_adding_therapist
                      : context.read<BookingCubit>().state.errorMessage;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errorMsg ?? ''),
                showCloseIcon: true,
                closeIconColor: Colors.white,
              ));
              return;
            }

            NavigatorHelper.of(context).pushNamedAndRemoveUntil(
                CheckoutScreen.routeName, (route) => route.isFirst);
          } catch (e) {
            DI.find<AbsLogger>().error('$runtimeType', e);
          }
        },
        label: AppText.lbl_continue,
        isExpanded: true,
      ),
    );
  }

  DateTime? getFinlaDate() {
    if (selectedDate == null) {
      return null;
    }

    if (fromTherapistFow) {
      return selectedTimeSlot?.convertToDate(selectedDate!);
    } else {
      return selectedDate;
    }
  }
}
