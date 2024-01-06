import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
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
        create: (context) =>
            AddMemberBloc(AddMemberState(addMemberModelObj: AddMemberModel()))
              ..add(AddMemberInitialEvent()),
        child: AddMemberScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 23.w, vertical: 22.h),
                    child: Column(children: [
                      SizedBox(
                          height: 102.h,
                          width: 106.w,
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        height: 96.adaptSize,
                                        width: 96.adaptSize,
                                        padding: EdgeInsets.all(29.w),
                                        decoration: AppDecoration.fillGray10002
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder12),
                                        child: CustomImageView(
                                            imagePath: ImageConstant
                                                .imgLockOnprimary37x37,
                                            height: 37.adaptSize,
                                            width: 37.adaptSize,
                                            alignment: Alignment.center))),
                                CustomIconButton(
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                    padding: EdgeInsets.all(7.w),
                                    decoration:
                                        IconButtonStyleHelper.outlineBlackTL15,
                                    alignment: Alignment.bottomRight,
                                    child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgSolarCameraOutline))
                              ])),
                      SizedBox(height: 18.h),
                      _buildNameEditText(context),
                      SizedBox(height: 16.h),
                      _buildPhoneNumber(context),
                      SizedBox(height: 16.h),
                      _buildFrameRow(context),
                      SizedBox(height: 32.h),
                      _buildSaveButton(context),
                      SizedBox(height: 5.h)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 24.w, right: 156.w),
              child: Row(children: [
                AppbarTitleIconbutton(
                    imagePath: ImageConstant.imgGroup1000002973,
                    onTap: () {
                      onTapIconButton(context);
                    }),
                AppbarSubtitle(
                    text: "lbl_add_member".tr(),
                    margin: EdgeInsets.only(left: 16.w, top: 6.h, bottom: 7.h))
              ])),
          SizedBox(height: 12.h),
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(width: double.maxFinite, child: Divider()))
        ]),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return BlocSelector<AddMemberBloc, AddMemberState, TextEditingController?>(
        selector: (state) => state.nameEditTextController,
        builder: (context, nameEditTextController) {
          return CustomTextFormField(
              controller: nameEditTextController,
              hintText: "lbl_name".tr(),
              hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
              validator: (value) {
                if (!isText(value)) {
                  return "err_msg_please_enter_valid_text".tr();
                }
                return null;
              });
        });
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return BlocBuilder<AddMemberBloc, AddMemberState>(
        builder: (context, state) {
      return CustomPhoneNumber(
          country: state.selectedCountry ??
              CountryPickerUtils.getCountryByPhoneCode('1'),
          controller: state.phoneNumberController,
          onTap: (Country value) {
            context.read<AddMemberBloc>().add(ChangeCountryEvent(value: value));
          });
    });
  }

  /// Section Widget
  Widget _buildMaleValueEditText(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: BlocSelector<AddMemberBloc, AddMemberState,
                    TextEditingController?>(
                selector: (state) => state.maleValueEditTextController,
                builder: (context, maleValueEditTextController) {
                  return CustomTextFormField(
                      controller: maleValueEditTextController,
                      hintText: "lbl_male".tr(),
                      hintStyle: CustomTextStyles.bodyMediumBluegray40001_1);
                })));
  }

  /// Section Widget
  Widget _buildFemaleValueEditText(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: OutlineGradientButton(
                padding: EdgeInsets.only(
                    left: 1.w, top: 1.h, right: 1.w, bottom: 1.h),
                strokeWidth: 1.w,
                gradient: LinearGradient(
                    begin: Alignment(0, 0.5),
                    end: Alignment(1, 0.5),
                    colors: [
                      theme.colorScheme.secondaryContainer,
                      theme.colorScheme.primary
                    ]),
                corners: Corners(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                child: BlocSelector<AddMemberBloc, AddMemberState,
                        TextEditingController?>(
                    selector: (state) => state.femaleValueEditTextController,
                    builder: (context, femaleValueEditTextController) {
                      return CustomTextFormField(
                          controller: femaleValueEditTextController,
                          hintText: "lbl_female".tr(),
                          textInputAction: TextInputAction.done,
                          borderDecoration: TextFormFieldStyleHelper
                              .gradientSecondaryContainerToDeepOrange,
                          filled: false);
                    }))));
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildMaleValueEditText(context),
      _buildFemaleValueEditText(context)
    ]);
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_save".tr(),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        onPressed: () {
          onTapSaveButton(context);
        });
  }

  /// Navigates to the selectMemberScreen when the action is triggered.
  onTapIconButton(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.selectMemberScreen,
    );
*/
  }

  /// Navigates to the selectMemberScreen when the action is triggered.
  onTapSaveButton(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.selectMemberScreen,
    );
*/
  }
}
