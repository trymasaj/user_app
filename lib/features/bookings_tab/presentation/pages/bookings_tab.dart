import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/bookings_tab_cubit/bookings_tab_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/booking_card.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  static const routeName = '/BookingsTabPage';

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  late BookingsTabCubit cubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    cubit = DI.find<BookingsTabCubit>();
    cubit.loadServices();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        cubit.loadMoreServices();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingsTabCubit>(
      create: (c) => cubit,
      child: CustomAppPage(
        child: Scaffold(
          appBar: CustomAppBar(
            title: AppText.bookings,
          ),
          body: BlocBuilder<BookingsTabCubit, BookingsTabState>(
            builder: (context, state) {
              return DefaultTabController(
                initialIndex: state.type.index,
                length: BookingQueryStatus.values.length,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24, bottom: 0),
                      child: TabBar(
                          labelPadding: const EdgeInsets.all(5),
                          isScrollable: false,
                          onTap: (value) {
                            cubit.changeType(BookingQueryStatus.values[value]);
                          },
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.black,
                          // unselectedLabelColor: Colors.grey,
                          tabs: [
                            ...List.generate(BookingQueryStatus.values.length,
                                (index) => _buildTap(state, index)),
                          ]),
                    ),
                    if (state.isLoading)
                      const Expanded(
                        child: CustomLoading(
                          loadingStyle: LoadingStyle.ShimmerList,
                        ),
                      )
                    else if (state.sessions.isEmpty)
                      Expanded(
                        child: EmptyPageMessage(
                          heightRatio: 0.65,
                          onRefresh: () async {
                            cubit.loadServices(
                              refresh: true,
                            );
                          },
                          svgImage: 'empty',
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.isLoadingMore
                                ? state.sessions.length + 1
                                : state.sessions.length,
                            itemBuilder: (context, index) {
                              if (index == state.sessions.length) {
                                return const CustomLoading();
                              }
                              return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: BookingCard(
                                      showTherapist: true,
                                      isCompleted: state.type ==
                                          BookingQueryStatus.completed,
                                      sessionModel: state.sessions[index]));
                            }),
                      )
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Tab _buildTap(BookingsTabState state, int index) {
    return Tab(
        height: 40.h,

        // height: 40,
        child: Container(
          width: 160.w,
          height: 40.h,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: state.type == BookingQueryStatus.values[index]
                ? null
                : AppColors.ExtraLight,
            gradient: state.type == BookingQueryStatus.values[index]
                ? AppColors.GRADIENT_Fill_COLOR
                : null,
            border: state.type == BookingQueryStatus.values[index]
                ? GradientBoxBorder(
                    gradient: AppColors.GRADIENT_COLOR,
                    width: 1,
                  )
                : Border.all(color: const Color(0xffD9D9D9), width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: state.type == BookingQueryStatus.values[index]
              ? TextWithGradiant(
                  text: BookingQueryStatus.values[index].name,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )
              : CustomText(
                  text: BookingQueryStatus.values[index].name,
                  fontSize: 14,
                  //rgba(24, 27, 40, 0.4)
                  color: const Color.fromARGB(255, 24, 27, 40).withOpacity(.4),
                  // color: const Color(0xff181b2866)
                  //     .withOpacity(.4),
                  fontWeight: FontWeight.w700,
                ),
        ));
  }
}
