import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masaj/core/domain/enums/focus_area_enum.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';

import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';

class FocusAreaPage extends StatefulWidget {
  static const routeName = '/FocusArea';
  final Map<FocusAreas, bool>? selectedFocusPoints;

  const FocusAreaPage({
    super.key,
    this.selectedFocusPoints,
  });

  @override
  State<FocusAreaPage> createState() => _FocusAreaPageState();
}

class _FocusAreaPageState extends State<FocusAreaPage>
    with TickerProviderStateMixin {
  late final Map<FocusAreas, bool> selectedFocusPoints;
  late final TabController _tabController;
  BodySideEnum selectedBodySide = BodySideEnum.Front;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    selectedFocusPoints = {
      for (var e in FocusAreas.values) e: false,
    };
    if (widget.selectedFocusPoints != null) {
      selectedFocusPoints.addAll(widget.selectedFocusPoints!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      child: Scaffold(
        body: Column(children: [
          CustomAppBar(
            title: 'focus_area'.tr(),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    selectedFocusPoints.forEach((key, value) {
                      selectedFocusPoints[key] = false;
                    });
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.black,
                  ))
            ],
          ),
          _buildTabBar(context),
          _buildBody(),
          DefaultButton(
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            onPressed: () {
              final selectedFocusPoints = this.selectedFocusPoints;
              selectedFocusPoints.length;
              // NavigatorHelper.of(context).pop(selectedFocusPoints);
            },
            label: 'Save',
          )
        ]),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
        labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
        controller: _tabController,
        isScrollable: false,
        onTap: (value) {
          setState(() {
            selectedBodySide = BodySideEnum.values[value];
          });
        },
        indicatorColor: Colors.transparent,
        labelColor: Colors.black,
        // unselectedLabelColor: Colors.grey,
        tabs: [
          DefaultTab(
            isSelected: selectedBodySide == BodySideEnum.Front,
            title: 'front'.tr(),
          ),
          DefaultTab(
            isSelected: selectedBodySide == BodySideEnum.Back,
            title: 'back'.tr(),
          ),
        ]);
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Column(
                children: [
                  selectedBodySide == BodySideEnum.Front
                      ? Image.asset('assets/images/Front.png')
                      : Image.asset('assets/images/Back.png'),
                  SelectableText(selectedBodySide.name),
                ],
              ),
            ),
            ..._buildBodyPostions(context)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBodyPostions(BuildContext context) {
    return selectedBodySide == BodySideEnum.Front
        ? _buildFrontBodyPostions(context)
        : _buildBackBodyPostions(context);
  }

  List<Widget> _buildFrontBodyPostions(BuildContext context) {
    return [
      _buildBodyCheckBox(
        top: 25,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Head,
        context: context,
        value: selectedFocusPoints[FocusAreas.Head] ?? false,
      ),
      _buildBodyCheckBox(
        top: 60,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Neck,
        context: context,
        value: selectedFocusPoints[FocusAreas.Neck] ?? false,
      ),
      _buildBodyCheckBox(
        top: 103,
        start: -90,
        end: 5,
        focusArea: FocusAreas.Shoulders,
        context: context,
        value: selectedFocusPoints[FocusAreas.Shoulders] ?? false,
      ),
      _buildBodyCheckBox(
        top: 100,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Chest,
        context: context,
        value: selectedFocusPoints[FocusAreas.Chest] ?? false,
      ),
      _buildBodyCheckBox(
        top: 170,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Abdomen,
        context: context,
        value: selectedFocusPoints[FocusAreas.Abdomen] ?? false,
      ),
      _buildBodyCheckBox(
        top: 160,
        start: 110,
        focusArea: FocusAreas.Arms,
        context: context,
        value: selectedFocusPoints[FocusAreas.Arms] ?? false,
      ),
      _buildBodyCheckBox(
        top: 280,
        start: 0,
        end: 5,
        context: context,
        focusArea: FocusAreas.Legs,
        value: selectedFocusPoints[FocusAreas.Legs] ?? false,
      ),
      _buildBodyCheckBox(
        top: 460,
        start: 0,
        end: 5,
        context: context,
        focusArea: FocusAreas.Feet,
        value: selectedFocusPoints[FocusAreas.Feet] ?? false,
      ),
    ];
  }

  List<Widget> _buildBackBodyPostions(BuildContext context) {
    return [
      _buildBodyCheckBox(
        top: 90,
        start: 0,
        end: 6,
        focusArea: FocusAreas.UpperBack,
        context: context,
        value: selectedFocusPoints[FocusAreas.UpperBack] ?? false,
      ),
      _buildBodyCheckBox(
        top: 175,
        start: 0,
        end: 6,
        focusArea: FocusAreas.LowerBack,
        context: context,
        value: selectedFocusPoints[FocusAreas.LowerBack] ?? false,
      ),
      _buildBodyCheckBox(
        top: 130,
        start: 0,
        end: 6,
        focusArea: FocusAreas.Spine,
        context: context,
        value: selectedFocusPoints[FocusAreas.Spine] ?? false,
      ),
      _buildBodyCheckBox(
        top: 220,
        start: 0,
        end: 6,
        focusArea: FocusAreas.Hips,
        context: context,
        value: selectedFocusPoints[FocusAreas.Hips] ?? false,
      ),
      _buildBodyCheckBox(
        top: 250,
        start: 0,
        end: 6,
        focusArea: FocusAreas.Buttocks,
        context: context,
        value: selectedFocusPoints[FocusAreas.Buttocks] ?? false,
      ),
      _buildBodyCheckBox(
        top: 290,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Thighs,
        context: context,
        value: selectedFocusPoints[FocusAreas.Thighs] ?? false,
      ),
      _buildBodyCheckBox(
        top: 340,
        start: 0,
        end: 5,
        focusArea: FocusAreas.Calves,
        context: context,
        value: selectedFocusPoints[FocusAreas.Calves] ?? false,
      ),
    ];
  }

  Widget _buildBodyCheckBox({
    required BuildContext context,
    required bool value,
    required FocusAreas focusArea,
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return Positioned.directional(
      key: Key(focusArea.name),
      textDirection: context.locale.countryCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      top: top,
      bottom: bottom,
      start: start,
      end: end,
      child: Column(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              checkColor: Colors.white,
              side: const BorderSide(color: AppColors.PRIMARY_COLOR),
              fillColor: MaterialStatePropertyAll(
                  value ? AppColors.PRIMARY_COLOR : AppColors.BACKGROUND_COLOR),
              value: value,
              shape: const CircleBorder(),
              onChanged: (value) {
                setState(() {
                  if (value != null) selectedFocusPoints[focusArea] = value;
                });
              },
            ),
          ),
          CustomText(
            text: focusArea.name,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}