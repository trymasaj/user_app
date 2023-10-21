import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'topic_page.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/change_password_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../core/enums/topic_type.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../auth/presentation/pages/login_page.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/SettingsPage';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Locale? startLocal;

  @override
  void didChangeDependencies() {
    startLocal ??= EasyLocalization.of(context)!.currentLocale;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSection(context),
            _buildTitle(),
            Expanded(child: _buildBody(context)),
            _buildLoginOrLogoutButton(context),
            const SizedBox(height: 16.0)
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/res/assets/app_logo.png',
                height: 80.0,
              ),
            ],
          ),
        ),
        PositionedDirectional(
          start: 16.0,
          top: 32.0,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 32.0,
            ),
            color: Colors.white,
            onPressed: () => _backWithOrWithOutRefresh(context),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isNotGuestUser = authCubit.state.user?.accessToken != null;
    return ListView(
      children: [
        _buildSwitchItem(context,
            label: 'notifications', icon: 'notification_icon'),
        _buildNormalItem(
            label: 'change_password',
            onPress: () => _goToChangePasswordPage(context),
            icon: 'change_password_icon',
            isNotGuestUser: isNotGuestUser),
        _buildLanguageItem(context,
            label: 'preferred_language', icon: 'language_icon'),
        _buildNormalItem(
            label: 'privacy_policy',
            onPress: () => _gToTopicsPage(context, TopicType.Privacy),
            icon: 'privacy_icon'),
        _buildNormalItem(
          label: 'start_help_layer',
          onPress: () => authCubit
              .resetShowCaseDisplayedPages()
              .whenComplete(onRestartHelpLayer(context)),
          icon: 'help_layer_icon',
        ),
        _buildNormalItem(
            label: 'delete_this_account',
            onPress: () {
              authCubit.deleteAccount().then((value) => showSnackBar(context,
                  message: 'delete_account_request_sent'));
            },
            icon: 'delete_account_icon',
            isNotGuestUser: isNotGuestUser),
      ],
    );
  }

  Widget _buildLoginOrLogoutButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isNotGuestUser = authCubit.state.user?.accessToken != null;

    return DefaultButton(
        label: isNotGuestUser ? 'logout'.tr() : 'login'.tr(),
        isExpanded: true,
        borderColor: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        backgroundColor: Colors.transparent,
        onPressed: () {
          authCubit.logout();
          NavigatorHelper.of(context)
              .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
        });
  }

  Future<void> _goToChangePasswordPage(BuildContext context) async {
    await NavigatorHelper.of(context).pushNamed(ChangePasswordPage.routeName);
  }

  Widget _buildNormalItem(
      {required String label,
      required Function() onPress,
      required String icon,
      bool isNotGuestUser = true}) {
    if (!isNotGuestUser) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: SvgPicture.asset(
                'lib/res/assets/$icon.svg',
              ),
            ),
            const SizedBox(width: 16.0),
            TitleText.medium(text: label),
            const Spacer(),
            const Icon(Icons.chevron_right)
          ],
        ),
        onTap: onPress,
      ),
    );
  }

  Widget _buildSwitchItem(BuildContext context,
      {required String label, required String icon}) {
    final authCubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: SvgPicture.asset(
              'lib/res/assets/$icon.svg',
            ),
          ),
          const SizedBox(width: 16.0),
          TitleText.medium(text: label),
          const Spacer(),
          CustomSwitchWidget(
            isEnabled: authCubit.state.user?.notificationEnabled ?? true,
            onPress: authCubit.updateUserNotificationStatus,
          )
        ],
      ),
    );
  }

  Widget _buildLanguageItem(BuildContext context,
      {required String label, required String icon}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: SvgPicture.asset(
              'lib/res/assets/$icon.svg',
            ),
          ),
          const SizedBox(width: 16.0),
          SizedBox(width: 120.0, child: TitleText.medium(text: label)),
          const Spacer(),
          _buildLanguageButton(context),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isNotGuestUser = authCubit.state.user?.accessToken != null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: () {
          if (EasyLocalization.of(context)!.currentLocale ==
              const Locale('en')) {
            EasyLocalization.of(context)!.setLocale(const Locale('ar'));
            if (isNotGuestUser)
              authCubit.informBackendAboutLanguageChanges('ar');
          } else {
            EasyLocalization.of(context)!.setLocale(const Locale('en'));
            if (isNotGuestUser)
              authCubit.informBackendAboutLanguageChanges('en');
          }
        },
        child: const TitleText(
          text: 'language',
          color: AppColors.BACKGROUND_COLOR,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TitleText.large(text: 'settings'),
    );
  }

  Future<void> _gToTopicsPage(BuildContext context, TopicType topicType) {
    return NavigatorHelper.of(context).push(
      MaterialPageRoute(builder: (_) => TopicPage(id: topicType)),
    );
  }

  void _backWithOrWithOutRefresh(BuildContext context) {
    if (startLocal != EasyLocalization.of(context)!.currentLocale) {
      _restartHomePage(context, initialPageIndex: 4);
    } else
      NavigatorHelper.of(context).pop();
  }

  void _restartHomePage(BuildContext context, {required int initialPageIndex}) {
    NavigatorHelper.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomePage(
          initialPageIndex: initialPageIndex,
        ),
      ),
      (route) => false,
    );
  }

  VoidCallback onRestartHelpLayer(BuildContext context) => () {
        _restartHomePage(context, initialPageIndex: 0);
        showSnackBar(
          context,
          message: 'help_layer_restarted_successfully',
          margin: const EdgeInsets.all(16.0),
        );
      };
}

class CustomSwitchWidget extends StatefulWidget {
  const CustomSwitchWidget({
    required this.isEnabled,
    required this.onPress,
    super.key,
  });

  final bool isEnabled;
  final ValueChanged<bool> onPress;

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  late bool _isEnabled;

  @override
  void initState() {
    _isEnabled = widget.isEnabled;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: _isEnabled,
      onChanged: (value) {
        widget.onPress(value);

        _isEnabled = value;

        setState(() {});
      },
      activeColor: AppColors.PRIMARY_COLOR,
    );
  }
}
