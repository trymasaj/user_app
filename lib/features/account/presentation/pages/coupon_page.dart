import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:masaj/features/account/presentation/pages/coupon_details_page.dart';
import 'package:size_helper/size_helper.dart';
import '../../../../core/data/models/coupon_model.dart';
import '../blocs/coupon_cubit/coupon_cubit.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/stateless/title_text.dart';

class CouponPage extends StatefulWidget {
  static const routeName = '/CouponPage';
  const CouponPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late final PageController _pageController;

  final _allCouponsKey = GlobalKey();
  final _redeemedCouponsKey = GlobalKey();

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, viewportFraction: 0.999999999);
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
      create: (context) => Injector().couponCubit..init(),
      child: Builder(
        builder: (context) {
          return BlocListener<CouponCubit, CouponState>(
            listener: (context, state) async {
              if (state.isError)
                return showSnackBar(context,
                    message: state.errorMessage.toString());

              if (state.isRedeemSuccess) {
                final authCubit = context.read<AuthCubit>();
                final couponCubit = context.read<CouponCubit>();
                await couponCubit.refreshAllCoupons();
                await couponCubit.refreshRedeemedCoupons();
                await authCubit.updateUserPoints(
                    state.redeemCouponResult?.currentPoints ?? 0);
              }
            },
            child: CustomAppPage(
              safeTop: true,
              safeBottom: false,
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildAppBar(context),
                    _buildTabs(context),
                    Expanded(child: _buildBody(context)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const TitleText(text: 'coupons'),
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
    return PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildAllCoupons(),
          _buildRedeemedCoupons(),
        ]);
  }

  Widget _buildAllCoupons() {
    return BlocBuilder<CouponCubit, CouponState>(
      buildWhen: (previous, current) =>
          previous.allCoupons != current.allCoupons,
      builder: (context, state) {
        final couponsCubit = context.read<CouponCubit>();
        final childAspectRatio = context.sizeHelper(
          tabletLarge: 0.65,
          desktopSmall: 0.75,
        );
        final count = context.sizeHelper(
          tabletLarge: 2,
          desktopSmall: 3,
        );
        if (state.isInitial || state.isLoading)
          return const CustomLoading(
            loadingStyle: LoadingStyle.ShimmerGrid,
          );
        if (state.allCoupons?.data.isNotEmpty == true)
          return Column(
            children: [
              Expanded(
                child: LazyLoadScrollView(
                  onEndOfPage: couponsCubit.loadMoreAllCoupons,
                  isLoading: couponsCubit.state.isLoadingMore,
                  child: RefreshIndicator(
                    onRefresh: couponsCubit.refreshAllCoupons,
                    color: AppColors.ACCENT_COLOR,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: childAspectRatio,
                        crossAxisCount: count,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: state.allCoupons?.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = state.allCoupons?.data[index];
                        return _CouponItemWidget(
                          item: item!,
                          isRedeemed: false,
                          onPress: () {
                            _showDialogRedeemCodeConfirmation(context, item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildPaginationLoading(),
              const SizedBox(height: 16.0),
            ],
          );
        else
          return const EmptyPageMessage(
            message: 'you_have_no_coupon_yet',
            svgImage: 'no_points',
            heightRatio: 0.8,
          );
      },
    );
  }

  Widget _buildRedeemedCoupons() {
    return BlocBuilder<CouponCubit, CouponState>(
      buildWhen: (previous, current) =>
          previous.redeemedCoupons != current.redeemedCoupons,
      builder: (context, state) {
        final couponsCubit = context.read<CouponCubit>();
        final childAspectRatio =
            context.sizeHelper(mobileExtraLarge: 0.65, desktopSmall: 0.75);
        if (state.isInitial || state.isLoading)
          return const CustomLoading(
            loadingStyle: LoadingStyle.ShimmerGrid,
          );
        if (state.redeemedCoupons?.data.isNotEmpty == true)
          return Column(
            children: [
              Expanded(
                child: LazyLoadScrollView(
                  onEndOfPage: couponsCubit.loadMoreRedeemedCoupons,
                  isLoading: couponsCubit.state.isLoadingMore,
                  child: RefreshIndicator(
                    onRefresh: couponsCubit.refreshRedeemedCoupons,
                    color: AppColors.ACCENT_COLOR,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: childAspectRatio,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: state.redeemedCoupons?.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = state.redeemedCoupons?.data[index];
                        return _CouponItemWidget(
                          item: item!,
                          isRedeemed: true,
                          onPress: () {
                            _goToCouponDetailsPage(context, item.id, item.name);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildPaginationLoading(),
              const SizedBox(height: 16.0),
            ],
          );
        else
          return const EmptyPageMessage(
            message: 'you_have_no_coupon_yet',
            svgImage: 'no_points',
            heightRatio: 0.8,
          );
      },
    );
  }

  Future<void> _goToCouponDetailsPage(
          BuildContext context, int id, String label) async =>
      await NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
        return CouponDetailsPage(
          id: id,
          label: label,
        );
      }));

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<CouponCubit>().state.isLoadingMore
            ? const CustomLoading(loadingStyle: LoadingStyle.Pagination)
            : const SizedBox(),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return _ToggleTabs(
      allCouponsKey: _allCouponsKey,
      redeemedCouponsKey: _redeemedCouponsKey,
      onTap: _pageController.jumpToPage,
    );
  }

  Future<void> _showDialogRedeemCodeConfirmation(
      BuildContext context, CouponItem item) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext _) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopDialogSection(),
              _buildBottomDialogSection(context, item),
            ],
          ),
        );
      },
    );
  }

  Container _buildTopDialogSection() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          TitleText(
            text: 'coupon_redeemed_confirmation',
            textAlign: TextAlign.center,
            maxLines: 2,
            margin: EdgeInsets.all(16),
          ),
        ],
      ),
    );
  }

  Container _buildBottomDialogSection(BuildContext context, CouponItem item) {
    final couponsCubit = context.read<CouponCubit>();
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultButton(
            label: 'yes'.tr(),
            isExpanded: true,
            onPressed: () => couponsCubit.redeemCoupon(item.id).whenComplete(
              () {
                NavigatorHelper.of(context).pop();
                if (couponsCubit.state.redeemCouponResult?.success == true) {
                  showSnackBar(
                    context,
                    message: "success_coupon_redeemed".tr(),
                  );
                  return;
                }
                showSnackBar(context, message: "error_coupon_redeemed".tr());
              },
            ),
          ),
          const SizedBox(height: 16.0),
          DefaultButton(
              label: 'close'.tr(),
              backgroundColor: Colors.transparent,
              borderColor: AppColors.PRIMARY_COLOR,
              labelStyle: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.PRIMARY_COLOR,
                  fontWeight: FontWeight.bold),
              isExpanded: true,
              onPressed: NavigatorHelper.of(context).pop),
        ],
      ),
    );
  }
}

class _CouponItemWidget extends StatelessWidget {
  const _CouponItemWidget({
    required this.onPress,
    required this.isRedeemed,
    super.key,
    required this.item,
  });

  final CouponItem item;
  final bool isRedeemed;

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    var local = EasyLocalization.of(context)!.currentLocale.toString();
    final dateFormatWithYear = DateFormat(' MMM dd,yy', local);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 65,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                CustomCachedNetworkImage(
                  imageUrl: item.picture,
                  fit: BoxFit.cover,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                PositionedDirectional(
                    start: 8.0,
                    top: 0.0,
                    child: Chip(
                        backgroundColor: AppColors.PRIMARY_COLOR,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        label: SubtitleText.small(
                          text: 'points'.plural(item.points ?? 0),
                        ))),
              ],
            ),
          ),
          Expanded(
              flex: 35,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.SECONDARY_COLOR,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubtitleText(
                              text: item.name,
                              maxLines: 1,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0)),
                          const Spacer(),
                          DefaultButton(
                            isExpanded: true,
                            label: isRedeemed == false
                                ? 'redeem'.tr()
                                : 'redeemed'.tr(),
                            backgroundColor: isRedeemed == false
                                ? AppColors.PRIMARY_COLOR
                                : Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            onPressed: onPress,
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                      end: 8.0,
                      top: -30.0,
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: 40.0,
                        width: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: SubtitleText.small(
                          text: dateFormatWithYear.format(item.startDate),
                          textAlign: TextAlign.center,
                          color: AppColors.ACCENT_COLOR,
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class _ToggleTabs extends StatefulWidget {
  const _ToggleTabs({
    Key? key,
    required this.onTap,
    required this.allCouponsKey,
    required this.redeemedCouponsKey,
  }) : super(key: key);

  final GlobalKey allCouponsKey;
  final GlobalKey redeemedCouponsKey;
  final ValueChanged<int> onTap;

  @override
  State<_ToggleTabs> createState() => __ToggleTabsState();
}

class __ToggleTabsState extends State<_ToggleTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        border: Border.all(color: Colors.white),
      ),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildTab(
              context,
              label: "all_coupons".tr(),
              index: 0,
              showCaseKey: widget.allCouponsKey,
              showCaseTitle: 'coupons',
              showCaseDescription: 'click_here_to_redeem_your_points',
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: _buildTab(
              context,
              label: "redeemed_coupons".tr(),
              index: 1,
              showCaseKey: widget.redeemedCouponsKey,
              showCaseTitle: 'coupons',
              showCaseDescription: 'all_past_redeemed_points_are_found_here',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String label,
    required int index,
    required GlobalKey showCaseKey,
    required String showCaseTitle,
    required String showCaseDescription,
  }) {
    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: _selectedTab == index
                ? AppColors.PRIMARY_COLOR
                : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Colors.white,
                fontSize: context.sizeHelper(
                  tabletLarge: 14.0,
                  tabletExtraLarge: 16.0,
                  desktopSmall: 20.0,
                )),
          ),
        ),
        onTap: () {
          setState(() => _selectedTab = index);

          widget.onTap(index);
        });
  }
}
