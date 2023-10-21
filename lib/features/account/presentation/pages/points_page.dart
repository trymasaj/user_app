import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../data/models/points_model.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/stateless/title_text.dart';
import '../blocs/points_cubit/points_cubit.dart';

class PointsPage extends StatefulWidget {
  static const routeName = '/PointsPage';
  const PointsPage({
    super.key,
  });

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().pointsCubit..loadPoints(),
      child: CustomAppPage(
        safeTop: true,
        safeBottom: false,
        withBackground: true,
        backgroundPath: 'lib/res/assets/points_background.svg',
        backgroundAlignment: Alignment.topCenter,
        backgroundFit: BoxFit.fitWidth,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildAppBar(context),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const TitleText(text: 'my_points'),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 40.0,
        ),
        onPressed: NavigatorHelper.of(context).pop,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) {
        final pointsCubit = context.read<PointsCubit>();
        if (state.isInitial || state.isLoading)
          return const CustomLoading(
            loadingStyle: LoadingStyle.ShimmerList,
          );
        var data = state.pointModel;
        var pointsList = data?.points;
        var currentPoints = data?.current;
        var totalPoints = data?.total;
        if (pointsList?.isNotEmpty == true)
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._buildTopSection(
                    currentPoints: currentPoints, totalPoints: totalPoints),
                Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: pointsCubit.loadMorePoints,
                    isLoading: state.isLoadingMore,
                    child: RefreshIndicator(
                      onRefresh: pointsCubit.refresh,
                      color: AppColors.ACCENT_COLOR,
                      child: ListView.separated(
                        itemCount: pointsList!.length + 1,
                        separatorBuilder: (context, index) => const Divider(
                          color: AppColors.GREY_DARK_COLOR,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == pointsList.length)
                            return _buildPaginationLoading();
                          final item = pointsList[index];
                          return _buildPointsItem(item);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        else
          return const EmptyPageMessage(
            message: 'you_have_no_points_yet',
            svgImage: 'no_points',
          );
      },
    );
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<PointsCubit>().state.isLoadingMore
            ? const CustomLoading(loadingStyle: LoadingStyle.Pagination)
            : const SizedBox(),
      ),
    );
  }

  List<Widget> _buildTopSection({num? currentPoints, num? totalPoints}) {
    return [
      const SubtitleText(
        text: 'current_points',
        color: AppColors.GREY_NORMAL_COLOR,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24.0),
      _buildCurrentPoints(currentPoints),
      const SizedBox(height: 12.0),
      _buildTotalPoints(totalPoints),
      const SizedBox(height: 36.0),
      const TitleText(
        text: 'summary',
        textAlign: TextAlign.start,
      ),
      const SizedBox(height: 16.0),
    ];
  }

  Widget _buildCurrentPoints(num? currentPoints) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40.0),
      decoration: BoxDecoration(
        color: AppColors.THIRD_COLOR,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: TitleText.extraLarge(
        text: 'points'.plural(currentPoints ?? 0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTotalPoints(num? totalPoints) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 48.0),
      decoration: BoxDecoration(
        color: AppColors.THIRD_COLOR.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: TitleText.medium(
        text: '${'total_earned'.tr()} : ${'points'.plural(totalPoints ?? 0)}',
        textAlign: TextAlign.center,
        color: AppColors.THIRD_COLOR,
      ),
    );
  }

  Widget _buildPointsItem(PointItem item) {
    var local = EasyLocalization.of(context)!.currentLocale.toString();

    final dateFormat = DateFormat(' MMM dd,yy  hh:mm a', local);
    var isEarned = item.isEarned ?? true;
    var text = isEarned ? 'earned'.tr() : 'deducted'.tr();
    return Row(
      children: [
        SvgPicture.asset(
          isEarned
              ? 'lib/res/assets/points_add.svg'
              : 'lib/res/assets/points-deduct.svg',
          width: 40.0,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText.medium(
                  text: '$text ${'points'.plural(item.points ?? 0)}'),
              SubtitleText.medium(
                text: item.title ?? '',
                color: AppColors.GREY_NORMAL_COLOR,
              ),
            ],
          ),
        ),
        SubtitleText.small(
          text: dateFormat.format(item.date!),
          color: AppColors.GREY_NORMAL_COLOR,
        )
      ],
    );
  }
}
