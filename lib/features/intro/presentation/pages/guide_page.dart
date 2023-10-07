import '../../data/models/guide_page_tab_model.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_helper/size_helper.dart';
import 'package:collection/collection.dart';
import '../../../../core/utils/navigator_helper.dart';

import '../../../../di/injector.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/dots_indicator.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../blocs/guide_page_cubit/guide_page_cubit.dart';
import 'get_started_page.dart';

class GuidePage extends StatefulWidget {
  static const routeName = '/GuidePage';

  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9999999);
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
      child: Scaffold(
        backgroundColor: AppColors.ACCENT_COLOR,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: BlocConsumer<GuidePageCubit, GuidePageState>(
            listener: (context, state) {
              if (state.isError)
                showSnackBar(context, message: state.errorMessage);
            },
            builder: (context, state) {
              if (state.isInitial || state.isLoading)
                return const CustomLoading();

              return _buildGuidePage(context, tabs: state.guidePageTabs);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGuidePage(
    BuildContext context, {
    required List<GuidePageTabModel> tabs,
  }) {
    final cubit = context.read<GuidePageCubit>();

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (tabNumber) => cubit.updateTabNumber(tabNumber),
            children: tabs
                .mapIndexed((index, tab) => _buildTab(
                      context,
                      tab: tab,
                    ))
                .toList(),
            allowImplicitScrolling: true,
          ),
        ),
        _buildButtons(
          context,
          isLastTab: tabs.length - 1 == cubit.state.tabNumber,
        ),
      ],
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required GuidePageTabModel tab,
  }) {
    return Column(
      children: [
        Image.asset(
          tab.image!,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16.0),
        if (tab.title?.isNotEmpty == true)
          TitleText(
            text: '${tab.title}',
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            textAlign: TextAlign.center,
            subtractedSize: -3,
            color: Colors.white,
          ),
        const SizedBox(height: 16.0),
        if (tab.description?.isNotEmpty == true)
          SubtitleText(
            text: '${tab.description}',
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, {required bool isLastTab}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDotsIndicator(context),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: AppColors.PRIMARY_COLOR,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSkipButton(context, isLastTab),
              const SizedBox(width: 24.0),
              _buildNextButton(context, isLastTab),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator(BuildContext context) {
    final cubit = context.read<GuidePageCubit>();

    return BlocSelector<GuidePageCubit, GuidePageState, int>(
      selector: (state) => state.tabNumber,
      builder: (context, currentTabIndex) => DotsIndicator(
        indicatorCount: cubit.state.guidePageTabs.length,
        pageNumber: currentTabIndex,
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, bool isLastTab) {
    final cubit = context.read<GuidePageCubit>();

    var headline12 = Theme.of(context).textTheme.headline1;
    return DefaultButton(
      label: isLastTab ? 'login'.tr() : 'next'.tr(),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: isLastTab ? 16.0 : 32.0, vertical: 16.0),
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      borderColor: Colors.white,
      icon: const Icon(Icons.arrow_forward, size: 24.0),
      iconLocation: DefaultButtonIconLocation.End,
      labelStyle: context.sizeHelper(
        mobileLarge: headline12,
        tabletNormal: Theme.of(context).textTheme.headline1,
        desktopSmall: Theme.of(context).textTheme.headline2,
      ),
      isExpanded: true,
      onPressed: () {
        if (!isLastTab) {
          _pageController.animateToPage(
            cubit.state.tabNumber + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else
          return cubit.setFirstLaunchToFalse(
              onDone: _goToGetStartPage(context, true));
      },
    );
  }

  Widget _buildSkipButton(BuildContext context, bool isLastTab) {
    final cubit = context.read<GuidePageCubit>();

    var headline12 = Theme.of(context).textTheme.headline1;
    return DefaultButton(
      label: isLastTab ? 'sign_up'.tr() : 'skip'.tr(),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: isLastTab ? 16.0 : 32.0, vertical: 16.0),
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      borderColor: Colors.white,
      labelStyle: context.sizeHelper(
        mobileLarge: headline12,
        tabletNormal: Theme.of(context).textTheme.headline1,
        desktopSmall: Theme.of(context).textTheme.headline2,
      ),
      isExpanded: true,
      onPressed: () => cubit.setFirstLaunchToFalse(
          onDone: _goToGetStartPage(context, false)),
    );
  }

  VoidCallback _goToGetStartPage(BuildContext context, bool isLogin) =>
      () => NavigatorHelper.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) {
            return GetStartedPage(isLogin: isLogin);
          }), (route) => false);
}
