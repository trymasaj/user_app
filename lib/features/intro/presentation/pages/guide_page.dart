import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/dots_indicator.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/intro/presentation/blocs/guide_page_cubit/guide_page_cubit.dart';

import 'package:masaj/features/intro/data/models/guide_page_tab_model.dart';

class GuidePage extends StatefulWidget {
  static const routeName = '/GuidePage';

  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().guidePageCubit..loadGuidePage(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.ACCENT_COLOR,
          body: _buildBody(context),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<GuidePageCubit, GuidePageState>(
          listener: (context, state) {
            if (state.isError) {
              showSnackBar(context, message: state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state.isInitial || state.isLoading) {
              return const CustomLoading();
            }

            return _buildGuidePage(context, tabs: state.guidePageTabs);
          },
        ),
        Positioned(
          bottom: 50.0,
          right: 24.0,
          child: _buildGlassContainer(
            context,
          ),
        ),
        Positioned(
          top: 50.0,
          right: 24.0,
          child: _buildSkipButton(context),
        ),
      ],
    );
  }

  Widget _buildGuidePage(
    BuildContext context, {
    required List<GuidePageTabModel> tabs,
  }) {
    final cubit = context.read<GuidePageCubit>();

    return PageView(
      controller: _pageController,
      allowImplicitScrolling: true,
      onPageChanged: (tabNumber) => cubit.updateTabNumber(tabNumber),
      children: tabs
          .mapIndexed((index, tab) => _buildTab(
                context,
                tab: tab,
              ))
          .toList(),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required GuidePageTabModel tab,
  }) {
    return Stack(
      children: [
        Image.asset(
          tab.image!,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildDotsIndicator(BuildContext context) {
    final cubit = context.read<GuidePageCubit>();

    return BlocSelector<GuidePageCubit, GuidePageState, int>(
      selector: (state) => state.tabNumber,
      builder: (context, currentTabIndex) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DotsIndicator(
          mainAxisAlignment: MainAxisAlignment.center,
          indicatorCount: cubit.state.guidePageTabs.length,
          pageNumber: currentTabIndex,
          spaceBetween: 4.0,
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, bool isLastTab) {
    final cubit = context.read<GuidePageCubit>();

    return GestureDetector(
      onTap: () {
        if (!isLastTab) {
          _pageController.jumpToPage(
            cubit.state.tabNumber + 1,
          );
          return;
        }
        cubit.setFirstLaunchToFalse(onDone: _goToGetStartPage(context, true));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: isLastTab ? 'get_started' : 'next',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          context.isAr
              ? const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 16.0,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 16.0,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    final cubit = context.read<GuidePageCubit>();

    return DefaultButton(
      label: 'skip',
      backgroundColor: Colors.transparent,
      color: Colors.transparent,
      onPressed: () {
        cubit.setFirstLaunchToFalse(onDone: _goToGetStartPage(context, false));
      },
    );
  }

  VoidCallback _goToGetStartPage(BuildContext context, bool isLogin) =>
      () => NavigatorHelper.of(context).pushNamedAndRemoveUntil(
            LoginPage.routeName,
            (route) => false,
          );

  Widget _buildGlassContainer(BuildContext context) {
    final cubit = context.watch<GuidePageCubit>();
    final tabs = cubit.state.guidePageTabs;
    final tab = tabs[cubit.state.tabNumber];
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final state = context.read<GuidePageCubit>().state;
    final isLastTab = state.tabNumber == state.guidePageTabs.length - 1;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: width - 48,
          height: 240,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tab.title?.isNotEmpty == true)
                CustomText(
                  text: '${tab.title}',
                  textAlign: TextAlign.center,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              const SizedBox(height: 16.0),
              if (tab.description?.isNotEmpty == true)
                CustomText(
                  text: '${tab.description}',
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16.0),
              _buildDotsIndicator(context),
              const SizedBox(height: 16.0),
              _buildNextButton(context, isLastTab)
            ],
          ),
        ),
      ),
    );
  }
}
