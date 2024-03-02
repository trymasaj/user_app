import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/pages/providers_tab.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/presentation/screens/services_screen.dart';
import 'package:masaj/features/settings_tab/pages/setting_tab_page.dart';
import 'package:masaj/gen/assets.gen.dart';

import 'package:masaj/features/bookings_tab/presentation/pages/bookings_tab.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';

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
    final isGuest = context.read<AuthCubit>().state.isGuest;
    final countryCubit = context.read<CountryCubit>();
    countryCubit.init(isGuest);

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
        // BlocProvider(create: (context) => Injector().homeCubit..loadHome()),
        BlocProvider(create: (context) => Injector().homeCubit),
        BlocProvider<ServiceCategoryCubit>(
            create: (context) =>
                Injector().serviceCategoryCubit..getServiceCategories()),

        // BlocProvider(create: (context) => Injector().zonesCubit..init()),
        // BlocProvider(create: (context) => Injector().eventsCubit..init()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.isLoggedIn != current.isLoggedIn,
        listener: (context, state) {
          if (!state.isLoggedIn) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/LoginPage', (route) => false);
          }
        },
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
                    const HomeTab(),
                    const BookingsTab(),
                    const ProvidersTab(),
                    SettingsTabPage.builder(context),
                  ],
                ),
                bottomNavigationBar: _CustomNavBar(
                  pageController: _pageController,
                ),
              ),
            )),
      ),
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
                  Assets.images.home,
                  height: 24,
                  width: 24,
                  color: AppColors.GREY_NORMAL_COLOR,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.images.home,
                  color: AppColors.FONT_COLOR,
                  height: 24,
                  width: 24,
                ),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.bookmark,
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.images.bookmark,
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
                  Assets.images.fluentPeopleCommunity20Regular,
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.images.fluentPeopleCommunity20Regular,
                  height: 24,
                  width: 24,
                ),
                label: 'providers'.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.setting,
                  color: AppColors.GREY_NORMAL_COLOR,
                  height: 24,
                  width: 24,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.images.setting,
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
                final allServiceCategories = context
                    .read<ServiceCategoryCubit>()
                    .state
                    .serviceCategories;
                final selectedServiceCategory = allServiceCategories.isNotEmpty
                    ? allServiceCategories.first
                    : null;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ServicesScreen(
                            screenArguments: ServicesScreenArguments(
                                selectedServiceCategory:
                                    selectedServiceCategory,
                                allServiceCategories: allServiceCategories))));
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
