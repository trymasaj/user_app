import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';

class SelectTherapist extends StatefulWidget {
  const SelectTherapist({super.key, required this.avialbleTherapistCubit});
  final AvialbleTherapistCubit avialbleTherapistCubit;

  static const String routeName = '/select-therapist';

  static Route route({required AvialbleTherapistCubit avialbleTherapistCubit}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => builder(
          avialbleTherapistCubit: avialbleTherapistCubit, context: context),
    );
  }

  static Widget builder(
      {required AvialbleTherapistCubit avialbleTherapistCubit,
      required BuildContext context}) {
    return BlocProvider.value(
        value: avialbleTherapistCubit,
        child: SelectTherapist(
          avialbleTherapistCubit: avialbleTherapistCubit,
        ));
  }

  @override
  State<SelectTherapist> createState() => _SelectTherapistState();
}

class _SelectTherapistState extends State<SelectTherapist> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // widget.avialbleTherapistCubit.loadMoreTherapists();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'msg_select_therapist',
      ),
      body: Container(
        child: BlocBuilder<AvialbleTherapistCubit, AvialbleTherapistState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      CustomText(
                          text: 'msg_available_therapist',
                          color: AppColors.FONT_COLOR,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 14.0),
                    ],
                  ),
                  if (state.isLoading)
                    const Expanded(
                      child: CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      ),
                    )
                  else if (state.availableTherapists.isEmpty)
                    Expanded(
                      child: EmptyPageMessage(
                        heightRatio: 0.65,
                        onRefresh: () async {
                          // await widget.avialbleTherapistCubit.getTherapists(
                          //   refresh: true,
                          // );
                        },
                        svgImage: 'empty',
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.availableTherapists.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: AvailableTherapistWidget(
                                  availableTherapistModel:
                                      state.availableTherapists[index],
                                ));
                          }),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
