import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/features/providers_tab/presentation/pages/providers_tab.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../res/style/theme.dart';
import '../../../account/presentation/pages/more_tab.dart';
import '../../../bookings_tab/presentation/pages/bookings_tab.dart';
import 'home_tab.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injector.dart';
import '../bloc/home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  const HomePage({
    super.key,
    this.initialPageIndex,
  });

  final int? initialPageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex ?? 0);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Injector().homeCubit..loadHome()),
        // BlocProvider(create: (context) => Injector().zonesCubit..init()),
        // BlocProvider(create: (context) => Injector().eventsCubit..init()),
      ],
      child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.isError) showSnackBar(context, message: state.message);
          },
          child: CustomAppPage(
            safeBottom: true,
            child: Scaffold(
              extendBody: true,
              body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomeTab(),
                  BookingsTab(),
                  ProvidersTab(),
                  MoreTab(),
                ],
              ),
              bottomNavigationBar: _CustomNavBar(
                pageController: _pageController,
              ),
            ),
          )),
    );
  }
}

class _CustomNavBar extends StatefulWidget {
  const _CustomNavBar({
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<_CustomNavBar> createState() => __CustomNavBarState();
}

class __CustomNavBarState extends State<_CustomNavBar> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget._pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: navbarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        //box shadow at top of navbar only
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/res/assets/home_icon.svg',
                  height: 24,
                  width: 24,
                  color: AppColors.GREY_NORMAL_COLOR,
                ),
                activeIcon: SvgPicture.asset(
                  'lib/res/assets/home_icon.svg',
                  color: AppColors.FONT_COLOR,
                  height: 24,
                  width: 24,
                ),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/res/assets/zones_icon.svg',
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'lib/res/assets/zones_icon.svg',
                  color: AppColors.FONT_COLOR,
                  height: 24,
                  width: 24,
                ),
                label: 'bookings'.tr(),
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 20,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/res/assets/calendar_icon.svg',
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'lib/res/assets/calendar_icon.svg',
                  color: AppColors.FONT_COLOR,
                  height: 24,
                  width: 24,
                ),
                label: 'providers'.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/res/assets/more_icon.svg',
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'lib/res/assets/more_icon.svg',
                  height: 24,
                  width: 24,
                  color: AppColors.FONT_COLOR,
                ),
                label: 'settings'.tr(),
              ),
            ],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            selectedItemColor: AppColors.FONT_COLOR,
            unselectedItemColor: AppColors.GREY_NORMAL_COLOR,
            elevation: 0,
            onTap: (index) {
              if (index == 2) {
                //TODO: Add GO TO NEW BOOKING PAGE
                return;
              }
              widget._pageController.jumpToPage(index < 2 ? index : index - 1);
              setState(() {
                currentIndex = index;
              });
            },
          ),
          IgnorePointer(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    gradient: AppColors.GRADIENT_COLOR,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
