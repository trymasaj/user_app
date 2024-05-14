import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';

import '../bloc/medical_form_bloc/medical_form_bloc.dart';

class MedicalConditionScreen extends StatelessWidget {
  const MedicalConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalFormBloc, MedicalFormState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'lbl_conditions'),
          body: CustomAppPage(
            child: Column(
              children: [
                ListView.builder(itemBuilder: (context, index) {
                  return _buildConditionItem();
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConditionItem() {
    return Container();
  }
}
