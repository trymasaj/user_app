import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/book_service/enums/booking_status.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/booking_details_cubit/booking_details_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/booking_card.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/payment_info_card.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/therapist_info_card.dart';

class BookingDetialsScreen extends StatefulWidget {
  const BookingDetialsScreen({super.key, required this.id});
  final int id;
  static const routeName = '/BookingDetialsScreen';
  static Widget builder(BuildContext context, int id) => BlocProvider(
      create: (c) => Injector().bookingDetailsCubit,
      child: BookingDetialsScreen(
        id: id,
      ));

  @override
  State<BookingDetialsScreen> createState() => _BookingDetialsScreenState();
}

class _BookingDetialsScreenState extends State<BookingDetialsScreen> {
  @override
  void initState() {
    context.read<BookingDetailsCubit>().getBookingDetails(
          widget.id,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().paymentCubit..getPaymentMethods(),
      child: CustomAppPage(
        child: Scaffold(
          // bottomNavigationBar: Container(
          //   // top elevation
          //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
          //     // elevation in top
          //     BoxShadow(
          //         color: const Color(0xff9DB2D6).withOpacity(.13),
          //         offset: const Offset(0, -3),
          //         blurRadius: 8,
          //         spreadRadius: 1)
          //   ]),
          //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          //   child: Row(children: [
          //     Expanded(
          //       child: DefaultButton(
          //         borderColor: AppColors.ERROR_COLOR,
          //         textColor: AppColors.ERROR_COLOR,
          //         color: Colors.white,
          //         label: 'cancel'.tr(),
          //         onPressed: () {},
          //       ),
          //     ),
          //     SizedBox(width: 8.w),
          //     Expanded(
          //       child: DefaultButton(
          //         label: 'reschedule'.tr(),
          //         onPressed: () {},
          //       ),
          //     ),
          //   ]),
          // ),
          appBar: const CustomAppBar(
            title: 'Booking details',
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<BookingDetailsCubit>().getBookingDetails(
                    widget.id,
                  );
            },
            child: BlocConsumer<BookingDetailsCubit, BookingDetailsState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error ?? ''),
                  ));
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        if (state.isLoading)
                          const Center(
                            child: CustomLoading(
                              loadingStyle: LoadingStyle.ShimmerList,
                            ),
                          ),
                        if (state.booking != null) ...[
                          if (state.booking!.bookingStatus ==
                              BookingStatus.Cancelled)
                            _buildCancelledAlert(),
                          BookingCard(
                            sessionModel: state.booking?.toSessionModel(),
                            enable: false,
                          ),
                          SizedBox(height: 12.h),
                          TherapistInfoCard(
                            bookingModel: state.booking!,
                          ),
                          SizedBox(height: 12.h),
                          PaymentInfoCard(
                            bookingModel: state.booking!,
                          )
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildCancelledAlert() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff9A3B3B14).withOpacity(.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/canceled.svg',
              ),
              SizedBox(width: 10.w),
              CustomText(
                text: 'your_booking_has_been_cancelled',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          height: 50.h,
        ),
        SizedBox(height: 12.h)
      ],
    );
  }
}

class DateModel {
  final String day;
  final String weekDay;
  final String month;
  final String year;

  // am or pm
  final String time;

  DateModel(
      {required this.day,
      required this.weekDay,
      required this.month,
      required this.year,
      required this.time});

  @override
  String toString() {
    return '$day $weekDay $month $year $time';
  }
}

String getWeekDay(int weekDay) {
  switch (weekDay) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    default:
      return 'Sunday';
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'Febuary';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'Augest';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    default:
      return 'December';
  }
}

String getTime(int hour, int minute) {
// with am or pm
  final amOrPm = hour >= 12 ? 'pm' : 'am';
  // 24 hour format to 12 hour format
  final hourIn12Format = hour > 12 ? hour - 12 : hour;
  // if hour is 0 then it is 12 am
  final hourStr = hourIn12Format == 0 ? '12' : hourIn12Format.toString();
  final minuteStr = minute < 10 ? '0$minute' : minute.toString();
  return '$hourStr:$minuteStr $amOrPm';
}

// convert date to DateModel
DateModel convertDateToModel(DateTime date) {
  // day like 12
  // weekDay like Monday
  // month like January
  // year like 2021
  // time like 12:00 am
  final day = date.day.toString();
  final weekDay = getWeekDay(date.weekday);
  final month = getMonth(date.month);
  final year = date.year.toString();
  final time = getTime(date.hour, date.minute);
  return DateModel(
      day: day, weekDay: weekDay, month: month, year: year, time: time);
}
