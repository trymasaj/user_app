import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
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
        create: (context) => ConditionsBloc(ConditionsState.initial()),
        child: ConditionsScreen());
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
    return AppBar(
      title: Text("msg_select_conditions".tr()),
    );
  }

  /// Section Widget
  Widget _buildDoneButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_done".tr(),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        onPressed: () {});
  }
}
