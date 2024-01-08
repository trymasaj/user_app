import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/custom_phone_number.dart';
import 'package:masaj/core/widgets/custom_text_form_field.dart';

import '../bloc/add_member_bloc/add_member_bloc.dart';
import '../models/add_member_model.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore_for_file: must_be_immutable
class AddMemberScreen extends StatelessWidget {
  AddMemberScreen({Key? key}) : super(key: key);
  static const routeName = '/add-member';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<AddMemberBloc>(
        create: (context) => AddMemberBloc(AddMemberState.initial()),
        child: AddMemberScreen());
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
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 22.h),
                child: Column(children: [
                  SizedBox(
                      height: 102.h,
                      width: 106.w,
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                height: 96.adaptSize,
                                width: 96.adaptSize,
                                padding: EdgeInsets.all(29.w),
                                decoration: AppDecoration.fillGray10002
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder12),
                                child: CustomImageView(
                                    imagePath:
                                        ImageConstant.imgLockOnprimary37x37,
                                    height: 37.adaptSize,
                                    width: 37.adaptSize,
                                    alignment: Alignment.center))),
                        CustomIconButton(
                            height: 30.adaptSize,
                            width: 30.adaptSize,
                            padding: EdgeInsets.all(7.w),
                            decoration: IconButtonStyleHelper.outlineBlackTL15,
                            alignment: Alignment.bottomRight,
                            child: CustomImageView(
                                imagePath: ImageConstant.imgSolarCameraOutline))
                      ])),
                  SizedBox(height: 18.h),
                  _buildNameEditText(context),
                  SizedBox(height: 16.h),
                  _buildPhoneNumber(context),
                  SizedBox(height: 16.h),
                  // _buildFrameRow(context),
                  SizedBox(height: 32.h),
                  _buildSaveButton(context),
                  SizedBox(height: 5.h)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("lbl_add_member".tr()),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return CustomTextFormField(
        hintText: "lbl_name".tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        validator: (value) {
          if (!isText(value)) {
            return "err_msg_please_enter_valid_text".tr();
          }
          return null;
        });
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return BlocBuilder<AddMemberBloc, AddMemberState>(
        builder: (context, state) {
      return CustomPhoneNumber(
          country: state.selectedCountry.toNullable() ??
              CountryPickerUtils.getCountryByPhoneCode('1'),
          onTap: (Country value) {
            context.read<AddMemberBloc>().changeCountry(value);
          });
    });
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_save".tr(),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        onPressed: () {});
  }
}
