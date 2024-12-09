import 'dart:developer';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/address/presentation/widgets/country_and_region_selector.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_state.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';

class SelectLocationScreen extends StatefulWidget {
  static const routeName = '/select-location';
  const SelectLocationScreen({
    super.key,
    this.isFromHomePage = false,
  });
  final bool isFromHomePage;

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late SplashCubit splashCubit;
  final formKey = GlobalKey<FormBuilderState>();
  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.w),
  );

  @override
  void initState() {
    splashCubit = context.read<SplashCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  CustomAppBar? _buildAppBar() =>
      widget.isFromHomePage ? CustomAppBar(title: AppText.location) : null;

  Widget _buildBody(BuildContext context) {
    return BlocProvider<SelectAreaCubit>(
      create: (context) => DI.find<NotInitiallySelectAreaCubit>()..init()..getCountries(),
      child: BlocBuilder<SelectAreaCubit, SelectAreaState>(
        builder: (context, state) {
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
                left: 24.w,
                top: widget.isFromHomePage ? 24.w : 62.h,
                right: 24.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: context.locale.languageCode == 'ar' ?Alignment.centerRight :Alignment.centerLeft,
                  child: Text(AppText.msg_select_your_location,
                      style: CustomTextStyles.titleMediumGray9000318)),
              SizedBox(height: 2.h),
              Align(
                  alignment: context.locale.languageCode == 'ar' ?Alignment.centerRight :Alignment.centerLeft,
                  child: Text(AppText.msg_please_select_your2,
                      style: CustomTextStyles.bodyMediumGray60002)),
              SizedBox(height: 19.h),
              CountryAndRegionSelector(
                  form: formKey,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      hintText: AppText.lbl_country,
                      hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
                      filled: true,
                      fillColor: appTheme.gray5001,
                      enabledBorder: border,
                      focusedBorder: border,
                      border: border,
                      disabledBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border)),
              _buildCountryError(),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.maxFinite,
                child: DefaultButton(
                    label: AppText.lbl_continue,
                    onPressed: () async {
                      await onTapContinue(context);
                    }),
              ),
              SizedBox(height: 5.h)
            ]),
          );
        },
      ),
    );
  }

  Widget _buildCountryError() {
    return BlocSelector<CountryCubit, CountryState, bool>(
      selector: (state) {
        return state.showCountryError;
      },
      builder: (context, state) {

        return state
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SubtitleText(
                  text: AppText.msg_please_select_your2,
                  color: AppColors.ERROR_COLOR,
                  subtractedSize: 4,
                ),
              )
            : const SizedBox();
      },
    );
  }

  Future onTapContinue(BuildContext context) async {
    final cubit = context.read<SelectAreaCubit>();
    final countryCubit = context.read<CountryCubit>();

    final isCountrySet = await cubit.onContinuePressed();

    if (isCountrySet) {
      countryCubit.setCountryError(false);
      await splashCubit.init();
      if (widget.isFromHomePage) {
        NavigatorHelper.of(context).pop();
        return;
      }
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);
    } else {
      countryCubit.setCountryError(true);
    }
  }
}
