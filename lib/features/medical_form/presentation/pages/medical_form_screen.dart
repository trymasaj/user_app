import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';

import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';
import 'package:masaj/features/medical_form/data/repo/medical_form_repo.dart';
import 'package:masaj/features/medical_form/presentation/bloc/medical_form_bloc/medical_form_state.dart';
import 'package:masaj/features/medical_form/presentation/pages/medical_conditions_screen.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';

class MedicalFormScreen extends StatefulWidget {
  static const routeName = '/medical-form';

  const MedicalFormScreen({super.key});

  @override
  State<MedicalFormScreen> createState() => _MedicalFormScreenState();
}

class _MedicalFormScreenState extends State<MedicalFormScreen> {
  // di
  final SystemService system = DI.find();
  final MedicalFormRepository _medicalFormRepo = DI.find();
  final AbsLogger logger = DI.find();

  MedicalFormState state = MedicalFormState();
  int _completedTasks = 0;
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
    _completedTasks = 0;
    _conditionsController = TextEditingController(text: AppText.lbl_conditions);
    getConditions();
    clear();

    loadData();

    super.initState();
  }

  void loadData() async {
    await getMedicalForm();
    final medicalForm = state.medicalForm;
    state = state.copyWith(
        selectedConditions: medicalForm?.conditions,
        //status: MedicalFormStateStatus.conditionSaved
    );
    _conditionsController.text = medicalForm?.conditions?.map((e)=> e.localizedName(context)).join(',') ?? '';
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
    if(state.status == MedicalFormStateStatus.getMedicalForm) _completedTasks++;
    if(state.status == MedicalFormStateStatus.loadedCondition) _completedTasks++;
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: (state.status == MedicalFormStateStatus.loading || _completedTasks <2) ?
        CustomLoading(
          loadingStyle: LoadingStyle.ShimmerList,
        )
            :Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFrame(context),
                          SizedBox(height: 18.h),
                          Text(
                            AppText.msg_health_condititons,
                            style: CustomTextStyles.titleMediumOnPrimary_1,
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            width: 325.w,
                            child: Text(
                              AppText.msg_select_all_the_conditions,
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
                                AppText.lbl_conditions,
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 7.h),
                              FormBuilderTextField(
                                style: TextStyle(
                                    color: AppColors.GREY_NORMAL_COLOR),
                                readOnly: true,
                                controller: _conditionsController,
                                name: 'conditions',
                                onTap: () => openMedicalConditionsPage(context),
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
                              AppText.msg_are_you_presently,
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
            )),
        bottomNavigationBar: _buildSave(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_medical_form,
    );
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppText.lbl_birth_date,
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 7.h),
        DefaultTextFormField(
          isRequired: true,
          readOnly: true,
          currentFocusNode: _birthDateFocusNode,
          currentController: _birthDateTextController,
          hint: AppText.lbl_birth_date,
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
          AppText.msg_do_you_have_any,
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
          AppText.msg_personalize_you,
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 6.h),
        Text(
          AppText.msg_what_are_your_treatment,
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
            AppText.msg_during_your_massage,
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
          AppText.msg_do_you_have_any2,
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
          AppText.lbl_guardian_name,
          style: CustomTextStyles.titleMediumOnPrimary_1,
        ),
        SizedBox(height: 6.h),
        Text(
          AppText.msg_required_for_quests,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 9.h),
        DefaultTextFormField(
          currentController: _guardianNameController,
          hint: '',
          maxLines: 3,
          isRequired: false,
          currentFocusNode: _guardianNameFocusNode,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return DefaultButton(
      label: AppText.lbl_save,
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      onPressed: () async {
        if (_isFormValid())
          await addMedicalForm(MedicalForm(
            birthDate: _birthDateTextController.text.parseDate(),
            conditions: state.selectedConditions,
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

  bool _isFormValid() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }

  void saveSelectedConditions(List<MedicalCondition>? conditions) {

    if (conditions == null) return;

    setState(() {
      state = state.copyWith(
          selectedConditions: conditions,
          //status: MedicalFormStateStatus.conditionSaved
      );
          _conditionsController.text = state.selectedConditions?.map((e)=> e.localizedName(context)).join(',') ?? '';
    });
  }

  Future<void> getConditions() async {
    setState(() {
      state = state.copyWith(status: MedicalFormStateStatus.loading);
    });

    try {
      final conditions = await _medicalFormRepo.getConditions();
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.loadedCondition,
            conditions: conditions);
      });
    } on RedundantRequestException catch (e) {
      logger.error(e.toString());
    } catch (e) {
      logger.error('$runtimeType', e);
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.error, errorMessage: e.toString());
      });
      showSnackBar(context, message: state.errorMessage);
    }
  }

  Future<void> getMedicalForm() async {
    setState(() {
      state = state.copyWith(status: MedicalFormStateStatus.loading);
    });
    try {
      final medicalForm = await _medicalFormRepo.getMedicalForm();
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.getMedicalForm,
            medicalForm: medicalForm);
      });
    } on RedundantRequestException catch (e) {
      logger.error(e.toString());
    } catch (e) {
      logger.error('$runtimeType', e);
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.error, errorMessage: e.toString());
      });
      showSnackBar(context, message: state.errorMessage);
    }
  }

  Future<void> addMedicalForm(MedicalForm? medicalForm) async {
    if (medicalForm == null) return;

    /*setState(() {
      state = state.copyWith(status: MedicalFormStateStatus.loading);
    });*/
    try {
      final addMedicalForm = await _medicalFormRepo.addMedicalForm(medicalForm);
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.loaded, medicalForm: addMedicalForm);
      });
      showSnackBar(context, message: AppText.msg_medical_form);
      NavigatorHelper.of(context).pop();
    } on RedundantRequestException catch (e) {
      logger.error(e.toString());
    } catch (e) {
      logger.error('[$runtimeType]', e);
      setState(() {
        state = state.copyWith(
            status: MedicalFormStateStatus.error, errorMessage: e.toString());
      });
      showSnackBar(context, message: state.errorMessage);
    }
  }

  void clear() {
    setState(() {
      state = state.copyWith(selectedConditions: []);
    });
  }

  Future<void> openMedicalConditionsPage(BuildContext context) async {
    List<MedicalCondition>? result = await NavigatorHelper.of(context).push(MaterialPageRoute(
      builder: (context) => MedicalConditionScreen(state),
    ));
    //
    if(result == null) return;

    saveSelectedConditions(result);
  }
}
