import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_phone_number.dart';

import 'package:masaj/features/account/bloc/phone_bloc/phone_bloc.dart';
import 'package:masaj/features/account/models/phone_model.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class PhoneScreen extends StatelessWidget {
  static const routeName = '/phone';

  PhoneScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<PhoneBloc>(
        create: (context) => PhoneBloc(PhoneState(phoneModelObj: const PhoneModel())),
        child: PhoneScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
            key: _formKey,
            child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(23.w),
                child: Column(children: [
                  BlocBuilder<PhoneBloc, PhoneState>(builder: (context, state) {
                    return CustomPhoneNumber(
                        country: state.selectedCountry ??
                            CountryPickerUtils.getCountryByPhoneCode('1'),
                        onTap: (Country value) {
                          context.read<PhoneBloc>().changeCountry((value));
                        });
                  }),
                  SizedBox(height: 32.h),
                  CustomElevatedButton(
                      text: 'lbl_save'.tr(),
                      buttonStyle: CustomButtonStyles.none,
                      decoration: CustomButtonStyles
                          .gradientSecondaryContainerToPrimaryDecoration,
                      onPressed: () {
                        onTapSave(context);
                      }),
                  SizedBox(height: 5.h)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('lbl_phone_number'.tr()),
    );
  }

  /// Navigates to the verificationCodeForEditPhoneScreen when the action is triggered.
  void onTapSave(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.verificationCodeForEditPhoneScreen,
    );
*/
  }
}
