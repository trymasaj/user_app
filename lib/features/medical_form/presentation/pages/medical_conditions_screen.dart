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

import '../bloc/medical_form_bloc/medical_form_bloc.dart';

class MedicalConditionScreen extends StatefulWidget {
  const MedicalConditionScreen({super.key});

  @override
  State<MedicalConditionScreen> createState() => _MedicalConditionScreenState();
}

class _MedicalConditionScreenState extends State<MedicalConditionScreen> {
  Map<int, MedicalCondition> _selectedConditions = {};

  @override
  void initState() {
    final selectedConditions =
        context.read<MedicalFormBloc>().state.selectedConditions;
    final Map<int, MedicalCondition> map = {};
    selectedConditions?.map((e) => map.putIfAbsent(e.id!, () => e)).toList();
    _selectedConditions.addAll(map);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'lbl_conditions'),
      body: BlocBuilder<MedicalFormBloc, MedicalFormState>(
        builder: (context, state) {
          if (state.status == MedicalFormStateStatus.loading)
            return const CustomLoading();
          final conditions = state.conditions ?? [];
          if (conditions.isEmpty &&
              state.status != MedicalFormStateStatus.loading)
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
                        return _buildConditionItem(conditions[index]);
                      },
                      itemCount: state.conditions?.length,
                    ),
                  ),
                  DefaultButton(
                    isExpanded: true,
                    onPressed: () {
                      context.read<MedicalFormBloc>().saveSelectedConditions(
                          _selectedConditions.values.toList());
                      NavigatorHelper.of(context).pop();
                    },
                    label: 'lbl_save',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConditionItem(MedicalCondition medicalCondition) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SubtitleText(text: medicalCondition.nameEn ?? ''),
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
