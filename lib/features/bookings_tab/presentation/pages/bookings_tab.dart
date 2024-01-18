import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/bookings_tab/data/datasources/bookings_tab_remote_data_source.dart';
import 'package:masaj/features/bookings_tab/data/repositories/bookings_tab_repository.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/bookings_tab_cubit/bookings_tab_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/booking_card.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/payment_info_card.dart';
import 'package:masaj/features/providers_tab/presentation/pages/providers_tab.dart';
import 'package:masaj/gen/assets.gen.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  static const routeName = '/BookingsTabPage';

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  late BookingsTabCubit cubit;
  @override
  void initState() {
    cubit = BookingsTabCubit(
      bookingsTabRepository: BookingsTabRepositoryImpl(
        bookings_tabRemoteDataSource: BookingsTabRemoteDataSourceImpl(
          Injector().networkService,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingsTabCubit>.value(
      value: cubit,
      child: CustomAppPage(
        child: Scaffold(
          appBar: const CustomAppBar(
            title: 'bookings',
          ),
          body: BlocBuilder<BookingsTabCubit, BookingsTabState>(
            builder: (context, state) {
              return DefaultTabController(
                initialIndex: state.type.index,
                length: BookingsTabStateType.values.length,
                child: CustomScrollView(slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 0),
                    sliver: SliverPersistentHeader(
                      pinned: false,
                      delegate: TabBarDelegate(
                        // bgColor: MyColors.scaffoldBackgroundColorMain,
                        borderRadius: 15,
                        tabBar: TabBar(
                            labelPadding: const EdgeInsets.all(5),
                            isScrollable: false,
                            onTap: (value) {
                              cubit.changeType(
                                  BookingsTabStateType.values[value]);
                            },
                            indicatorColor: Colors.transparent,
                            labelColor: Colors.black,
                            // unselectedLabelColor: Colors.grey,
                            tabs: [
                              ...List.generate(
                                  BookingsTabStateType.values.length,
                                  (index) => Tab(
                                      height: 40.h,

                                      // height: 40,
                                      child: Container(
                                        width: 160.w,
                                        height: 40.h,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: state.type ==
                                                  BookingsTabStateType
                                                      .values[index]
                                              ? null
                                              : AppColors.ExtraLight,
                                          gradient: state.type ==
                                                  BookingsTabStateType
                                                      .values[index]
                                              ? AppColors.GRADIENT_Fill_COLOR
                                              : null,
                                          border: state.type ==
                                                  BookingsTabStateType
                                                      .values[index]
                                              ? GradientBoxBorder(
                                                  gradient:
                                                      AppColors.GRADIENT_COLOR,
                                                  width: 1,
                                                )
                                              : Border.all(
                                                  color:
                                                      const Color(0xffD9D9D9),
                                                  width: 1),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        alignment: Alignment.center,
                                        child: state.type ==
                                                BookingsTabStateType
                                                    .values[index]
                                            ? TextWithGradiant(
                                                text: BookingsTabStateType
                                                    .values[index].name,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )
                                            : CustomText(
                                                text: BookingsTabStateType
                                                    .values[index].name,
                                                fontSize: 14,
                                                //rgba(24, 27, 40, 0.4)
                                                color: const Color.fromARGB(
                                                        255, 24, 27, 40)
                                                    .withOpacity(.4),
                                                // color: const Color(0xff181b2866)
                                                //     .withOpacity(.4),
                                                fontWeight: FontWeight.w700,
                                              ),
                                      ))),
                            ]),
                      ),
                    ),
                  ),
                  if (state.type == BookingsTabStateType.upComaing)
                    SliverPadding(
                      padding: const EdgeInsets.only(
                          top: 24, left: 24, right: 24, bottom: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return const BookingCard();
                        }),
                      ),
                    ),
                  if (state.type == BookingsTabStateType.completed)
                    SliverPadding(
                      padding: const EdgeInsets.only(
                          top: 24, left: 24, right: 24, bottom: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return const BookingCard();
                        }),
                      ),
                    )
                ]),
              );
            },
          ),
        ),
      ),
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
