import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/address/presentation/widgets/country_and_region_selector.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';

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
  final formKey = GlobalKey<FormBuilderState>();
  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.w),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  CustomAppBar? _buildAppBar() =>
      widget.isFromHomePage ? CustomAppBar(title: 'location'.tr()) : null;

  Widget _buildBody(BuildContext context) {
    return BlocProvider<SelectAreaCubit>(
      create: (context) => getIt<NotInitiallySelectAreaCubit>()..getCountries(),
      child: Builder(builder: (context) {
        return Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
                left: 24.w,
                top: widget.isFromHomePage ? 24.w : 62.h,
                right: 24.w),
            child: Column(children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('msg_select_your_location'.tr(),
                      style: CustomTextStyles.titleMediumGray9000318)),
              SizedBox(height: 2.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("msg_please_select_your2".tr(),
                      style: CustomTextStyles.bodyMediumGray60002)),
              SizedBox(height: 19.h),
              CountryAndRegionSelector(
                  form: formKey,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      hintText: "lbl_country".tr(),
                      hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
                      filled: true,
                      fillColor: appTheme.gray5001,
                      enabledBorder: border,
                      focusedBorder: border,
                      border: border,
                      disabledBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border)),
              SizedBox(height: 24.h),
              Container(
                width: double.maxFinite,
                //TODO review this
                child: DefaultButton(
                    label: 'lbl_continue',
                    // text: "lbl_continue".tr(),
                    // buttonStyle: CustomButtonStyles.none,
                    // decoration: CustomButtonStyles
                    //     .gradientSecondaryContainerToPrimaryDecoration,
                    onPressed: () async {
                      await onTapContinue(context);
                    }),
              ),
              SizedBox(height: 5.h)
            ]));
      }),
    );
  }

  Future onTapContinue(BuildContext context) async {
    final cubit = context.read<SelectAreaCubit>();
    final isCountrySet = await cubit.onContinuePressed();
    if (isCountrySet) {
      if (widget.isFromHomePage) {
        NavigatorHelper.of(context).pop();
        return;
      }
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }
}
