import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_outlined_button.dart';

import 'package:masaj/features/account/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:masaj/features/account/models/my_profile_model.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/my_profile';

  MyProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<MyProfileBloc>(
      create: (context) => MyProfileBloc(MyProfileState(
        myProfileModelObj: const MyProfileModel(),
      )),
      child: MyProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 23.w,
                vertical: 22.h,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 102.h,
                    width: 104.w,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle4237,
                          height: 96.adaptSize,
                          width: 96.adaptSize,
                          radius: BorderRadius.circular(
                            12.w,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        CustomIconButton(
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                          padding: EdgeInsets.all(7.w),
                          decoration: IconButtonStyleHelper.outlineBlackTL15,
                          alignment: Alignment.bottomRight,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSolarCameraOutline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'lbl_name'.tr(),
                      labelStyle: CustomTextStyles.bodyMediumOnPrimary_2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'lbl_email'.tr(),
                      labelStyle: CustomTextStyles.bodyMediumOnPrimary_2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildBirthDate(context),
                  SizedBox(height: 20.h),
                  _buildFrameRow(context),
                  SizedBox(height: 32.h),
                  _buildSaveButton(context),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('lbl_my_profile'.tr()),
    );
  }

  Widget _buildBirthDate(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
            decoration: InputDecoration(
          labelText: 'lbl_birth_date'.tr(),
          labelStyle: CustomTextStyles.bodyMediumOnPrimary_2,
        )),
        Positioned.fill(
          right: 20,
          left: 20,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomImageView(
              imagePath: ImageConstant.imgCalendar,
              height: 20.adaptSize,
              width: 20.adaptSize,
              margin: EdgeInsets.only(top: 1.h),
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildGenderButton(String title) {
    return Expanded(
      child: CustomOutlinedButton(
        text: title.tr(),
        margin: EdgeInsets.only(right: 4.w),
        buttonStyle: CustomButtonStyles.outlineBlueGray,
        buttonTextStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildFemaleButton(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: 'lbl_female'.tr(),
        margin: EdgeInsets.only(right: 4.w),
        buttonStyle: CustomButtonStyles.outlineBlueGray,
        buttonTextStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton('lbl_male'),
        _buildGenderButton('lbl_female'),
      ],
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'lbl_save'.tr(),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
    );
  }
}
/*
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 4.h),
        child: OutlineGradientButton(
            elevation: 0,
            padding:
                EdgeInsets.only(left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
            strokeWidth: 1.h,
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
            child: CustomOutlinedButton(
              text: "lbl_female".tr(),
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles
                  .gradientSecondaryContainerToDeepOrangeDecoration,
              buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
            )),
      ),
    );

 */
