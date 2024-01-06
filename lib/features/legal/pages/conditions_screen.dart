import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/core/widgets/custom_checkbox_button.dart';

import '../widgets/conditionslist_item_widget.dart';
import '../bloc/conditions_bloc/conditions_bloc.dart';
import '../models/conditions_model.dart';
import '../models/conditionslist_item_model.dart';
import 'package:flutter/material.dart';

class ConditionsScreen extends StatelessWidget {
  static const routeName = '/conditions';
  const ConditionsScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ConditionsBloc>(
        create: (context) => ConditionsBloc(
            ConditionsState(conditionsModelObj: ConditionsModel()))
          ..add(ConditionsInitialEvent()),
        child: ConditionsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(children: [
                  SizedBox(height: 24.h),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 24.w, right: 24.w, bottom: 5.h),
                              child: Column(children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("msg_select_your_conditions".tr(),
                                        style: CustomTextStyles
                                            .titleMediumGray90003)),
                                SizedBox(height: 11.h),
                                _buildConditionsList(context),
                                SizedBox(height: 18.h),
                                _buildOsteoporosisSection(context),
                                SizedBox(height: 17.h),
                                Divider(color: appTheme.gray300),
                                SizedBox(height: 16.h),
                                _buildPregnancyCheckbox(context),
                                SizedBox(height: 18.h),
                                _buildHerniatedBulgingSection(context),
                                SizedBox(height: 18.h),
                                Divider(color: appTheme.gray300),
                                SizedBox(height: 17.h),
                                _buildChestPainCheckbox(context),
                                SizedBox(height: 17.h),
                                Divider(color: appTheme.gray300),
                                SizedBox(height: 16.h),
                                _buildVaricoseVeinsCheckbox(context),
                                SizedBox(height: 18.h),
                                _buildNeckPainSection(context),
                                SizedBox(height: 16.h),
                                _buildDiabetesCheckbox(context),
                                SizedBox(height: 16.h),
                                Divider(color: appTheme.gray300),
                                SizedBox(height: 16.h),
                                _buildOtherSection(context)
                              ]))))
                ])),
            bottomNavigationBar: _buildDoneButton(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 24.w, right: 116.w),
              child: Row(children: [
                AppbarTitleIconbutton(
                    imagePath: ImageConstant.imgGroup1000002973,
                    onTap: () {
                      onTapIconButton(context);
                    }),
                AppbarSubtitle(
                    text: "msg_select_conditions".tr(),
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
  Widget _buildConditionsList(BuildContext context) {
    return BlocSelector<ConditionsBloc, ConditionsState, ConditionsModel?>(
        selector: (state) => state.conditionsModelObj,
        builder: (context, conditionsModelObj) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.5.h),
                    child: SizedBox(
                        width: 327.w,
                        child: Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: appTheme.gray300)));
              },
              itemCount: conditionsModelObj?.conditionslistItemList.length ?? 0,
              itemBuilder: (context, index) {
                ConditionslistItemModel model =
                    conditionsModelObj?.conditionslistItemList[index] ??
                        ConditionslistItemModel();
                return ConditionsListItem(model);
              });
        });
  }

  /// Section Widget
  Widget _buildOsteoporosisSection(BuildContext context) {
    return Column(children: [
      Divider(color: appTheme.gray300),
      SizedBox(height: 17.h),
      BlocSelector<ConditionsBloc, ConditionsState, bool?>(
          selector: (state) => state.osteoporosis,
          builder: (context, osteoporosis) {
            return CustomCheckboxButton(
                width: 327.w,
                text: "lbl_osteoporosis".tr(),
                value: osteoporosis,
                isRightCheck: true,
                onChange: (value) {
                  context
                      .read<ConditionsBloc>()
                      .add(ChangeCheckBoxEvent(value: value));
                });
          })
    ]);
  }

  /// Section Widget
  Widget _buildPregnancyCheckbox(BuildContext context) {
    return BlocSelector<ConditionsBloc, ConditionsState, bool?>(
        selector: (state) => state.pregnancyCheckbox,
        builder: (context, pregnancyCheckbox) {
          return CustomCheckboxButton(
              width: 327.w,
              text: "msg_pregnant_of_wks_mo".tr(),
              value: pregnancyCheckbox,
              isRightCheck: true,
              onChange: (value) {
                context
                    .read<ConditionsBloc>()
                    .add(ChangeCheckBox1Event(value: value));
              });
        });
  }

  /// Section Widget
  Widget _buildHerniatedBulgingSection(BuildContext context) {
    return Column(children: [
      Divider(color: appTheme.gray300),
      SizedBox(height: 16.h),
      BlocSelector<ConditionsBloc, ConditionsState, bool?>(
          selector: (state) => state.thumbsup,
          builder: (context, thumbsup) {
            return CustomCheckboxButton(
                width: 327.w,
                text: "msg_herniated_bulging".tr(),
                value: thumbsup,
                isRightCheck: true,
                onChange: (value) {
                  context
                      .read<ConditionsBloc>()
                      .add(ChangeCheckBox2Event(value: value));
                });
          })
    ]);
  }

  /// Section Widget
  Widget _buildChestPainCheckbox(BuildContext context) {
    return BlocSelector<ConditionsBloc, ConditionsState, bool?>(
        selector: (state) => state.chestPainCheckbox,
        builder: (context, chestPainCheckbox) {
          return CustomCheckboxButton(
              width: 327.w,
              text: "lbl_chest_pain".tr(),
              value: chestPainCheckbox,
              isRightCheck: true,
              onChange: (value) {
                context
                    .read<ConditionsBloc>()
                    .add(ChangeCheckBox3Event(value: value));
              });
        });
  }

  /// Section Widget
  Widget _buildVaricoseVeinsCheckbox(BuildContext context) {
    return BlocSelector<ConditionsBloc, ConditionsState, bool?>(
        selector: (state) => state.varicoseVeinsCheckbox,
        builder: (context, varicoseVeinsCheckbox) {
          return CustomCheckboxButton(
              width: 327.w,
              text: "lbl_varicose_veins".tr(),
              value: varicoseVeinsCheckbox,
              isRightCheck: true,
              onChange: (value) {
                context
                    .read<ConditionsBloc>()
                    .add(ChangeCheckBox4Event(value: value));
              });
        });
  }

  /// Section Widget
  Widget _buildNeckPainSection(BuildContext context) {
    return Column(children: [
      Divider(color: appTheme.gray300),
      SizedBox(height: 17.h),
      BlocSelector<ConditionsBloc, ConditionsState, bool?>(
          selector: (state) => state.neckpain,
          builder: (context, neckpain) {
            return CustomCheckboxButton(
                width: 327.w,
                text: "lbl_neck_pain".tr(),
                value: neckpain,
                isRightCheck: true,
                onChange: (value) {
                  context
                      .read<ConditionsBloc>()
                      .add(ChangeCheckBox5Event(value: value));
                });
          }),
      SizedBox(height: 15.h),
      Divider(color: appTheme.gray300)
    ]);
  }

  /// Section Widget
  Widget _buildDiabetesCheckbox(BuildContext context) {
    return BlocSelector<ConditionsBloc, ConditionsState, bool?>(
        selector: (state) => state.diabetesCheckbox,
        builder: (context, diabetesCheckbox) {
          return CustomCheckboxButton(
              width: 327.w,
              text: "lbl_diabeties".tr(),
              value: diabetesCheckbox,
              isRightCheck: true,
              onChange: (value) {
                context
                    .read<ConditionsBloc>()
                    .add(ChangeCheckBox6Event(value: value));
              });
        });
  }

  /// Section Widget
  Widget _buildOtherSection(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("lbl_other".tr(), style: CustomTextStyles.bodyMediumOnPrimary_2),
      CustomImageView(
          imagePath: ImageConstant.imgThumbsUp,
          height: 18.adaptSize,
          width: 18.adaptSize)
    ]);
  }

  /// Section Widget
  Widget _buildDoneButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_done".tr(),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        onPressed: () {
          onTapDoneButton(context);
        });
  }

  /// Navigates to the medicalFormScreen when the action is triggered.
  onTapIconButton(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.medicalFormScreen,
    );
*/
  }

  /// Navigates to the medicalFormScreen when the action is triggered.
  onTapDoneButton(BuildContext context) {
/*
    NavigatorService.pushNamed(
      AppRoutes.medicalFormScreen,
    );
*/
  }
}
