import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/core/widgets/custom_text_form_field.dart';
import 'package:masaj/core/widgets/password_text_field.dart';

import '../bloc/create_new_password_bloc/create_new_password_bloc.dart';
import '../models/create_new_password_model.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';

  CreateNewPasswordScreen({super.key});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewPasswordOneBloc>(
      create: (context) => CreateNewPasswordOneBloc(CreateNewPasswordOneState(
        createNewPasswordOneModelObj: CreateNewPasswordOneModel(),
      ))
        ..add(CreateNewPasswordOneInitialEvent()),
      child: CreateNewPasswordScreen(),
    );
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
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 23.h,
          ),
          child: Column(
            children: [
              PasswordTextField(
                controller: TextEditingController(),
                hint: 'msg_current_password',
              ),
              SizedBox(height: 20.h),
              PasswordTextField(
                controller: TextEditingController(),
                hint: 'lbl_new_password',
              ),
              SizedBox(height: 20.h),
              PasswordTextField(controller: TextEditingController(), hint: 'msg_confirm_new_password',),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'lbl_change_password'.tr(),
      ),
    );
  }

  /// Section Widget
  Widget _buildNewPasswordEditText(BuildContext context) {
    return BlocBuilder<CreateNewPasswordOneBloc, CreateNewPasswordOneState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: state.newPasswordEditTextController,
          hintText: "lbl_new_password".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(18.w, 18.h, 8.w, 18.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocation,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.h,
          ),
          suffix: InkWell(
            onTap: () {
              context.read<CreateNewPasswordOneBloc>().add(
                  ChangePasswordVisibilityEvent1(
                      value: !state.isShowPassword1));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30.w, 17.h, 17.w, 19.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgSettingsBlueGray40001,
                height: 20.h,
                width: 24.w,
              ),
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 56.h,
          ),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr();
            }
            return null;
          },
          obscureText: state.isShowPassword1,
          contentPadding: EdgeInsets.symmetric(vertical: 17.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL12,
          filled: false,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildNewPasswordEditText1(BuildContext context) {
    return BlocBuilder<CreateNewPasswordOneBloc, CreateNewPasswordOneState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: state.newPasswordEditTextController1,
          hintText: "msg_confirm_new_password".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(18.w, 18.h, 8.w, 18.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocation,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.h,
          ),
          suffix: InkWell(
            onTap: () {
              context.read<CreateNewPasswordOneBloc>().add(
                  ChangePasswordVisibilityEvent2(
                      value: !state.isShowPassword2));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30.w, 17.h, 17.w, 19.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgSettingsBlueGray40001,
                height: 20.h,
                width: 24.w,
              ),
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 56.h,
          ),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr();
            }
            return null;
          },
          obscureText: state.isShowPassword2,
          contentPadding: EdgeInsets.symmetric(vertical: 17.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL12,
          filled: false,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_continue".tr(),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
    );
  }
}
