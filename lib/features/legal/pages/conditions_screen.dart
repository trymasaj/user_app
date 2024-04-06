import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/legal/bloc/conditions_bloc/conditions_bloc.dart';
import 'package:masaj/features/legal/widgets/conditionslist_item_widget.dart';

class ConditionsScreen extends StatelessWidget {
  static const routeName = '/conditions';

  const ConditionsScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ConditionsBloc>(
        create: (context) => ConditionsBloc(ConditionsState.initial()),
        child: const ConditionsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: BlocBuilder<ConditionsBloc, ConditionsState>(
              builder: (context, state) {
                return ListView.separated(
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
                    itemCount: state.conditions.length,
                    itemBuilder: (context, index) {
                      final item = state.conditions[index];
                      return ConditionsListItem(item);
                    });
              },
            ),
            bottomNavigationBar: _buildDoneButton(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const CustomAppBar(
      title: 'msg_select_conditions',
    );
  }

  /// Section Widget
  Widget _buildDoneButton(BuildContext context) {
    return CustomElevatedButton(
        text: 'lbl_done'.tr(),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        onPressed: () {});
  }
}
