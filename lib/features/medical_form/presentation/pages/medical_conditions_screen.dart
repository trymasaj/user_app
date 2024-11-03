import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';
import 'package:masaj/features/medical_form/presentation/bloc/medical_form_bloc/medical_form_state.dart';

class MedicalConditionScreen extends StatefulWidget {
  MedicalFormState state;

  MedicalConditionScreen(this.state, {super.key});

  @override
  State<MedicalConditionScreen> createState() => _MedicalConditionScreenState();
}

class _MedicalConditionScreenState extends State<MedicalConditionScreen> {
  Map<int, MedicalCondition> _selectedConditions = {};

  @override
  void initState() {
    final selectedConditions = widget.state.selectedConditions;
    final Map<int, MedicalCondition> map = {};
    selectedConditions?.forEach((e) => map.putIfAbsent(e.id!, () => e));
    _selectedConditions.addAll(map);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.lbl_conditions),
      body: Builder(
        builder: (context) {
          if (widget.state.status == MedicalFormStateStatus.loading)
            return const CustomLoading();
          final conditions = widget.state.conditions ?? [];
          if (conditions.isEmpty &&
              widget.state.status != MedicalFormStateStatus.loading)
            return const EmptyPageMessage(
              heightRatio: 0.65,
            );
          return CustomAppPage(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _buildConditionItem(context, conditions[index]);
                      },
                      itemCount: widget.state.conditions?.length,
                    ),
                  ),
                  DefaultButton(
                    label: AppText.lbl_save,
                    isExpanded: true,
                    onPressed: () {
                      NavigatorHelper.of(context)
                          .pop(_selectedConditions.values.toList());
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConditionItem(BuildContext context, MedicalCondition medicalCondition) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SubtitleText(text: medicalCondition.localizedName(context)),
          const Spacer(),
          Checkbox.adaptive(
              activeColor: AppColors.PRIMARY_COLOR,
              value: checkConditionIdChecked(medicalCondition.id),
              onChanged: (value) {
                setState(() {
                  if (value ?? false) {
                    _selectedConditions.putIfAbsent(
                        medicalCondition.id ?? 0, () => medicalCondition);
                  } else {
                    _selectedConditions.remove(medicalCondition.id);
                  }
                });
              })
        ],
      ),
    );
  }

  bool checkConditionIdChecked(int? id) {
    return _selectedConditions.containsKey(id);
  }
}
