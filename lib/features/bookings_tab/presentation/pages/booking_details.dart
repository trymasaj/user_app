import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/enums/booking_status.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/booking_details_cubit/booking_details_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/review_tips_cubit/review_tips_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/pages/add_review_screen.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/booking_card.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/payment_info_card.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/therapist_info_card.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';

class BookingDetialsScreen extends StatefulWidget {
  const BookingDetialsScreen({super.key, required this.id});
  final int id;
  static const routeName = '/BookingDetialsScreen';
  static Widget builder(BuildContext context, int id) => BlocProvider(
      create: (c) => DI.find<BookingDetailsCubit>(),
      child: BookingDetialsScreen(
        id: id,
      ));

  @override
  State<BookingDetialsScreen> createState() => _BookingDetialsScreenState();
}

class _BookingDetialsScreenState extends State<BookingDetialsScreen> {

  // di
  SystemService system = DI.find();

  @override
  void initState() {
    context.read<BookingDetailsCubit>().getBookingDetails(
          widget.id,
        );
    super.initState();
  }

  bool isCompleted(BookingModel bookingModel) {
    return bookingModel.bookingDate?.isBefore(system.now) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DI.find<PaymentCubit>()..getPaymentMethods(),
      child: CustomAppPage(
        child: Scaffold(
          bottomNavigationBar: _buildCompletedActionButton(),
          appBar: CustomAppBar(
            title: AppText.booking_details,
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
                          // if (!isCompleted(state.booking!))
                          if ((state.booking!.bookingStatus != null &&
                              state.booking!.bookingStatus !=
                                  BookingStatus.Cancelled &&
                              state.booking!.bookingStatus !=
                                  BookingStatus.Completed))
                            buildStepper(),
                          if (state.booking!.bookingStatus ==
                              BookingStatus.Cancelled)
                            _buildCancelledAlert(),
                          BookingCard(
                            isCompleted: state.booking?.bookingDate
                                    ?.isBefore(system.now) ??
                                false,
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

  Widget buildStepper() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                height: 40.h,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                width: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: AppColors.GRADIENT_COLOR),
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: AppColors.BORDER_COLOR,
              )),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.BORDER_COLOR),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              CustomText(
                text: 'upcoming',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: 'completed',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Container _buildUpComingActionButton() {
    return Container(
      // top elevation
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        // elevation in top
        BoxShadow(
            color: const Color(0xff9DB2D6).withOpacity(.13),
            offset: const Offset(0, -3),
            blurRadius: 8,
            spreadRadius: 1)
      ]),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(children: [
        Expanded(
          child: DefaultButton(
            borderColor: AppColors.ERROR_COLOR,
            textColor: AppColors.ERROR_COLOR,
            color: Colors.white,
            label: AppText.cancel,
            onPressed: () {},
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: DefaultButton(
            label: AppText.reschedule,
            onPressed: () {},
          ),
        ),
      ]),
    );
  }

  Widget? _buildCompletedActionButton() {
    return BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
      builder: (context, state) {
        if (!state.isSuccess ||
            state.booking == null ||
            state.booking?.bookingDate == null) {
          return SizedBox.shrink();
        }
        // if (!isCompleted(state.booking!)) {
        //   return const SizedBox.shrink();
        // }
        if (state.booking!.bookingStatus != BookingStatus.Completed) {
          return const SizedBox.shrink();
        }
        if (state.booking!.review != null) {
          return const SizedBox.shrink();
        }
        return Container(
          // top elevation
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            // elevation in top
            BoxShadow(
                color: const Color(0xff9DB2D6).withOpacity(.13),
                offset: const Offset(0, -3),
                blurRadius: 8,
                spreadRadius: 1)
          ]),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Row(children: [
            Expanded(
              child: DefaultButton(
                label: AppText.add_review,
                onPressed: () async {
                  if (context.read<BookingDetailsCubit>().state.booking !=
                      null) {
                    Navigator.of(context)
                        .pushNamed(
                      AddReviewScreen.routeName,
                      arguments:
                          context.read<BookingDetailsCubit>().state.booking,
                    )
                        .then((value) {
                      if (value != null && value is ReviewTipsCubitState) {
                        if (value.isLoaded && value.tipsSuccess == false) {
                          showSnackBar(context,
                              message: AppText.review_added_successfully);
                        }
                        if (value.isLoaded && value.tipsSuccess == true) {
                          showSnackBar(context,
                              message: AppText.tip_added_successfully);
                        }
                      }
                    });
                  }
                },
              ),
            ),
          ]),
        );
      },
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
                text: AppText.your_booking_has_been_cancelled,
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
