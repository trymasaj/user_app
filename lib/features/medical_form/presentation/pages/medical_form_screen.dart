import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/extensions/extensions.dart';

import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';
import 'package:masaj/features/medical_form/presentation/bloc/medical_form_bloc/medical_form_bloc.dart';
import 'package:masaj/features/medical_form/presentation/pages/medical_conditions_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicalFormScreen extends StatefulWidget {
  static const routeName = '/medical-form';

  const MedicalFormScreen({super.key});

  @override
  State<MedicalFormScreen> createState() => _MedicalFormScreenState();
}

class _MedicalFormScreenState extends State<MedicalFormScreen> {

  // di
  SystemService system = DI.find();

  late final TextEditingController _conditionsController;
  final _birthDateTextController = TextEditingController(),
      _treatmentGoalsController = TextEditingController(),
      _allergiesStatementController = TextEditingController(),
      _medicationsController = TextEditingController(),
      _avoidAreasController = TextEditingController(),
      _guardianNameController = TextEditingController(),
      _anyInstructionsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _birthDateFocusNode = FocusNode(),
      _treatmentGoalsFocusNode = FocusNode(),
      _allergiesStatementFocusNode = FocusNode(),
      _medicationsFocusNode = FocusNode(),
      _avoidAreasFocusNode = FocusNode(),
      _guardianNameFocusNode = FocusNode(),
      _anyInstructionsFocusNode = FocusNode();

  @override
  void initState() {
    _conditionsController = TextEditingController(text: 'lbl_conditions'.tr());
    context.read<MedicalFormBloc>().getConditions();
    context.read<MedicalFormBloc>().clear();

    loadData();

    super.initState();
  }

  void loadData() async {
    final cubit = context.read<MedicalFormBloc>();
    await cubit.getMedicalForm();
    final medicalForm = cubit.state.medicalForm;
    String conditions = '';
    medicalForm?.conditions?.forEach((e) => conditions += '${e.nameEn} , ');
    _conditionsController.text = conditions;

    _birthDateTextController.text = medicalForm?.birthDate?.formatDate() ?? '';
    _treatmentGoalsController.text = medicalForm?.treatmentGoals ?? '';
    _allergiesStatementController.text = medicalForm?.allergiesStatement ?? '';
    _medicationsController.text = medicalForm?.medicationsStatement ?? '';
    _avoidAreasController.text = medicalForm?.avoidedAreas ?? '';
    _guardianNameController.text = medicalForm?.guardianName ?? '';
    _anyInstructionsController.text = medicalForm?.instructions ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalFormBloc, MedicalFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: BlocConsumer<MedicalFormBloc, MedicalFormState>(
                builder: (context, state) {
                  return Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFrame(context),
                                SizedBox(height: 18.h),
                                Text(
                                  'msg_health_condititons'.tr(),
                                  style:
                                      CustomTextStyles.titleMediumOnPrimary_1,
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
                                      style: TextStyle(
                                          color: AppColors.GREY_NORMAL_COLOR),
                                      readOnly: true,
                                      controller: _conditionsController,
                                      name: 'conditions',
                                      onTap: () async {
                                        await NavigatorHelper.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const MedicalConditionScreen(),
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 17.h),
                                _buildFrame1(context),
                                SizedBox(height: 16.h),
                                Container(
                                  width: 290.w,
                                  margin: EdgeInsets.only(right: 36.w),
                                  child: Text(
                                    'msg_are_you_presently'.tr(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                DefaultTextFormField(
                                  currentController: _medicationsController,
                                  hint: '',
                                  maxLines: 3,
                                  currentFocusNode: _medicationsFocusNode,
                                  isRequired: true,
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
                  );
                },
                listener: (BuildContext context, MedicalFormState state) {
                  if (state.isConditionSaved) {
                    _conditionsController.clear();
                    for (var condition in state.selectedConditions ?? []) {
                      _conditionsController.text =
                          (condition.nameEn ?? '') + ',';
                    }
                  }
                  if (state.isLoaded) {
                    showSnackBar(context, message: 'msg_medical_form'.tr());

                    NavigatorHelper.of(context).pop();
                  }
                  if (state.isError) {
                    showSnackBar(context, message: state.errorMessage);
                  }
                },
              ),
            ),
            bottomNavigationBar: _buildSave(context),
          ),
        );
      },
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
        DefaultTextFormField(
          isRequired: true,
          readOnly: true,
          currentFocusNode: _birthDateFocusNode,
          currentController: _birthDateTextController,
          hint: 'lbl_birth_date',
          prefixIcon: buildImage(ImageConstant.imgCalendar),
          suffixIcon: buildImage(ImageConstant.imgCalendar),
          onTap: () async {
            final initialDate = _birthDateTextController.text.isNotEmpty
                ? _birthDateTextController.text.parseDate()
                : system.now;
            final pickedDate = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: system.now.subtract(const Duration(days: 43800)),
                lastDate: system.now,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    child: child!,
                  );
                });
            if (pickedDate != null) {
              _birthDateTextController.text = pickedDate.formatDate();
            }
          },
        ),
      ],
    );
  }

  Widget buildImage(String imagePath) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 17.h, 10.w, 19.h),
      child: CustomImageView(
        imagePath: imagePath,
        height: 20.h,
        width: 20.w,
        color: appTheme.blueGray40001,
      ),
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
        DefaultTextFormField(
          currentController: _allergiesStatementController,
          hint: '',
          maxLines: 3,
          currentFocusNode: _allergiesStatementFocusNode,
          isRequired: true,
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
        DefaultTextFormField(
          currentController: _treatmentGoalsController,
          hint: '',
          maxLines: 3,
          currentFocusNode: _treatmentGoalsFocusNode,
          isRequired: true,
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
        DefaultTextFormField(
          currentController: _avoidAreasController,
          hint: '',
          maxLines: 3,
          currentFocusNode: _avoidAreasFocusNode,
          isRequired: true,
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
        DefaultTextFormField(
          currentController: _anyInstructionsController,
          hint: '',
          maxLines: 3,
          currentFocusNode: _anyInstructionsFocusNode,
          isRequired: true,
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
        DefaultTextFormField(
          currentController: _guardianNameController,
          hint: ''.tr(),
          maxLines: 3,
          isRequired: true,
          currentFocusNode: _guardianNameFocusNode,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    final cubit = context.read<MedicalFormBloc>();
    return DefaultButton(
      label: 'lbl_save'.tr(),
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      onPressed: () async {
        if (_isValid())
          await cubit.addMedicalForm(MedicalForm(
            birthDate: _birthDateTextController.text.parseDate(),
            conditions: cubit.state.selectedConditions,
            treatmentGoals: _treatmentGoalsController.text,
            medicationsStatement: _medicationsController.text,
            allergiesStatement: _allergiesStatementController.text,
            avoidedAreas: _avoidAreasController.text,
            guardianName: _guardianNameController.text,
            instructions: _anyInstructionsController.text,
          ));
      },
    );
  }

  bool _isValid() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }
}
