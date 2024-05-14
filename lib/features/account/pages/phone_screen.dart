import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/account/bloc/phone_bloc/phone_bloc.dart';
import 'package:masaj/features/account/models/phone_model.dart';

// ignore_for_file: must_be_immutable
class PhoneScreen extends StatelessWidget {
  static const routeName = '/phone';

  PhoneScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<PhoneBloc>(
        create: (context) =>
            PhoneBloc(PhoneState(phoneModelObj: const PhoneModel())),
        child: PhoneScreen());
  }

  late final TextEditingController _phoneNumberConttroleer;
  late final FocusNode _phoneFocusNode;
  PhoneNumber? _phoneNumber;

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
                    return PhoneTextFormField(
                      currentController: _phoneNumberConttroleer,
                      currentFocusNode: _phoneFocusNode,
                      initialValue: _phoneNumber,
                      onInputChanged: (value) => _phoneNumber = value,
                      nextFocusNode: null,
                    );
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
    return CustomAppBar(
      title: 'lbl_phone_number'.tr(),
      centerTitle: true,
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
