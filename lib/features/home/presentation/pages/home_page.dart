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
            safeBottom: false,
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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      child: SizedBox(
        height: navbarHeight,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'lib/res/assets/home_icon.svg',
                color: AppColors.GREY_NORMAL_COLOR,
              ),
              activeIcon: SvgPicture.asset(
                'lib/res/assets/home_icon.svg',
                color: AppColors.PRIMARY_COLOR,
              ),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'lib/res/assets/zones_icon.svg',
                color: AppColors.GREY_NORMAL_COLOR,
              ),
              activeIcon: SvgPicture.asset(
                'lib/res/assets/zones_icon.svg',
                color: AppColors.PRIMARY_COLOR,
              ),
              label: 'zones'.tr(),
            ),
            BottomNavigationBarItem(
              label: '.',
              icon: Material(
                color: Colors.transparent,
                child: AspectRatio(
                    aspectRatio: context.sizeHelper(
                      tabletExtraLarge: 5 / 2.2,
                      desktopSmall: 5 / 1.4,
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: AppColors.PRIMARY_COLOR,
                          size: context.sizeHelper(
                            mobileExtraLarge: 40.0,
                            tabletLarge: 50.0,
                            desktopSmall: 60.0,
                          ),
                        ))),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'lib/res/assets/calendar_icon.svg',
                color: AppColors.GREY_NORMAL_COLOR,
              ),
              activeIcon: SvgPicture.asset(
                'lib/res/assets/calendar_icon.svg',
                color: AppColors.PRIMARY_COLOR,
              ),
              label: 'events'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'lib/res/assets/more_icon.svg',
                color: AppColors.GREY_NORMAL_COLOR,
              ),
              activeIcon: SvgPicture.asset(
                'lib/res/assets/more_icon.svg',
                color: AppColors.PRIMARY_COLOR,
              ),
              label: 'more'.tr(),
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: AppColors.PRIMARY_COLOR,
          unselectedItemColor: AppColors.GREY_NORMAL_COLOR,
          onTap: (index) {
            if (index == 2) {}
            widget._pageController.jumpToPage(index < 2 ? index : index - 1);
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
