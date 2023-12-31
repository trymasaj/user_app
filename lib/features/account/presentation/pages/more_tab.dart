import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/res/theme/theme_helper.dart';
import 'package:size_helper/size_helper.dart';
import '../../../../core/enums/gender.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../data/models/external_item_model.dart';
import '../blocs/more_tab_cubit/more_tab_cubit.dart';
import 'coupon_page.dart';
import 'ehtemam_page.dart';
import 'favorites_page.dart';
import 'points_page.dart';
import 'settings_page.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/edit_user_info_page.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../res/style/theme.dart';
import '../../../../shared_widgets/other/show_register_first_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';

class MoreTab extends StatelessWidget {
  MoreTab({super.key});

  final _couponKey = GlobalKey();
  final _favoriteKey = GlobalKey();
  final _ehtemamKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().moreTabCubit..init(),
      child: Builder(
        builder: (context) => CustomAppPage(
          safeBottom: false,
          backgroundFit: BoxFit.fitWidth,
          backgroundAlignment: Alignment.topCenter,
          child: BlocListener<MoreTabCubit, MoreTabState>(
            listener: (context, state) {
              if (state.isError)
                showSnackBar(context, message: state.errorMessage);
            },
            child: Scaffold(
              body: _buildBody(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildUpperSection(context),
        _buildExternalSections(context),
        _buildAppInfo(context),
        const SizedBox(height: navbarHeight * 1.2),
      ],
    );
  }

  Widget _buildUpperSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildUpperSectionData(context),
    );
  }

  Widget _buildUpperSectionData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 50.0),
        _buildUserInfo(context),
        _buildDivider(),
        _buildNavigationRow(context),
        _buildEhtemam(context),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isNotGuestUser = authCubit.state.user?.accessToken != null;
    return InkWell(
      child: Row(
        children: [
          SizedBox(
              width: context.sizeHelper(
                  mobileExtraLarge: 110, tabletExtraLarge: 140),
              child: _buildUserImageSection(context)),
          Expanded(child: _buildUserNameSection(context, isNotGuestUser)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => _goToEditAccountOrLoginPage(context, isNotGuestUser),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      endIndent: 8.0,
      indent: 8.0,
      color: Colors.white,
      height: 32.0,
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isNotGuestUser = authCubit.state.user?.accessToken != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRowItem(
          label: 'my_tickets',
          icon: 'my_tickets_icon',
          onPress: isNotGuestUser
              ? () => null
              : () {
                  showRegisterFirstSnackbar(context);
                },
        ),
        _buildRowItem(
          label: 'coupon',
          icon: 'coupon_icon',
          onPress: isNotGuestUser
              ? () => _goToCouponPage(context)
              : () {
                  showRegisterFirstSnackbar(context);
                },
        ),
        _buildRowItem(
          label: 'settings',
          icon: 'settings_icon',
          onPress: () => _goToSettingsPage(context),
        ),
        _buildRowItem(
          label: 'favorites',
          icon: 'fav_icon',
          onPress: isNotGuestUser
              ? () => _goToFavoritesPage(context)
              : () {
                  showRegisterFirstSnackbar(context);
                },
        ),
      ],
    );
  }

  Widget _buildEhtemam(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24.0),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.ACCENT_COLOR,
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: SvgPicture.asset(
                'lib/res/assets/support_icon.svg',
              ),
            ),
            const SubtitleText(
              text: 'ehtemam_center',
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
            )
          ],
        ),
      ),
      onTap: () => _goToEhtemamPage(context),
    );
  }

  Widget _buildRowItem(
      {required String label,
      required String icon,
      required Function() onPress}) {
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SvgPicture.asset(
              'lib/res/assets/$icon.svg',
              height: 36.0,
            ),
          ),
          SubtitleText(text: label),
        ],
      ),
      onTap: onPress,
    );
  }

  Future<void> _goToSettingsPage(BuildContext context) async =>
      await NavigatorHelper.of(context).pushNamed(SettingsPage.routeName);

  Future<void> _goToFavoritesPage(BuildContext context) async =>
      await NavigatorHelper.of(context).pushNamed(FavoritesPage.routeName);

  Future<void> _goToCouponPage(BuildContext context) async =>
      await NavigatorHelper.of(context).pushNamed(CouponPage.routeName);

  Future<void> _goToPointsPage(BuildContext context) async =>
      await NavigatorHelper.of(context).pushNamed(PointsPage.routeName);

  Future<void> _goToEhtemamPage(BuildContext context) async =>
      await NavigatorHelper.of(context).pushNamed(EhtemamPage.routeName);

  Future<void> _goToEditAccountOrLoginPage(
      BuildContext context, bool isNotGuestUser) {
    if (isNotGuestUser)
      return NavigatorHelper.of(context).pushNamed(EditUserInfoPage.routeName);
    else
      return NavigatorHelper.of(context).pushNamed(LoginPage.routeName);
  }

  Widget _buildUserImageSection(BuildContext context) {
    return InkWell(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildUserAvatar(),
          _buildUserPoints(),
        ],
      ),
      onTap: () => _goToPointsPage(context),
    );
  }

  Widget _buildUserPoints() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              color: AppColors.PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'lib/res/assets/points_icon.svg',
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Flexible(
                  child: SubtitleText.small(
                    key: ValueKey(
                        '${EasyLocalization.of(context)!.currentLocale}${state.user?.points}'),
                    text: 'points'.plural(state.user?.points ?? 0),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserAvatar() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isMale = state.user?.gender == Gender.Male;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 46.0,
            child: CircleAvatar(
              backgroundColor: AppColors.THIRD_COLOR,
              radius: 42.0,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(isMale
                    ? 'lib/res/assets/profile_male.webp'
                    : 'lib/res/assets/profile_female.webp'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserNameSection(BuildContext context, bool isNotGuestUser) {
    if (isNotGuestUser) {
      final authCubit = context.read<AuthCubit>();
      final user = authCubit.state.user;
      final userName = user?.fullName;
      final userEmail = user?.email;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText.medium(text: userName ?? ''),
          const SizedBox(height: 8.0),
          SubtitleText.small(text: userEmail ?? ''),
        ],
      );
    } else
      return TitleText.medium(text: 'guest');
  }

  Widget _buildExternalSections(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final height = screenWidth * 0.35;
    return BlocBuilder<MoreTabCubit, MoreTabState>(
      builder: (context, state) {
        if (state.isInitial || state.isLoading) return const SizedBox();
        if (state.externalSection?.isNotEmpty == true)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleText(
                text: 'external_section',
                margin: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.externalSection!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return _buildExternalSectionItemCard(context,
                      item: state.externalSection![index], height: height);
                },
              ),
            ],
          );
        else
          return const SizedBox();
      },
    );
  }

  Widget _buildExternalSectionItemCard(BuildContext context,
      {required ExternalItemModel item, required double height}) {
    final moreCubit = context.read<MoreTabCubit>();
    return InkWell(
      child: Container(
        height: height,
        margin: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: CustomCachedNetworkImage(
                  imageUrl: item.picture,
                  fit: BoxFit.cover,
                  height: height,
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12.0)),
                )),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleText.small(
                      text: item.name,
                      color: Colors.black,
                    ),
                    if (item.description?.isNotEmpty == true)
                      Expanded(
                        child: Html(
                          data: item.description,
                          style: {
                            "body": Style(
                              color: AppColors.ACCENT_COLOR,
                            ),
                          },
                        ),
                      )
                    else
                      const Spacer(),
                    Row(
                      children: [
                        SubtitleText(
                          text: 'more',
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.PRIMARY_COLOR,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        moreCubit.openWebsite(item.url ?? '');
      },
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    return BlocBuilder<MoreTabCubit, MoreTabState>(
      builder: (context, state) {
        return SubtitleText(
          text: state.appInfo ?? '',
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
