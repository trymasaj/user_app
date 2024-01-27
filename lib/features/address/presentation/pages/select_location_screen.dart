import 'package:masaj/features/address/presentation/widgets/country_and_region_selector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';

class SelectLocationScreen extends StatelessWidget {
  static const routeName = '/select-location';
  SelectLocationScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SelectLocationBloc>(
        create: (context) => getIt<SelectLocationBloc>()..getCountries(),
        child: SelectLocationScreen());
  }

  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.w),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 24.w, top: 62.h, right: 24.w),
            child: Column(children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("msg_select_your_location".tr(),
                      style: CustomTextStyles.titleMediumGray9000318)),
              SizedBox(height: 2.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("msg_please_select_your2".tr(),
                      style: CustomTextStyles.bodyMediumGray60002)),
              SizedBox(height: 19.h),
              CountryAndRegionSelector(decoration: InputDecoration(
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
              CustomElevatedButton(
                  text: "lbl_continue".tr(),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomButtonStyles
                      .gradientSecondaryContainerToPrimaryDecoration,
                  onPressed: () {
                    onTapContinue(context);
                  }),
              SizedBox(height: 5.h)
            ])));
  }

  onTapContinue(BuildContext context) async {
    final cubit = context.read<SelectLocationBloc>();
    final isCountrySet = await cubit.onContinuePressed();
    if (isCountrySet) {
      NavigatorHelper.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }
}
