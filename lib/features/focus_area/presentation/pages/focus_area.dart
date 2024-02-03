import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/focus_area/presentation/cubits/focus_area_cubit.dart';

class FocusArea extends StatefulWidget {
  static const routeName = '/FocusArea';

  const FocusArea({super.key});

  @override
  State<FocusArea> createState() => _FocusAreaState();
}

class _FocusAreaState extends State<FocusArea> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      child: Scaffold(
        body: Column(children: [
          CustomAppBar(
            title: 'Focus Area',
            centerTitle: true,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.replay))],
          ),
          _buildTabBar(context),
          _buildBody(),
          DefaultButton(
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            onPressed: () {},
            label: 'Save',
          )
        ]),
      ),
    );
  }

  Widget _buildBody() {
    return BlocSelector<FocusAreaCubit, FocusAreaState, FocusAreaStateType>(
      selector: (state) {
        return state.type ?? FocusAreaStateType.Back;
      },
      builder: (context, state) {
        return Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Column(children: [
                state == FocusAreaStateType.Back
                    ? Image.asset('assets/images/Back.png')
                    : Image.asset('assets/images/Front.png'),
                SelectableText(state.name)
              ]))
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final cubit = context.read<FocusAreaCubit>();
    return BlocBuilder<FocusAreaCubit, FocusAreaState>(
      builder: (context, state) {
        return TabBar(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
            labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
            controller: TabController(length: 2, vsync: this, initialIndex: 0),
            isScrollable: false,
            onTap: (value) {
              log(value.toString());
              cubit.changeBody(FocusAreaStateType.values[value]);
            },
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            // unselectedLabelColor: Colors.grey,
            tabs: [
              DefaultTab(
                isSelected: state.type == FocusAreaStateType.values[0],
                title: FocusAreaStateType.values[0].name,
              ),
              DefaultTab(
                isSelected: state.type == FocusAreaStateType.values[1],
                title: FocusAreaStateType.values[1].name,
              ),
            ]);
      },
    );
  }
}

class DefaultTab extends StatelessWidget {
  const DefaultTab({
    super.key,
    required this.isSelected,
    required this.title,
  });
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
        height: 40.h,
        iconMargin: EdgeInsets.zero,
        child: Container(
          height: 40.h,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? null : AppColors.ExtraLight,
            gradient: isSelected ? AppColors.GRADIENT_Fill_COLOR : null,
            border: isSelected
                ? GradientBoxBorder(
                    gradient: AppColors.GRADIENT_COLOR,
                    width: 1,
                  )
                : Border.all(color: const Color(0xffD9D9D9), width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: isSelected
              ? TextWithGradiant(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )
              : CustomText(
                  text: title,
                  fontSize: 14,
                  //rgba(24, 27, 40, 0.4)
                  color: const Color.fromARGB(255, 24, 27, 40).withOpacity(.4),
                  fontWeight: FontWeight.w700,
                ),
        ));
  }
}
