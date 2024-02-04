import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masaj/core/domain/enums/focus_area.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';

import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';

import 'package:masaj/features/focus_area/presentation/cubits/focus_area_cubit.dart';

class FocusAreaPage extends StatefulWidget {
  static const routeName = '/FocusArea';

  const FocusAreaPage({super.key});

  @override
  State<FocusAreaPage> createState() => _FocusAreaPageState();
}

class _FocusAreaPageState extends State<FocusAreaPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FocusAreaCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FocusAreaCubit>();
    return CustomAppPage(
      child: Scaffold(
        body: Column(children: [
          CustomAppBar(
            title: 'Focus Area',
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.resetPositions();
                  },
                  icon: const Icon(Icons.replay))
            ],
          ),
          _buildTabBar(context),
          _buildBody(),
          DefaultButton(
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            onPressed: () {
              NavigatorHelper.of(context).pop(cubit.focusPositions);
            },
            label: 'Save',
          )
        ]),
      ),
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
            ])),
            ..._buildBodyPostions(context)
          ],
        ),
      );
    },
  );
}

List<Widget> _buildBodyPostions(BuildContext context) {
  final cubit = context.read<FocusAreaCubit>();
  return cubit.state.type == FocusAreaStateType.Front
      ? _buildFrontBodyPostions(context)
      : _buildBackBodyPostions(context);
}

List<Widget> _buildFrontBodyPostions(BuildContext context) {
  final cubit = context.read<FocusAreaCubit>();
  return [
    _buildBodyCheckBox(
        top: 15.h,
        start: 0,
        end: 5.w,
        focusArea: FocusAreas.Head,
        context: context,
        value: cubit.focusPositions[FocusAreas.Head] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Head);
        }),
    _buildBodyCheckBox(
      top: 60.h,
      start: 0,
      end: 5.w,
      focusArea: FocusAreas.Neck,
      context: context,
      value: cubit.state.positions[FocusAreas.Neck] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Neck);
      },
    ),
    _buildBodyCheckBox(
      top: 75.h,
      start: 130.w,
      focusArea: FocusAreas.Shoulders,
      context: context,
      value: cubit.state.positions[FocusAreas.Shoulders] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Shoulders);
      },
    ),
    _buildBodyCheckBox(
      top: 100.h,
      start: 0,
      end: 5.w,
      focusArea: FocusAreas.Chest,
      context: context,
      value: cubit.state.positions[FocusAreas.Chest] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Chest);
      },
    ),
    _buildBodyCheckBox(
      top: 150.h,
      start: 0,
      end: 5.w,
      focusArea: FocusAreas.Abdomen,
      context: context,
      value: cubit.state.positions[FocusAreas.Abdomen] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Abdomen);
      },
    ),
    _buildBodyCheckBox(
      top: 160.h,
      start: 125.w,
      focusArea: FocusAreas.Arms,
      context: context,
      value: cubit.state.positions[FocusAreas.Arms] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Arms);
      },
    ),
    _buildBodyCheckBox(
      top: 280.h,
      start: 0,
      end: 5.w,
      context: context,
      focusArea: FocusAreas.Legs,
      value: cubit.state.positions[FocusAreas.Legs] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Legs);
      },
    ),
    _buildBodyCheckBox(
      top: 380.h,
      start: 0,
      end: 5.w,
      context: context,
      focusArea: FocusAreas.Feet,
      value: cubit.state.positions[FocusAreas.Feet] ?? false,
      onChanged: (value) {
        cubit.setPosition(value ?? false, FocusAreas.Feet);
      },
    ),
  ];
}

List<Widget> _buildBackBodyPostions(BuildContext context) {
  final cubit = context.read<FocusAreaCubit>();
  return [
    _buildBodyCheckBox(
        top: 60.h,
        start: 0,
        end: 5.w,
        focusArea: FocusAreas.UpperBack,
        context: context,
        value: cubit.state.positions[FocusAreas.UpperBack] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.UpperBack);
        }),
    _buildBodyCheckBox(
        top: 110.h,
        start: 0,
        end: 5.w,
        focusArea: FocusAreas.LowerBack,
        context: context,
        value: cubit.state.positions[FocusAreas.LowerBack] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.LowerBack);
        }),
    _buildBodyCheckBox(
        top: 150.h,
        start: 170.w,
        focusArea: FocusAreas.Spine,
        context: context,
        value: cubit.state.positions[FocusAreas.Spine] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Spine);
        }),
    _buildBodyCheckBox(
        top: 190.h,
        start: 170.w,
        focusArea: FocusAreas.Hips,
        context: context,
        value: cubit.state.positions[FocusAreas.Hips] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Hips);
        }),
    _buildBodyCheckBox(
        top: 220.h,
        start: 150.w,
        focusArea: FocusAreas.Buttocks,
        context: context,
        value: cubit.state.positions[FocusAreas.Buttocks] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Buttocks);
        }),
    _buildBodyCheckBox(
        top: 260.h,
        start: 152.w,
        focusArea: FocusAreas.Thighs,
        context: context,
        value: cubit.state.positions[FocusAreas.Thighs] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Thighs);
        }),
    _buildBodyCheckBox(
        top: 340.h,
        start: 0,
        end: 5.w,
        focusArea: FocusAreas.Calves,
        context: context,
        value: cubit.state.positions[FocusAreas.Calves] ?? false,
        onChanged: (value) {
          cubit.setPosition(value ?? false, FocusAreas.Calves);
        }),
  ];
}

Widget _buildBodyCheckBox({
  required bool value,
  required ValueChanged<bool?> onChanged,
  required BuildContext context,
  double? top,
  double? bottom,
  double? start,
  double? end,
  FocusAreas? focusArea,
}) {
  return Positioned.directional(
    key: focusArea != null ? Key(focusArea.name) : null,
    textDirection: context.locale.countryCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    top: top,
    bottom: bottom,
    start: start,
    end: end,
    child: BlocSelector<FocusAreaCubit, FocusAreaState, bool>(
      selector: (FocusAreaState state) => state.positions[focusArea] ?? false,
      builder: (context, state) {
        return Column(
          children: [
            Checkbox(
              checkColor: Colors.white,
              side: const BorderSide(color: AppColors.PRIMARY_COLOR),
              fillColor: MaterialStatePropertyAll(
                  state ? AppColors.PRIMARY_COLOR : AppColors.BACKGROUND_COLOR),
              value: state,
              shape: const CircleBorder(),
              onChanged: onChanged,
            ),
            SelectableText(
              focusArea?.name ?? '',
              style: TextStyle(fontSize: 11.sp),
            )
          ],
        );
      },
    ),
  );
}
