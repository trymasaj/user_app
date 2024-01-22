import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/bloc/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/entities/city.dart';
import 'package:masaj/features/address/entities/country.dart';
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
    final controller = context.read<SelectLocationBloc>();
    final isArabic = context.locale == const Locale('ar');
    return Scaffold(
        //  appBar: AppBar(),
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
              BlocSelector<SelectLocationBloc, SelectLocationState,
                      DataLoadState<List<Country>>>(
                  selector: (state) => state.countries,
                  builder: (context, state) {
                    return LoadStateHandler(
                      customState: state,
                      onTapRetry: controller.getCountries,
                      onData: (data) {
                        return DropdownButtonFormField<Country>(
                          isExpanded: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 18.h),
                              hintText: "lbl_country".tr(),
                              hintStyle:
                                  CustomTextStyles.bodyMediumBluegray40001_1,
                              filled: true,
                              fillColor: appTheme.gray5001,
                              enabledBorder: border,
                              focusedBorder: border,
                              border: border,
                              disabledBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border),
                          // value: state.selectedCountry.toNullable()?.id,
                          items: data
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (e.flagIcon != null)
                                        CachedNetworkImage(
                                            imageUrl: e.flagIcon!,
                                            height: 20.h,
                                            fit: BoxFit.cover,
                                            width: 20.w),
                                      SizedBox(width: 3.w),
                                      Text(
                                        isArabic
                                            ? e.nameAr ?? ''
                                            : e.nameEn ?? '',
                                        style: CustomTextStyles
                                            .bodyMediumOnErrorContainer,
                                      ),
                                      Spacer(),
                                      Text(
                                        e.code ?? '',
                                        style: CustomTextStyles
                                            .bodyMediumOnErrorContainer,
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (value) =>
                              controller.onCountryChanged(value!),
                        );
                      },
                    );
                  }),
              SizedBox(height: 18.h),
              BlocSelector<SelectLocationBloc, SelectLocationState,
                      DataLoadState<List<City>>>(
                  selector: (state) => state.cities,
                  builder: (context, state) {
                    return LoadStateHandler(
                      customState: state,
                      onTapRetry: controller.getCities,
                      onData: (data) {
                        return DropdownButtonFormField<City>(
                          isExpanded: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 18.h),
                              hintText: "lbl_region_area".tr(),
                              hintStyle:
                                  CustomTextStyles.bodyMediumBluegray40001_1,
                              filled: true,
                              fillColor: appTheme.gray5001,
                              enabledBorder: border,
                              focusedBorder: border,
                              border: border,
                              disabledBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border),
                          items: data
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const SizedBox(width: 3),
                                      Text(
                                        isArabic
                                            ? e.name.nameAr
                                            : e.name.nameEn,
                                        style: CustomTextStyles
                                            .bodyMediumOnErrorContainer,
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (value) =>
                              controller.onCityChanged(value!),
                        );
                      },
                    );
                  }),
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
