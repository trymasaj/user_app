import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/core/widgets/custom_radio_button.dart';

import '../bloc/select_language_bloc/select_language_bloc.dart';
import '../models/select_language_model.dart';
import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<SelectLanguageBloc>(
      create: (context) => SelectLanguageBloc(SelectLanguageState(
        selectLanguageModelObj: SelectLanguageModel(),
      ))
        ..add(SelectLanguageInitialEvent()),
      child: SelectLanguageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 27.h,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "msg_choose_you_preferred".tr(),
                  style: CustomTextStyles.titleMediumGray9000318,
                ),
              ),
              SizedBox(height: 21.h),
              _buildChooseYourPreferredLanguage(context),
              SizedBox(height: 32.h),
              CustomElevatedButton(
                text: "lbl_save".tr(),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles
                    .gradientSecondaryContainerToPrimaryDecoration,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 188.w,
            ),
            child: Row(
              children: [
                AppbarTitleIconbutton(
                  imagePath: ImageConstant.imgGroup1000002973,
                ),
                AppbarSubtitle(
                  text: "lbl_language".tr(),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    top: 9.h,
                    bottom: 4.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(),
            ),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildChooseYourPreferredLanguage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: BlocBuilder<SelectLanguageBloc, SelectLanguageState>(
        builder: (context, state) {
          return state.selectLanguageModelObj!.radioList.isNotEmpty
              ? Column(
                  children: [
                    CustomRadioButton(
                      width: 327.w,
                      text: "lbl_arabic".tr(),
                      value: state.selectLanguageModelObj?.radioList[0] ?? "",
                      groupValue: state.chooseYourPreferredLanguage,
                      padding: EdgeInsets.all(18.w),
                      textStyle: CustomTextStyles.titleSmallOnPrimary_3,
                      decoration: RadioStyleHelper.fillGray,
                      isRightCheck: true,
                      onChange: (value) {
                        context
                            .read<SelectLanguageBloc>()
                            .add(ChangeRadioButtonEvent(value: value));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: CustomRadioButton(
                        width: 327.w,
                        text: "lbl_english".tr(),
                        value: state.selectLanguageModelObj?.radioList[1] ?? "",
                        groupValue: state.chooseYourPreferredLanguage,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 16.h,
                        ),
                        decoration: RadioStyleHelper.outline,
                        isRightCheck: true,
                        onChange: (value) {
                          context
                              .read<SelectLanguageBloc>()
                              .add(ChangeRadioButtonEvent(value: value));
                        },
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
