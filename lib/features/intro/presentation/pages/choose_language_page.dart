import 'dart:io';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_radio_list_tile.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/address/presentation/pages/select_location_screen.dart';
import 'package:masaj/features/home/presentation/pages/home_page.dart';
import 'package:masaj/features/intro/presentation/blocs/choose_language_cubit/choose_language_cubit.dart';
import 'package:masaj/features/intro/presentation/pages/guide_page.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';
import 'package:masaj/main.dart';

class ChooseLanguagePage extends StatefulWidget {
  static const routeName = '/ChooseLanguagePage';

  final bool fromSetting;

  const ChooseLanguagePage({super.key, this.fromSetting = false});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  Locale _selectedLocal = const Locale('en');
  String getTheDeviceLocale() {
    final localName = Platform.localeName;
    // return the first two characters of the local name
    return localName.substring(0, 2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocal = context.locale;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      child: BlocProvider(
        create: (context) => DI.find<ChooseLanguageCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<ChooseLanguageCubit, ChooseLanguageState>(
              listener: (context, state) async {
                final splashCubit = context.read<SplashCubit>();
                final splashState = splashCubit.state;
                if (state.isError) {
                  showSnackBar(context, message: state.errorMessage);
                  return;
                }
                final isFirstLaunch = splashState.isFirstLaunch ?? true;
                final countryNotSet = splashState.isCountrySet != true;
                if (state.isLanguageSet && isFirstLaunch) {
                  _goToGuidePage(context);
                  return;
                }
                if (state.isLanguageSet && countryNotSet) {
                  Navigator.of(context).pushReplacementNamed(
                    SelectLocationScreen.routeName,
                  );
                  return;
                }
                if (widget.fromSetting) {
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (_) => false);
                }
              },
              child: Scaffold(body: _buildBody(context)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: widget.fromSetting
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildAppBar(),
          widget.fromSetting
              ? SizedBox.shrink()
              : CustomImageView(
                  imagePath: ImageConstant.imgLayer2Gray90003,
                  height: 19.h,
                  width: 121.w),
          SizedBox(height: 18.h),
          Text(AppText.msg_choose_app_language,
              style: CustomTextStyles.titleMediumGray90002),
          SizedBox(height: 4.h),
          Text(AppText.msg_please_select_your,
              style: CustomTextStyles.bodyMediumGray60002),
          SizedBox(height: 19.h),
          CustomRadioListTile(
            label: Row(
              children: [
                CountryFlag.fromCountryCode('KW', width: 20.0, height: 20.0),
                const SizedBox(width: 8.0),
                CustomText(
                  text: AppText.arabic,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            value: const Locale('ar'),
            groupValue: _selectedLocal,
            onValueSelected: (value) =>
                setState(() => _selectedLocal = const Locale('ar')),
          ),
          const SizedBox(height: 14.0),
          CustomRadioListTile(
            label: Row(
              children: [
                CountryFlag.fromCountryCode('US', width: 20.0, height: 20.0),
                const SizedBox(width: 8.0),
                CustomText(
                  text: AppText.english,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            value: const Locale('en'),
            groupValue: _selectedLocal,
            onValueSelected: (value) =>
                setState( () => _selectedLocal = const Locale('en')),
          ),
          SizedBox(height: 24.h),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return widget.fromSetting
        ? CustomAppBar(
            leadingPadding: const EdgeInsets.only(right: 32),
            title: AppText.lbl_language,
            elevation: 0.0,
          )
        : SizedBox(height: 62.h);
  }

  Widget _buildNextButton(BuildContext context) {
    final cubit = context.read<ChooseLanguageCubit>();

    return DefaultButton(
      label: AppText.lbl_continue,
      onPressed: () {
        context.setLocale(_selectedLocal);
        MyApp.setLocale(context, _selectedLocal);
        cubit.saveLanguageCode(_selectedLocal.languageCode);
      },
      isExpanded: true,
    );
  }

  Future<void> _goToGuidePage(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(GuidePage.routeName);
}
