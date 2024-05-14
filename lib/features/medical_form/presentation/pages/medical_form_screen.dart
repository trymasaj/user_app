import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/medical_form/presentation/bloc/medical_form_bloc/medical_form_bloc.dart';
import 'package:masaj/features/medical_form/presentation/pages/medical_conditions_screen.dart';

class MedicalFormScreen extends StatefulWidget {
  static const routeName = '/medical-form';

  const MedicalFormScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MedicalFormBloc>(
      create: (context) => Injector().medicalFormBloc,
      child: const MedicalFormScreen(),
    );
  }

  @override
  State<MedicalFormScreen> createState() => _MedicalFormScreenState();
}

class _MedicalFormScreenState extends State<MedicalFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            SizedBox(height: 22.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    bottom: 5.h,
                  ),
                  child: Column(
                    children: [
                      _buildFrame(context),
                      SizedBox(height: 18.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'msg_health_condititons'.tr(),
                          style: CustomTextStyles.titleMediumOnPrimary_1,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      SizedBox(
                        width: 325.w,
                        child: Text(
                          'msg_select_all_the_conditions'.tr(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.57,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'lbl_conditions'.tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.h),
                          FormBuilderTextField(
                            name: 'lbl_conditions',
                            onTap: () {
                              NavigatorHelper.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                Injector().medicalFormBloc
                                                  ..getConditions(),
                                            child:
                                                const MedicalConditionScreen(),
                                          )));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 17.h),
                      _buildFrame1(context),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 290.w,
                          margin: EdgeInsets.only(right: 36.w),
                          child: Text(
                            'msg_are_you_presently'.tr(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              height: 1.57,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Container(
                        height: 80.h,
                        width: 327.w,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(1),
                          borderRadius: BorderRadius.circular(
                            12.w,
                          ),
                          border: Border.all(
                            color: appTheme.blueGray100,
                            width: 1.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildEditText(context),
                      SizedBox(height: 16.h),
                      _buildFrame2(context),
                      SizedBox(height: 16.h),
                      _buildFrame3(context),
                      SizedBox(height: 18.h),
                      _buildFrame4(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSave(context),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'lbl_medical_form'.tr(),
    );
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'lbl_birth_date'.tr(),
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 7.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 19.w,
            vertical: 17.h,
          ),
          decoration: AppDecoration.outlineBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomImageView(
              imagePath: ImageConstant.imgCalendarOnprimary20x20,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildFrame1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'msg_do_you_have_any'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 7.h),
        FormBuilderTextField(
          name: 'allergies',
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildEditText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'msg_personalize_you'.tr(),
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 6.h),
        Text(
          'msg_what_are_your_treatment'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 7.h),
        FormBuilderTextField(
          name: 'treatment_goals',
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildFrame2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 294.w,
          margin: EdgeInsets.only(right: 32.w),
          child: Text(
            'msg_during_your_massage'.tr(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              height: 1.57,
            ),
          ),
        ),
        SizedBox(height: 7.h),
        FormBuilderTextField(
          name: 'avoid_areas',
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildFrame3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'msg_do_you_have_any2'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 8.h),
        FormBuilderTextField(
          name: 'any_instructions',
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildFrame4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'lbl_guardian_name'.tr(),
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 6.h),
        Text(
          'msg_required_for_quests'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 9.h),
        FormBuilderTextField(
          name: 'guardian_name',
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return CustomElevatedButton(
      text: 'lbl_save'.tr(),
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
    );
  }
}
